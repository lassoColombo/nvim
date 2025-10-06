return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      build = (function()
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {},
    },
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp-signature-help',
  },
  config = function()
    -- See `:help cmp`
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'

    luasnip.config.setup {}
    -- `:` cmp-cmdline setup.
    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = { completeopt = 'menu,menuone,noinsert' },

      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),

        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        ['<C-y>'] = cmp.mapping.confirm { select = true },

        ['<C-Space>'] = cmp.mapping.complete {},

        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),
        ['<C-o>'] = cmp.mapping(function()
          if luasnip.choice_active() then
            luasnip.change_choice(1)
          end
        end, { 'i', 's' }),
        ['<C-u>'] = cmp.mapping(function()
          if luasnip.choice_active() then
            require 'luasnip.extras.select_choice'()
          end
        end, { 'i', 's' }),
      },
      sources = {
        { name = 'luasnip' }, -- Snippets first
        { name = 'nvim_lsp' }, -- LSP second
        { name = 'nvim_lsp_signature_help' }, -- (optional, keep near LSP)
        { name = 'buffer' }, -- Text last
        { name = 'path' }, -- Text/file path last
        {
          name = 'lazydev',
          group_index = 0,
        },
      },
    }

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        {
          name = 'cmdline',
          option = {
            ignore_cmds = { 'Man', '!' },
          },
        },
      }),
    })

    local utils = require 'plugs.cmp.snippets.utils'
    utils.ls.add_snippets('lua', utils.concat(require 'plugs.cmp.snippets.lua.conditionals', require 'plugs.cmp.snippets.lua.nvim'))
    utils.ls.add_snippets('ansible', require 'plugs.cmp.snippets.ansible.utils')
    utils.ls.add_snippets('html', require 'plugs.cmp.snippets.html')
    utils.ls.add_snippets(
      'nu',
      utils.concat(
        require 'plugs.cmp.snippets.nushell.functions',
        require 'plugs.cmp.snippets.nushell.conditionals',
        require 'plugs.cmp.snippets.nushell.loops',
        require 'plugs.cmp.snippets.nushell.utils',
        require 'plugs.cmp.snippets.nushell.docstring',
        require 'plugs.cmp.snippets.nushell.match'
      )
    )
    utils.ls.add_snippets(
      'go',
      utils.concat(
        require 'plugs.cmp.snippets.go.conditionals',
        require 'plugs.cmp.snippets.go.dtypes',
        require 'plugs.cmp.snippets.go.errors',
        require 'plugs.cmp.snippets.go.functions',
        require 'plugs.cmp.snippets.go.logging',
        require 'plugs.cmp.snippets.go.loops',
        require 'plugs.cmp.snippets.go.utils'
      )
    )
    utils.ls.add_snippets(
      'python',
      utils.concat(
        require 'plugs.cmp.snippets.py.classes',
        require 'plugs.cmp.snippets.py.conditionals',
        require 'plugs.cmp.snippets.py.docs',
        require 'plugs.cmp.snippets.py.dunders',
        require 'plugs.cmp.snippets.py.functions',
        require 'plugs.cmp.snippets.py.utils'
      )
    )
  end,
}
