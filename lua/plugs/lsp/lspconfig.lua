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

    local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
      eslint = {},
    }

    vim.g.markdown_fenced_languages = { 'ts=typescript' }

    local ensure_installed = vim.tbl_keys(servers)
    vim.list_extend(ensure_installed, {
      'lua_ls',
      'stylua',
      'ruff',
      'pyright',
      'yamlls',
      'prettier',
      'ansible-lint',
      'jsonls',
      'bashls',
      'sqlfmt',
      'dockerls',
      'docker_compose_language_service',
      'taplo',
      'marksman',
      'gopls',
      'goimports',
      'golangci-lint',
      'html',
      'eslint',
      'tailwindcss',
    })

    require('mason-tool-installer').setup {
      ensure_installed = ensure_installed,
    }

    require('mason-lspconfig').setup {
      ensure_installed = {},
      automatic_installation = false,
    }

    for server_name, server_opts in pairs(servers) do
      vim.lsp.config(
        server_name,
        vim.tbl_deep_extend('force', {
          capabilities = capabilities,
        }, server_opts or {})
      )

      vim.lsp.enable(server_name)
    end
  end,
}
