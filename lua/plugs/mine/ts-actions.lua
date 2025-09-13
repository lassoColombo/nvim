return {
  dir = vim.fn.stdpath 'config' .. '/lua/ts-actions',
  name = 'ts-actions',
  config = function()
    require('ts-actions').setup()
  end,
}
