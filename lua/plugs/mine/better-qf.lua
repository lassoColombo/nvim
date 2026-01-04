return {
  dir = vim.fn.stdpath 'config' .. '/lua/bqf/',
  name = 'better-qf',
  config = function()
    require('better-qf').setup()
  end,
}
