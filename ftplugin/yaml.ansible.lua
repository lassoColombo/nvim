vim.diagnostic.config {
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}

-- :FIXME: does not work
-- local u = require 'custom.cmp.snippets.utils'
-- u.ls.add_snippets('yaml.ansible', u.concat(require 'custom.cmp.snippets.ansiblesnips.debug'))
