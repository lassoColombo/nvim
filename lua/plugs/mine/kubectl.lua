return {
  dir = vim.fn.stdpath 'config' .. '/lua/kubectl/',
  name = 'kubectl',
  event = 'VimEnter',
  keys = {
    {
      '<leader><leader>k',
      require('kubectl').apply,
      mode = { 'n', 'v' },
      desc = '[K]ubectl apply',
      ft = 'yaml',
    },
  },
}
