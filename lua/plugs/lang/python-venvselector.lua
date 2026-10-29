return {
  'linux-cultist/venv-selector.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    'nvim-telescope/telescope.nvim',
  },
  ft = 'python', -- Load when opening Python files
  keys = {
    {
      '<leader><leader>v',
      '<cmd>VenvSelect<cr>',
      mode = 'n',
      ft = { 'python' },
      desc = 'Select [V]env',
    },
  },
  opts = {},
}
