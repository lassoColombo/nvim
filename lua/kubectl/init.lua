local M = {}

-- The visual selection (any visual mode) or, in normal mode, the whole buffer. Either
-- way it goes to kubectl on stdin, so what is applied is what you see, saved or not.
local function manifest()
  local mode = vim.fn.mode()
  if mode == 'v' or mode == 'V' or mode == '\22' then
    return vim.fn.getregion(vim.fn.getpos 'v', vim.fn.getpos '.', { type = mode })
  end
  return vim.api.nvim_buf_get_lines(0, 0, -1, false)
end

local function run(method)
  local result = vim.fn.systemlist({ 'kubectl', method, '-f', '-' }, manifest())
  local level = vim.v.shell_error == 0 and vim.log.levels.INFO or vim.log.levels.ERROR
  vim.notify(table.concat(result, '\n'), level, { title = 'kubectl ' .. method })
end

M.apply = function()
  run 'apply'
end

M.replace = function()
  run 'replace'
end

M.delete = function()
  run 'delete'
end

return M
