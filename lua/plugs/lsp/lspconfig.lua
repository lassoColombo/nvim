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

    -- `{}` = lspconfig defaults; anything else lives in plugs/lsp/servers/<name>.lua
    local servers = {
      ansiblels = {},
      cssls = {},
      emmet_language_server = require 'plugs.lsp.servers.emmet_language_server',
      eslint = {},
      gopls = {},
      html = {},
      jdtls = require 'plugs.lsp.servers.jdtls',
      jsonls = require 'plugs.lsp.servers.jsonls',
      lua_ls = require 'plugs.lsp.servers.luals',
      nushell = require 'plugs.lsp.servers.nushell',
      pyright = require 'plugs.lsp.servers.pyright',
      ruff = {},
      rust_analyzer = require 'plugs.lsp.servers.rust_analyzer',
      sqls = require 'plugs.lsp.servers.sqls',
      taplo = {},
      terraformls = require 'plugs.lsp.servers.terraformls',
      ts_ls = require 'plugs.lsp.servers.ts_ls',
      vue_ls = {},
      yamlls = require 'plugs.lsp.servers.yamlls',
    }

    require('mason-tool-installer').setup {
      ensure_installed = {
        -- language servers
        'ansible-language-server',
        'eslint-lsp',
        'gopls',
        'html-lsp',
        'jdtls',
        'json-lsp',
        'lua-language-server',
        'pyright',
        'ruff',
        -- rust-analyzer intentionally NOT via Mason: it must match the project
        -- toolchain. It comes from rustup's `rust-analyzer` component, via the
        -- ~/.cargo/bin proxy, which resolves per-directory from rust-toolchain.toml.
        'sqls',
        'typescript-language-server',
        'vue-language-server',
        'css-lsp',
        'emmet-language-server',
        'taplo',
        'terraform-ls',
        'yaml-language-server',
        -- debug adapters
        'debugpy',
        'delve',
        -- formatters / linters / tools
        'ansible-lint',
        'goimports',
        'golangci-lint',
        'prettier',
        'sqlfmt',
        'stylua',
      },
    }

    vim.lsp.config('*', { capabilities = capabilities })

    for server_name, server_opts in pairs(servers) do
      if next(server_opts) then
        vim.lsp.config(server_name, server_opts)
      end
      vim.lsp.enable(server_name)
    end
  end,
}
