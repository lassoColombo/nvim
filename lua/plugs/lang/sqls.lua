return {
  'nanotee/sqls.nvim',
  ft = { 'sql' },
  keys = {
    {
      '<leader><leader>x',
      '<cmd>SqlsExecuteQuery<cr>',
      mode = 'n',
      ft = { 'sql' },
      desc = '[S]qls e[X]ecute',
    },
    {
      '<leader><leader>d',
      '<cmd>SqlsSwitchDatabase<cr>',
      mode = 'n',
      desc = '[S]qls switch [D]atabase',
      ft = { 'sql' },
    },
    {
      '<leader><leader>c',
      '<cmd>SqlsSwitchConnection<cr>',
      mode = 'n',
      ft = { 'sql' },
      desc = '[S]qls switch [C]onnection',
    },
  },
}
