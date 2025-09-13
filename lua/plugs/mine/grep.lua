return {
  dir = vim.fn.stdpath 'config' .. '/lua/grep/',
  name = 'grep',
  event = 'VimEnter',
  config = function()
    require('grep').setup()
  end,
}
