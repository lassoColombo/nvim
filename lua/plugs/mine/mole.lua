return {
  dir = vim.fn.stdpath 'config' .. '/lua/mole',
  name = 'mole',
  keys = {
    {
      '<leader><leader>r',
      require('mole').run(),
      mode = 'n',
      ft = { 'sql' },
      desc = '[R]un [M]ole',
    },
  },
}
