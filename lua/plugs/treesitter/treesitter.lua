return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  ref = 'main',
  build = ':TSUpdate',

  keys = {
    {
      '<leader><leader>ni',
      '<cmd>InspectTree<CR>',
      mode = 'n',
      desc = '[T]treesitter [I]nspectTree',
    },
  },
  config = function()
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup {
      ensure_installed = require 'plugs.treesitter.ensure-installed',
      -- Autoinstall languages that are not installed
      auto_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      autotag = {
        enable = true,
        filetypes = { 'html', 'xml', 'tsx', 'typescript', 'typescriptreact' },
      },
      incremental_selection = {
        enable = false,
        keymaps = {
          init_selection = '<space>V',
          node_incremental = '<C-N>',
          scope_incremental = '<C-o>',
          node_decremental = '<C-P>',
        },
      },
    }
  end,
}
