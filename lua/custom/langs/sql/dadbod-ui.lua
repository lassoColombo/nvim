return {
  'kristijanhusak/vim-dadbod-ui',
  event = 'VeryLazy',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
  },
  ft = { 'sql', 'mysql', 'plsql', 'mongo', 'redis' },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_table_helpers = {
      mongo_db = {
        Count = 'select count(*) from "{table}"',
      },
    }
  end,
  keys = {
    {
      '<leader><leader>b',
      '<cmd>DBUIToggle<cr>',
      mode = 'n',
      ft = { 'sql', 'mysql', 'plsql', 'mongo', 'redis' },
      desc = '[T]oggle [D]ata[B]ase UI',
    },
  },
}
