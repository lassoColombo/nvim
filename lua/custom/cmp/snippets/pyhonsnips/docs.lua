local u = require 'custom.cmp.snippets.utils'
return {
  u.s('docstring', u.fmt([[
    """
        {}
    """
  ]], {
      u.i(1, 'docstring')
    })),
}
