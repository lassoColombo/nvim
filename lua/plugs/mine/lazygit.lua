return {
  dir = vim.fn.stdpath 'config' .. '/lua/lazygit',
  name = 'lazygit',
  keys = {
    {
      '<leader>gg',
      function()
        require('lazygit').open()
      end,
      desc = 'Open Lazygit (float)',
    },
  },
}
