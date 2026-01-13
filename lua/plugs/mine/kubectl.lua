return {
  dir = vim.fn.stdpath 'config' .. '/lua/kubectl/',
  ft = 'yaml',
  name = 'kubectl',
  event = 'VimEnter',
  config = function() end,
  keys = {
    {
      '<leader><leader>kr',
      require('kubectl').replace,
      mode = { 'n', 'v' },
      desc = '[K]ubectl [R]eplace',
      ft = 'yaml',
    },
    {
      '<leader><leader>kd',
      require('kubectl').delete,
      mode = { 'n', 'v' },
      desc = '[K]ubectl [D]elete',
      ft = 'yaml',
    },
    {
      '<leader><leader>ka',
      require('kubectl').apply,
      mode = { 'n', 'v' },
      desc = '[K]ubectl [A]pply',
      ft = 'yaml',
    },
  },
}
