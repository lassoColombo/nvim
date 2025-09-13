local u = require 'plugs.cmp.snippets.utils'

return {
  u.s(
    'docstring',
    u.fmt(
      [[
    """
        {}
    """
  ]],
      {
        u.i(1, 'docstring'),
      }
    )
  ),
}
