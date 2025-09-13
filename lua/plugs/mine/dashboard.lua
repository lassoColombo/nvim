return {
  dir = vim.fn.stdpath 'config' .. '/lua/dashboard',
  name = 'dashboard',
  config = function()
    require('dashboard').setup()
  end,
}
