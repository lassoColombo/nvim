return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', opts = {} },
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
      rust_analyzer = require 'plugs.lsp.servers.rust_analyzer',
      cssls = {},
      html = {},
      eslint = {},
      ts_ls = require 'plugs.lsp.servers.ts_ls',
      vue_ls = require 'plugs.lsp.servers.vue_ls',
      emmet_language_server = require 'plugs.lsp.servers.emmet_language_server',
    }

    vim.g.markdown_fenced_languages = { 'ts=typescript' }

    require('mason-tool-installer').setup {
      ensure_installed = {
        -- language servers
        'ansible-language-server',
        'bash-language-server',
        'dockerfile-language-server',
        'docker-compose-language-service',
        'eslint-lsp',
        'gopls',
        'html-lsp',
        'json-lsp',
        'lua-language-server',
        'marksman',
        'pyright',
        'ruff',
        'rust-analyzer',
        'sqls',
        'tailwindcss-language-server',
        'typescript-language-server',
        'vue-language-server',
        'css-lsp',
        'emmet-language-server',
        'taplo',
        'yaml-language-server',
        -- formatters / linters / tools
        'ansible-lint',
        'goimports',
        'golangci-lint',
        'prettier',
        'sqlfmt',
        'stylua',
      },
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
