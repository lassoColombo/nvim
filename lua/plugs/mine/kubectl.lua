return {
  dir = vim.fn.stdpath 'config' .. '/lua/kubectl/',
  name = 'kubectl',
  event = 'VimEnter',
  keys = {
    {
      '<leader><leader>kr',
      require('kubectl').apply,
      mode = { 'n', 'v' },
      desc = '[K]ubectl [R]eplace',
      ft = 'yaml',
    },
    {
      '<leader><leader>kd',
      require('kubectl').apply,
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
