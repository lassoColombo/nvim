return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  -- Load eagerly: mini.files (use_as_default_explorer) opens during startup when
  -- launching `nvim <dir>` and snapshots vim.ui.select before VeryLazy fires.
  -- On close it restores that snapshot, clobbering the telescope-ui-select override.
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  keys = {
    -- lsp searches
    { '\\r', '<cmd>Telescope lsp_references<cr>', desc = '[S]earch [R]eferences' },
    { '\\t', '<cmd>Telescope lsp_definitions<cr>', desc = '[S]earch [D]efinitions' },
    { '\\T', '<cmd>Telescope lsp_type_definitions<cr>', desc = '[S]earch type [D]efinitions' },
    { '\\i', '<cmd>Telescope lsp_implementations<cr>', desc = '[S]earch [I]mplementation' },
    { '\\s', '<cmd>Telescope lsp_document_symbols<cr>', desc = '[S]earch [S]ymbols (document)' },
    { '\\S', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', desc = '[S]earch [S]ymbols (workspace)' },
    { '\\D', '<cmd>Telescope diagnostics<cr>', desc = '[S]earch [D]iagnostics (workspace)' },
    { '\\d', '<cmd>Telescope diagnostics bufnr=0<cr>', desc = '[S]earch [D]iagnostics (buffer)' },
    -- grep searches
    {
      '\\w',
      function()
        require('telescope.builtin').grep_string { cwd = vim.fn.expand '%:p:h' }
      end,
      desc = '[S]earch current [W]ord (buffer)',
    },
    { '\\W', '<cmd>Telescope grep_string<cr>', desc = '[S]earch current [W]ord (workspace)' },
    { '\\g', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = '[S]earch [G]rep (buffer)' },
    { '\\G', '<cmd>Telescope live_grep<cr>', desc = '[S]earch [G]rep (workspace)' },
    -- file searches
    { '\\f', '<cmd>Telescope find_files<cr>', desc = '[S]earch [F]iles' },
    { '<C-f>', '<cmd>Telescope find_files<cr>', desc = '[S]earch [F]iles' },
    { '\\F', '<cmd>Telescope find_files hidden=true no_ignore=true<cr>', desc = '[S]earch [F]iles (hidden)' },
    { '<C-s>', '<cmd>Telescope find_files hidden=true no_ignore=true<cr>', desc = '[S]earch [F]iles (hidden)' },
    -- buffer searches
    { '\\\\', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = '[S]earch fuzzy buffer' },
    { '<C-b>', '<cmd>Telescope buffers<cr>', desc = '[S]earch [B]uffers' },
    { '\\b', '<cmd>Telescope buffers<cr>', desc = '[S]earch [B]uffers' },
    -- nvim searches
    { '\\nh', '<cmd>Telescope help_tags<cr>', desc = '[S]earch [H]elp' },
    { '\\nm', '<cmd>Telescope keymaps<cr>', desc = '[S]earch [K]eymaps' },
    {
      '\\nc',
      function()
        require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = '[S]earch [N]eovim files',
    },
    -- other searches
    { '\\R', '<cmd>Telescope resume<cr>', desc = '[S]earch [R]esume' },
  },
  config = function()
    -- local actions = require 'telescope.actions'
    require('telescope').setup {

      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown {},
        },
      },

      defaults = vim.tbl_extend('force', require('telescope.themes').get_ivy(), {
        layout_config = { height = 0.99 },
        mappings = {
          i = {
            ['<C-space>'] = 'toggle_selection',
            ['<C-t>'] = 'toggle_all',
          },
          n = {
            ['<C-space>'] = 'toggle_selection',
            ['<C-t>'] = 'toggle_all',
          },
        },
      }),
      pickers = {
        buffers = {
          mappings = {
            i = {
              ['<C-x>'] = 'delete_buffer',
            },
            n = {
              ['<C-d>'] = 'delete_buffer',
            },
          },
        },
      },
      -- vimgrep_arguments = {
      --   'rg',
      --   '--color=never',
      --   '--no-heading',
      --   '--with-filename',
      --   '--line-number',
      --   '--column',
      --   '--smart-case',
      --   '--hidden',
      -- },
    }
    require('telescope').load_extension 'ui-select'
  end,
}
