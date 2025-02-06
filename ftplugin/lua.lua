vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

local u = require 'custom.cmp.snippets.utils'
u.ls.add_snippets('lua', u.concat(require 'custom.cmp.snippets.luasnips.ternary'))

require 'custom.treesitter.textobjects.lua'
