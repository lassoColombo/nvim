-- sqls, fed from the usql connections instead of its own ~/.config/sqls/config.yml.
--
-- usql's config.yaml is the single source of connections; `usql config
-- translate-to sqls` renders it in sqls's format. Doing that here, right before
-- the server process is spawned, means there is no file to regenerate by hand
-- and sqls can never be out of step with usql. `-config <file>` is sqls's
-- highest-precedence source and is read at process start, so the aliases are
-- complete before the first request (no race with workspace settings).
--
-- When the translation fails (no nu, no usql module, …) sqls starts bare and
-- falls back to its user config, with one warning.

local CACHE = vim.fs.joinpath(vim.fn.stdpath 'cache', 'usql', 'sqls.yml')

-- The session default (`:Usql`, or $USQL_CONNECTION as exported by `usql query
-- editor`), if any: it goes first in the rendered config, because sqls connects
-- to its first entry on startup.
---@return string?
local function default_alias()
  local alias = vim.g.usql_connection
  if alias == nil or alias == '' then
    alias = vim.env.USQL_CONNECTION
  end
  if alias ~= nil and alias ~= '' then
    return alias
  end
end

---@return string? path of the rendered config
local function render_config()
  local script = 'usql config translate-to sqls'
  local first = default_alias()
  if first then
    script = script .. ' --first ' .. vim.fn.shellescape(first)
  end
  local res = vim.system({ 'nu', '-l', '-c', script }, { text = true }):wait()
  if res.code ~= 0 or not res.stdout or res.stdout == '' then
    vim.notify('sqls: could not render connections from usql, using sqls own config\n' .. (res.stderr or ''), vim.log.levels.WARN)
    return nil
  end
  vim.fn.mkdir(vim.fs.dirname(CACHE), 'p')
  vim.fn.writefile(vim.split(res.stdout, '\n', { trimempty = true }), CACHE)
  vim.uv.fs_chmod(CACHE, 384) -- 0600: it holds passwords
  return CACHE
end

---@type vim.lsp.Config
return {
  cmd = function(dispatchers, config)
    local cmd = { 'sqls' }
    local rendered = render_config()
    if rendered then
      vim.list_extend(cmd, { '-config', rendered })
    end
    return vim.lsp.rpc.start(cmd, dispatchers, { cwd = config.cmd_cwd, env = config.cmd_env })
  end,
}
