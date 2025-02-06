vim.diagnostic.config {
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}

local u = require 'custom.cmp.snippets.utils'
u.ls.add_snippets(
  'python',
  u.concat(
    require 'custom.cmp.snippets.pyhonsnips.utils',
    require 'custom.cmp.snippets.pyhonsnips.docs',
    require 'custom.cmp.snippets.pyhonsnips.conditionals',
    require 'custom.cmp.snippets.pyhonsnips.dunders',
    require 'custom.cmp.snippets.pyhonsnips.classes',
    require 'custom.cmp.snippets.pyhonsnips.functions'
  )
)
require 'custom.treesitter.textobjects.python'
