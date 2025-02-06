local M = {}

M.copyfile = function(path)
  local file = io.open(path, 'r')
  if not file then
    vim.notify('file ' .. file .. 'does not exist 🔴', vim.log.levels.ERROR)
    return
  end
  local fileContent = file:read '*a'
  file:close()
  vim.fn.setreg('"', fileContent)
  vim.notify('copied file to clipboard 📋', vim.log.levels.INFO)
end

return M
