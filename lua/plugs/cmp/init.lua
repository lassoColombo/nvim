return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      build = vim.fn.executable 'make' == 1 and 'make install_jsregexp' or nil,
    },
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    {
      'Jezda1337/nvim-html-css',
      opts = {
        enable_on = { 'html', 'vue', 'css', 'less', 'scss' },
      },
    },
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'

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

        ['<C-j>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-k>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.choice_active() then
            luasnip.change_choice(1)
          end
        end, { 'i', 's' }),
        ['<C-l>'] = cmp.mapping(function()
          if luasnip.choice_active() then
            require 'luasnip.extras.select_choice'()
          end
        end, { 'i', 's' }),
      },
      sources = {
        { name = 'nvim_lsp', priority = 1000 },
        { name = 'luasnip', priority = 900 },
        { name = 'nvim_lsp_signature_help', priority = 850 },
        { name = 'path', priority = 700 },
        { name = 'buffer', priority = 300 },
        { name = 'html-css', priority = 800 },
        { name = 'lazydev', priority = 1100, group_index = 0 },
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

    -- javascript/ holds the snippets valid in both languages, typescript/ the typed ones.
    -- filetype_extend is not transitive, and must run before lazy_load resolves the current buffer.
    luasnip.filetype_extend('typescript', { 'javascript' })
    luasnip.filetype_extend('javascriptreact', { 'javascript' })
    luasnip.filetype_extend('typescriptreact', { 'typescript', 'javascript' })
    -- snippets/<ft>.lua and snippets/<ft>/*.lua are loaded on the buffer's filetype
    require('luasnip.loaders.from_lua').lazy_load { paths = { vim.fn.stdpath 'config' .. '/lua/plugs/cmp/snippets' } }
  end,
}
