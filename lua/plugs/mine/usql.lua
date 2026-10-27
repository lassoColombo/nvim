return {
  dir = vim.fn.stdpath 'config' .. '/lua/usql/',
  name = 'usql',
  ft = 'sql',
  config = function()
    require('usql').setup()
  end,
}
