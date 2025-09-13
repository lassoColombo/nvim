return {
  dir = vim.fn.stdpath 'config' .. '/lua/lazygit',
  name = 'lazygit',
  keys = {
    {
      '<leader>g',
      function()
        require('lazygit').open()
      end,
      desc = 'Open Lazygit (float)',
    },
  },
}
