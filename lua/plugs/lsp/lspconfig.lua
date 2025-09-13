return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', opts = {} },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'hrsh7th/cmp-nvim-lsp',
    'b0o/schemastore.nvim',
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('base-lsp-attach', { clear = true }),
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        require('plugs.lsp.keys').map(event.buf, client)
        require('plugs.lsp.aucmds').set(event.buf, client)
      end,
    })
    require 'plugs.lsp.opts'

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    local servers = {
      ansiblels = require 'plugs.lsp.servers.ansiblels',
      gopls = require 'plugs.lsp.servers.gopls',
      jsonls = require 'plugs.lsp.servers.jsonls',
      lua_ls = require 'plugs.lsp.servers.luals',
      pyright = require 'plugs.lsp.servers.pyright',
      ruff = require 'plugs.lsp.servers.ruff',
      sqls = require 'plugs.lsp.servers.sqls',
      taplo = require 'plugs.lsp.servers.taplo',
      yamlls = require 'plugs.lsp.servers.yamlls',
      -- denols = {},
      eslint = {},
      -- tailwindcss = {},
    }
    vim.g.markdown_fenced_languages = {
      'ts=typescript',
    }

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      -- lua
      'lua_ls',
      'stylua',
      -- python
      'ruff',
      'pyright',
      -- yaml & co
      'yamlls',
      'prettier',
      'ansible-lint',
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
      -- markdown
      'marksman',
      -- go
      'gopls',
      'goimports',
      'golangci-lint',
      -- FE
      -- 'denols',
      'html',
      'eslint',
      'tailwindcss',
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
      automatic_installation = false,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
