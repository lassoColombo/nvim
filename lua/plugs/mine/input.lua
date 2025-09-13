return {
  dir = vim.fn.stdpath 'config' .. '/lua/input',
  name = 'input',
  config = function()
    require('input').setup()
  end,
}
