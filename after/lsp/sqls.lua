-- sqls on the connection a query file belongs to.
--
-- The `usql` Nushell module keeps its queries in `queries` beside usql's
-- config.yaml ($USQL_CONFIG); a top-level folder named like a connection holds
-- that connection's queries. A buffer under `<queries>/<folder>/` gets its own
-- sqls server (root_dir = the folder) started on exactly one connection: the
-- folder's, else $USQL_CONNECTION (what `usql query edit -C` exports). The
-- config is rendered here, right before the process spawns, from what usql
-- itself loaded (`usql -X -c '\cset'`), so there is no file to regenerate and
-- no connection switching to track. Anything else (a file outside the
-- queries dir with no $USQL_CONNECTION, a folder that is not a connection,
-- usql failing, a driver sqls lacks) starts sqls bare, on its own
-- ~/.config/sqls/config.yml, with a warning when something was asked for.

local CACHE_DIR = vim.fs.joinpath(vim.fn.stdpath 'cache', 'usql')

-- usql's scheme aliases for the three drivers both tools speak.
local DRIVERS = {}
for driver, schemes in pairs {
  postgresql = { 'postgres', 'postgresql', 'pg', 'pgsql', 'pgx', 'px' },
  mysql = { 'mysql', 'my', 'mariadb', 'maria', 'percona', 'aurora' },
  sqlite3 = { 'sqlite3', 'sqlite', 'sq', 'moderncsqlite', 'modernsqlite', 'mq' },
} do
  for _, scheme in ipairs(schemes) do
    DRIVERS[scheme] = driver
  end
end

-- `queries` beside usql's config file: $USQL_CONFIG, else usql's own default
-- under the OS user config dir (Go's os.UserConfigDir).
---@return string
local function queries_root()
  local config = vim.env.USQL_CONFIG
  if not config or config == '' then
    local base
    if vim.fn.has 'mac' == 1 then
      base = vim.fs.joinpath(vim.env.HOME, 'Library', 'Application Support')
    elseif vim.fn.has 'win32' == 1 then
      base = vim.env.APPDATA
    else
      base = vim.env.XDG_CONFIG_HOME
      if not base or base == '' then
        base = vim.fs.joinpath(vim.env.HOME, '.config')
      end
    end
    config = vim.fs.joinpath(base, 'usql', 'config.yaml')
  end
  local root = vim.fs.joinpath(vim.fs.dirname(vim.fs.normalize(config)), 'queries')
  return vim.uv.fs_realpath(root) or root
end

-- The top-level folder `path` sits under in the queries dir, or nil (outside
-- it, or at its top level).
---@param path string
---@return string?
local function query_folder(path)
  if path == '' then
    return nil
  end
  local root = queries_root()
  local rel = vim.fs.relpath(root, vim.uv.fs_realpath(path) or vim.fs.normalize(path))
  local name = rel and rel:match '^([^/]+)/'
  return name and vim.fs.joinpath(root, name) or nil
end

-- usql's connections as alias -> url: `\cset` prints `name = 'url'` per line.
---@return table<string, string>? urls, string? error
local function connections()
  local res = vim.system({ 'usql', '-X', '-c', [[\cset]] }, { text = true }):wait()
  if res.code ~= 0 then
    return nil, 'usql: ' .. vim.trim(res.stderr or '')
  end
  local urls = {}
  for line in vim.gsplit(res.stdout or '', '\n', { plain = true }) do
    local alias, url = line:match "^([^ =]+) = '(.*)'$"
    if alias then
      urls[alias] = url
    end
  end
  return urls
end

local function unescape(s)
  return (s:gsub('%%(%x%x)', function(hex)
    return string.char(tonumber(hex, 16))
  end))
end

-- One usql url as an sqls connection entry, nil when sqls has no driver for
-- its scheme. A file driver's url is `sqlite3:/x.db`, `sqlite3:x.db` or
-- `sqlite3://x.db` alike; a network one `scheme://user:pass@host:port/db?opts`
-- (the userinfo ends at the last `@`). Empty fields are left out: sqls
-- chokes on null.
---@param alias string
---@param url string
---@return table?
local function entry(alias, url)
  local scheme, rest = url:match '^([%w+.-]+):(.*)$'
  local driver = scheme and DRIVERS[scheme:lower()]
  if not driver then
    return nil
  end
  if driver == 'sqlite3' then
    return { alias = alias, driver = driver, dataSourceName = (rest:gsub('^//', '')):match '^[^?]*' }
  end
  local authority, path, query = rest:match '^//([^/?]*)([^?]*)%??(.*)$'
  if not authority then
    return nil
  end
  local userinfo, hostport = authority:match '^(.*)@(.*)$'
  local user, pass = (userinfo or ''):match '^([^:]*):?(.*)$'
  local host, port = (hostport or authority):match '^(.*):(%d+)$'
  local e = {
    alias = alias,
    driver = driver,
    proto = 'tcp',
    user = unescape(user),
    passwd = unescape(pass),
    host = host or hostport or authority,
    port = tonumber(port),
    dbName = unescape(path:sub(2)),
  }
  for k, v in query:gmatch '([^&=]+)=([^&]*)' do
    e.params = e.params or {}
    e.params[unescape(k)] = unescape(v)
  end
  for k, v in pairs(e) do
    if v == '' then
      e[k] = nil
    end
  end
  return e
end

-- An sqls config holding the first of `candidates` that is a usql connection,
-- written 0600 under the cache dir. nil (no error) when none is.
---@param candidates string[]
---@return string? file, string? error
local function render(candidates)
  local urls, err = connections()
  if not urls then
    return nil, err
  end
  for _, alias in ipairs(candidates) do
    local url = urls[alias]
    if url then
      local e = entry(alias, url)
      if not e then
        return nil, ('sqls has no driver for %s (%s)'):format(alias, url:match '^[%w+.-]+' or '?')
      end
      vim.fn.mkdir(CACHE_DIR, 'p')
      local file = vim.fs.joinpath(CACHE_DIR, alias .. '.yml')
      -- JSON is YAML, so nothing needs quoting by hand.
      local fd, open_err = vim.uv.fs_open(file, 'w', 384) -- 0600: it holds a password
      if not fd then
        return nil, open_err
      end
      vim.uv.fs_write(fd, vim.json.encode { lowercaseKeywords = true, connections = { e } })
      vim.uv.fs_close(fd)
      return file
    end
  end
  return nil
end

---@type vim.lsp.Config
return {
  root_dir = function(bufnr, on_dir)
    on_dir(query_folder(vim.api.nvim_buf_get_name(bufnr)) or vim.fs.root(bufnr, { 'config.yml' }))
  end,
  cmd = function(dispatchers, config)
    local candidates = {}
    if config.root_dir and vim.fs.dirname(config.root_dir) == queries_root() then
      candidates[1] = vim.fs.basename(config.root_dir)
    end
    if vim.env.USQL_CONNECTION and vim.env.USQL_CONNECTION ~= '' then
      candidates[#candidates + 1] = vim.env.USQL_CONNECTION
    end
    local cmd = { 'sqls' }
    local file, err = render(candidates)
    if file then
      vim.list_extend(cmd, { '-config', file })
    elseif err then
      vim.notify('sqls: starting on its own config, usql connection unavailable: ' .. err, vim.log.levels.WARN)
    end
    return vim.lsp.rpc.start(cmd, dispatchers, { cwd = config.cmd_cwd, env = config.cmd_env })
  end,
}
