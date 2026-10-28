local u = require 'plugs.cmp.snippet_utils'

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
