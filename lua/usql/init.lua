-- usql — keep the sqls language server on the connection a query file belongs to.
--
-- The queries directory ($USQL_QUERIES, the `usql` Nushell module's convention)
-- binds a file to a connection through its top-level folder: anything under
-- `<alias>/` targets the connection `<alias>`. Files elsewhere take the session
-- default (`:Usql <alias>` or $USQL_CONNECTION, which `usql query editor -c`
-- exports) and are otherwise left on whatever the server is using.
--
-- sqls keeps ONE current connection per server process, so this is a sync, not a
-- per-buffer setting: every time an sqls buffer is entered, the wanted alias is
-- derived and, only if it differs from the server's current one, a
-- `switchConnections` request is sent (sqls accepts the alias string; a switch
-- reconnects and re-caches the schema, hence the "only if it differs").
--
-- The server is the source of truth for which aliases exist: they are read with
-- `showConnections` when a client first attaches, so this never parses sqls's
-- config.yml and cannot disagree with what the server actually loaded.

local M = {}

---@class usql.State
---@field aliases table<string, integer>   alias -> 1-based index in the server's config
---@field order string[]                   aliases in config order
---@field current? string                  alias the server is on, as far as we know
---@field pending? string                  alias of an in-flight switch
---@field warned table<string, true>       problems already reported for this client

---@type table<integer, usql.State>  keyed by client id
local states = {}

local AUGROUP = 'usql'

local function notify(msg, level)
  vim.notify('usql: ' .. msg, level or vim.log.levels.INFO)
end

-- Report `key` once per client, so a missing alias or a failing switch does not
-- nag on every BufEnter.
local function warn_once(st, key, msg)
  if st.warned[key] then
    return
  end
  st.warned[key] = true
  notify(msg, vim.log.levels.WARN)
end

---@return string
local function queries_root()
  local root = vim.env.USQL_QUERIES
  if not root or root == '' then
    root = vim.fs.joinpath(vim.env.HOME, '.config', 'usql', 'queries')
  end
  return vim.uv.fs_realpath(root) or vim.fs.normalize(root)
end

-- The top-level folder of `path` under `root`, or nil when the file is not
-- inside the queries directory (or sits at its top level).
---@param path string
---@param root string
---@return string?
function M._folder_of(path, root)
  if path == '' then
    return nil
  end
  local real = vim.uv.fs_realpath(path) or vim.fs.normalize(path)
  local rel = vim.fs.relpath(root, real)
  if not rel then
    return nil
  end
  return rel:match '^([^/]+)/'
end

-- sqls's `showConnections` answers one `<index> <driver> <alias> <desc>` line per
-- connection. Returns alias -> index and the aliases in order.
---@param text string
---@return table<string, integer>, string[]
function M._parse_connections(text)
  local aliases, order = {}, {}
  for line in vim.gsplit(text or '', '\n', { plain = true }) do
    local index, alias = line:match '^(%d+)%s+%S+%s+(%S+)'
    if index then
      aliases[alias] = tonumber(index)
      order[#order + 1] = alias
    end
  end
  return aliases, order
end

-- The alias a buffer wants, and why ('folder' | 'default'); nil when the
-- buffer has no opinion.
---@param st usql.State
---@param buf integer
---@return string?, string?
local function wanted(st, buf)
  local folder = M._folder_of(vim.api.nvim_buf_get_name(buf), queries_root())
  if folder and st.aliases[folder] then
    return folder, 'folder'
  end
  local default = vim.g.usql_connection
  if default == nil or default == '' then
    default = vim.env.USQL_CONNECTION
  end
  if default and default ~= '' then
    if st.aliases[default] then
      return default, 'default'
    end
    warn_once(st, 'default:' .. default, ('default connection %q is not configured in sqls'):format(default))
  end
  return nil
end

---@param client vim.lsp.Client
---@param st usql.State
---@param alias string
---@param buf integer
local function switch(client, st, alias, buf)
  if st.current == alias or st.pending == alias then
    return
  end
  st.pending = alias
  client:request('workspace/executeCommand', { command = 'switchConnections', arguments = { alias } }, function(err)
    st.pending = nil
    if err then
      warn_once(st, 'switch:' .. alias, ('could not switch to %s: %s'):format(alias, err.message))
      return
    end
    st.current = alias
    vim.api.nvim_exec_autocmds('User', { pattern = 'UsqlConnection', data = { alias = alias, client_id = client.id } })
  end, buf)
end

-- Point the client at what `buf` wants, if anything.
---@param client vim.lsp.Client
---@param buf integer
local function sync(client, buf)
  local st = states[client.id]
  if not st or not vim.api.nvim_buf_is_valid(buf) then
    return
  end
  local alias = wanted(st, buf)
  if alias then
    switch(client, st, alias, buf)
  end
end

-- First contact with a client: learn its aliases, then sync the buffer. The
-- server starts on its first configured connection, which is `order[1]`.
---@param client vim.lsp.Client
---@param buf integer
local function adopt(client, buf)
  if states[client.id] then
    sync(client, buf)
    return
  end
  local st = { aliases = {}, order = {}, warned = {} }
  states[client.id] = st
  client:request('workspace/executeCommand', { command = 'showConnections' }, function(err, result)
    if err then
      warn_once(st, 'show', 'could not list connections: ' .. err.message)
      return
    end
    st.aliases, st.order = M._parse_connections(result)
    st.current = st.order[1]
    sync(client, buf)
  end, buf)
end

---@param buf integer
---@return vim.lsp.Client?
local function sqls_client(buf)
  return vim.lsp.get_clients({ bufnr = buf, name = 'sqls' })[1]
end

-- The alias the sqls server attached to `buf` is on (nil when unknown).
---@param buf? integer
---@return string?
function M.current(buf)
  local client = sqls_client(buf or 0)
  local st = client and states[client.id]
  return st and st.current or nil
end

-- Make `alias` the session default (overrides $USQL_CONNECTION) and apply it
-- to the current buffer. Without an alias, pick one from the server's list.
---@param alias? string
function M.use(alias)
  local buf = vim.api.nvim_get_current_buf()
  local client = sqls_client(buf)
  local st = client and states[client.id]
  if not st then
    notify('no sqls server attached to this buffer', vim.log.levels.WARN)
    return
  end
  local function apply(choice)
    if not choice then
      return
    end
    if not st.aliases[choice] then
      notify(('%q is not a configured connection'):format(choice), vim.log.levels.ERROR)
      return
    end
    vim.g.usql_connection = choice
    st.warned = {}
    sync(client, buf)
  end
  if alias and alias ~= '' then
    apply(alias)
  else
    vim.ui.select(st.order, { prompt = 'usql connection' }, apply)
  end
end

function M.setup()
  local group = vim.api.nvim_create_augroup(AUGROUP, { clear = true })

  vim.api.nvim_create_autocmd('LspAttach', {
    group = group,
    desc = 'usql: adopt sqls clients',
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if client and client.name == 'sqls' then
        adopt(client, ev.buf)
      end
    end,
  })

  vim.api.nvim_create_autocmd('BufEnter', {
    group = group,
    desc = 'usql: sync the sqls connection to the entered buffer',
    callback = function(ev)
      local client = sqls_client(ev.buf)
      if client then
        sync(client, ev.buf)
      end
    end,
  })

  -- A manual `:SqlsSwitchConnection` picks "<index> <driver> <alias> <desc>".
  vim.api.nvim_create_autocmd('User', {
    group = group,
    pattern = 'SqlsConnectionChoice',
    desc = 'usql: track manual connection switches',
    callback = function(ev)
      local choice = ev.data and ev.data.choice or ''
      local alias = choice:match '^%d+%s+%S+%s+(%S+)'
      for _, st in pairs(states) do
        st.current = alias or st.current
      end
    end,
  })

  vim.api.nvim_create_user_command('Usql', function(cmd)
    M.use(cmd.args)
  end, {
    nargs = '?',
    desc = 'usql: set the default sqls connection (alias, or pick one)',
    complete = function(lead)
      local client = sqls_client(vim.api.nvim_get_current_buf())
      local st = client and states[client.id]
      return vim.tbl_filter(function(a)
        return vim.startswith(a, lead)
      end, st and st.order or {})
    end,
  })

  -- Clients that attached before this ran (plugin load order is not ours to pick).
  for _, client in ipairs(vim.lsp.get_clients { name = 'sqls' }) do
    for buf in pairs(client.attached_buffers) do
      adopt(client, buf)
    end
  end
end

return M
