return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    local actions = require 'telescope.actions'
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
    local builtin = require 'telescope.builtin'
    local telescope = require 'telescope.builtin'

    -- lsp searches
    vim.keymap.set('n', '\\r', telescope.lsp_references, { desc = '\\S]earch [R]eferences' })
    vim.keymap.set('n', '\\t', telescope.lsp_definitions, { desc = '\\S]earch [D]efinitions' })
    vim.keymap.set('n', '\\T', telescope.lsp_type_definitions, { desc = '\\S]earch type [D]efinitions' })
    vim.keymap.set('n', '\\i', telescope.lsp_implementations, { desc = '\\S]earch [I]mplementation' })
    vim.keymap.set('n', '\\s', telescope.lsp_document_symbols, { desc = '\\S]earc [S]ymbols (document)' })
    vim.keymap.set('n', '\\S', telescope.lsp_dynamic_workspace_symbols, { desc = '\\S]earch [S]ymbols (workspace)' })
    vim.keymap.set('n', '\\D', telescope.diagnostics, { desc = '\\S]earch [D]iagnostics (workspace)' })
    vim.keymap.set('n', '\\d', function()
      telescope.diagnostics { bufnr = 0 }
    end, { desc = '\\S]earch [D]iagnostics (buffer)' })
    -- grep searches
    vim.keymap.set('n', '\\w', function()
      local cwd = vim.fn.fnamemodify(vim.fn.expand '%', ':p:h')
      builtin.grep_string { cwd = cwd }
    end, { desc = '\\S]earch current [W]ord (buffer)' })
    vim.keymap.set('n', '\\W', builtin.grep_string, { desc = '\\S]earch current [W]ord (workspace)' })
    vim.keymap.set('n', '\\g', builtin.current_buffer_fuzzy_find, { desc = '\\S]earch [G]rep (buffer)' })
    vim.keymap.set('n', '\\G', builtin.live_grep, { desc = '\\S]earch [G]rep (workspace)' })
    -- file searches
    vim.keymap.set('n', '\\f', builtin.find_files, { desc = '\\S]earch [F]iles' })
    vim.keymap.set('n', '<C-f>', builtin.find_files, { desc = '\\S]earch [F]iles' })
    vim.keymap.set('n', '\\F', function()
      builtin.find_files { hidden = true, no_ignore = true }
    end, { desc = '\\S]earch [F]iles (hidden)' })
    vim.keymap.set('n', '<C-s>', function()
      builtin.find_files { hidden = true, no_ignore = true }
    end, { desc = '\\S]earch [F]iles (hidden)' })
    -- buffer searches
    vim.keymap.set('n', '\\\\', builtin.current_buffer_fuzzy_find, { desc = '[S]earch fuzzy buffer' })
    vim.keymap.set('n', '<C-b>', builtin.buffers, { desc = '\\S]earch [B]uffers' })
    vim.keymap.set('n', '\\b', function()
      builtin.buffers()
    end, { desc = '\\S]earch [B]uffers' })
    -- nvim searches
    vim.keymap.set('n', '\\nh', builtin.help_tags, { desc = '\\S]earch [H]elp' })
    vim.keymap.set('n', '\\nm', builtin.keymaps, { desc = '\\S]earch [K]eymaps' })
    vim.keymap.set('n', '\\nc', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '\\S]earch [N]eovim files' })
    -- other searches
    vim.keymap.set('n', '\\R', builtin.resume, { desc = '\\S]earch [R]esume' })

    require('telescope').load_extension 'ui-select'
  end,
}
