return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', opts = {} },
      'hrsh7th/cmp-nvim-lsp',
      'b0o/schemastore.nvim',
    },
    config = function()
      vim.lsp.config('*', { capabilities = require('cmp_nvim_lsp').default_capabilities() })

      -- lspconfig's defaults, merged with after/lsp/<name>.lua where a server needs settings
      vim.lsp.enable {
        'ansiblels',
        'cssls',
        'emmet_language_server',
        'eslint',
        'gopls',
        'html',
        'jdtls',
        'jsonls',
        'lua_ls',
        'nushell',
        'pyright',
        'ruff',
        'rust_analyzer',
        'sqls',
        'taplo',
        'terraformls',
        'ts_ls',
        'vue_ls',
        'yamlls',
      }
    end,
  },
  {
    -- Loaded at startup: it installs what is missing on VimEnter. Other spec
    -- files add the tools they use (format.lua, dap.lua); every fragment repeats
    -- opts_extend, since lazy merges fragments in import order and only sees
    -- the opts_extend of the fragments merged so far.
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts_extend = { 'ensure_installed' },
    opts = {
      ensure_installed = {
        -- language servers
        'ansible-language-server',
        'css-lsp',
        'emmet-language-server',
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
        'taplo',
        'terraform-ls',
        'typescript-language-server',
        'vue-language-server',
        'yaml-language-server',
        -- linters: ansible-lint runs inside ansiblels, golangci-lint through none-ls
        'ansible-lint',
        'golangci-lint',
      },
    },
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'nvimtools/none-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local null_ls = require 'null-ls'

      local sources = {
        -- null_ls.builtins.diagnostics.pylint.with {
        --   diagnostics_postprocess = function(diagnostic)
        --     diagnostic.code = diagnostic.message_id
        --   end,
        -- },
        -- null_ls.builtins.diagnostics.ansiblelint,
        null_ls.builtins.diagnostics.golangci_lint,
        -- null_ls.builtins.diagnostics.djlint,
      }
      null_ls.setup { sources = sources }
    end,
  },
}
