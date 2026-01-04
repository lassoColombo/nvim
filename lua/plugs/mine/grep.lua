return {
  dir = vim.fn.stdpath 'config' .. '/lua/grep/',
  name = 'grep',
  config = function()
    require('grep').setup()
  end,
  lazy = false,
}
