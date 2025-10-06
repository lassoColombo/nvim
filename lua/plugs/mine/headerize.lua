return {
  dir = vim.fn.stdpath 'config' .. '/lua/headerize',
  name = 'headerize',
  keys = {
    {
      '<leader><leader>h',
      function()
        require('headerize').make_header()
      end,
      mode = { 'n', 'v' },
      desc = '[H]eaderize',
    },
  },
}
