local u = require 'plugs.cmp.snippet_utils'

return {
  u.s(
    'class',
    u.fmt(
      [[
      class {}({}):
          def __init__(self, *args, **kwargs):
              {}

          def __str__(self):
              {}
  ]],
      {
        u.i(1, 'className'),
        u.i(2, 'parentClasses'),
        u.i(3, 'pass'),
        u.i(4, 'pass'),
      }
    )
  ),
}
