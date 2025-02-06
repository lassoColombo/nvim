vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.diagnostic.config {
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}

local u = require 'custom.cmp.snippets.utils'
u.ls.add_snippets(
  'go',
  u.concat(
    require 'custom.cmp.snippets.gosnips.functions',
    require 'custom.cmp.snippets.gosnips.control-flow',
    require 'custom.cmp.snippets.gosnips.fors',
    require 'custom.cmp.snippets.gosnips.logging',
    require 'custom.cmp.snippets.gosnips.utils',
    require 'custom.cmp.snippets.gosnips.errors',
    require 'custom.cmp.snippets.gosnips.dtypes'
  )
)

require 'custom.treesitter.textobjects.go'
