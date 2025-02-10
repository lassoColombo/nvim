return { -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
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

    local servers = {
      lua_ls = require 'custom.lsp.configs.luals',
      pyright = require 'custom.lsp.configs.pyright',
      yamlls = require 'custom.lsp.configs.yamlls',
      jsonls = require 'custom.lsp.configs.jsonls',
      taplo = require 'custom.lsp.configs.taplo',
      ansiblels = require 'custom.lsp.configs.ansiblels',
      jinja_lsp = require 'custom.lsp.configs.jinja_lsp',
      gopls = {},
    }

    require('mason').setup()
    vim.keymap.set('n', '<Space>m', '<cmd>Mason<cr>', { desc = '[M]ason' })

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      -- lua
      'lua_ls',
      'stylua',
      -- python
      'pyright',
      'pylint',
      'black',
      'isort',
      'jinja-lsp',
      -- yaml
      'yamlls',
      'prettier',
      -- json
      'jsonls',
      -- bash
      'bashls',
      -- sql
      'sqlls',
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
      'gopls',
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
