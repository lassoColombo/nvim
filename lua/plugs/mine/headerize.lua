return {
  dir = vim.fn.stdpath 'config' .. '/lua/headerize',
  name = 'headerize',
  keys = {
    {
      '<leader><leader>h',
      require('headerize').make_header,
      mode = { 'n', 'v' },
      desc = '[H]eaderize',
    },
  },
}
