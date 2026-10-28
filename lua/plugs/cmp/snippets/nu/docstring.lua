local u = require 'plugs.cmp.snippets.utils'

return {
  u.s(
    'docstring',
    u.fmt(
      [[
      # Description: {}
      # Parameters:
      #   {}: {}
      #   {}: {}
      # Example:
      #   {}
      {}  # function body
      ]],
      {
        u.i(1, 'Brief description of the function'),
        u.i(2, 'param1'),
        u.i(3, 'description of param1'),
        u.i(4, 'param2'),
        u.i(5, 'description of param2'),
        u.i(6, 'example usage'),
        u.i(7, 'body'),
      }
    )
  ),
}
