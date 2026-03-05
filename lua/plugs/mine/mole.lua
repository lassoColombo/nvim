return {
  dir = vim.fn.stdpath 'config' .. '/lua/mole',
  name = 'mole',
  keys = {
    {
      '<leader><leader>r',
      function() require('mole').run() end,
      mode = 'n',
      ft = { 'sql' },
      desc = '[R]un [M]ole',
    },
  },
}
