local u = require 'plugs.cmp.snippet_utils'

return {
  u.s(
    'for-map',
    u.fmt(
      [[
      for {}, {} := range {} {{
        {}
      }}
  ]],
      {
        u.c(1, { u.i(nil, 'key'), u.t '_' }),
        u.c(2, { u.i(nil, 'value'), u.t '_' }),
        u.i(3, 'Map'),
        u.i(4, ''),
      }
    )
  ),
  u.s(
    'for-range',
    u.fmt(
      [[
      for {}, {} := range {} {{
        {}
      }}
  ]],
      {
        u.c(1, { u.i(nil, 'Counter'), u.t '_' }),
        u.i(2, 'Value'),
        u.i(3, 'Slice'),
        u.i(4, ''),
      }
    )
  ),
  u.s(
    'for',
    u.fmt(
      [[
      for {{
        {}
      }}
  ]],
      {
        u.i(1, ''),
      }
    )
  ),
  u.s(
    'for-i',
    u.fmt(
      [[
      for {} := {}; {} < {}; {}{} {{
        {}
      }}
  ]],
      {
        u.i(1, 'Counter'),
        u.i(2, 'Start'),
        u.rep(1),
        u.i(3, 'End'),
        u.rep(1),
        u.i(4, '++'),
        u.i(5, ''),
      }
    )
  ),
}
