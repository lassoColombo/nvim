return {
  dir = vim.fn.stdpath 'config' .. '/lua/bqf/',
  name = 'bqf',
  config = function()
    require('bqf').setup()
  end,
}
