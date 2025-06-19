return { -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    {
      -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      'folke/lazydev.nvim',
      ft = 'lua',
      opts = {
        library = {
          -- Load luvit types when the `vim.uv` word is found
          { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        },
      },
    },
    { 'Bilal2453/luvit-meta', lazy = true },
    -- Automatically install LSPs and related tools to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    -- Useful status updates for LSP.
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
    require('which-key').add { { { '<Space>', group = '' }, { '<Space>_', hidden = true } } }
    -- `:help lsp-vs-treesitter`
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        -- The following two autocommands are used to highlight references of the
        -- word under cursor when the cursor rests there for a little while.
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    local ex = vim.fn.expand
    local servers = {
      lua_ls = require 'custom.lsp.configs.luals',
      pyright = require 'custom.lsp.configs.pyright',
      yamlls = require 'custom.lsp.configs.yamlls',
      jsonls = require 'custom.lsp.configs.jsonls',
      taplo = require 'custom.lsp.configs.taplo',
      jinja_lsp = require 'custom.lsp.configs.jinja_lsp',
      gopls = require 'custom.lsp.configs.gopls',
      ansiblels = require 'custom.lsp.configs.ansiblels',
      sqls = require 'custom.lsp.configs.sqls',
      ruff = {},
    }

    require('mason').setup()
    vim.keymap.set('n', '<Space>m', '<cmd>Mason<cr>', { desc = '[M]ason' })

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      -- lua
      'lua_ls',
      'stylua',
      -- python
      'ruff',
      'pyright',
      -- yaml
      'yamlls',
      'prettier',
      -- json
      'jsonls',
      -- bash
      'bashls',
      -- sql
      -- 'sqlls',
      'sqlfmt',
      -- docker
      'dockerls',
      'docker_compose_language_service',
      -- bash
      'bashls',
      -- toml
      'taplo',
      -- ansible
      -- 'ansiblels',
      'ansible-lint',
      -- markdown
      'marksman',
      -- go
      -- 'gopls',
      'goimports',
      'golangci-lint',
      -- html
      'html',
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    ---@diagnostic disable-next-line: missing-fields
    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          -- Skip yaml-language-server to use yaml-companion
          if server_name == 'yamlls' then
            return
          end
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
