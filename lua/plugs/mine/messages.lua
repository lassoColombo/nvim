return {
  dir = vim.fn.stdpath 'config' .. '/lua/messages',
  name = 'messages',
  event = 'VimEnter',
  config = function()
    require('messages').setup()
  end,
}
