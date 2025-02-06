local u = require 'custom.cmp.snippets.utils'
return {
  u.s(
    'for-range-map',
    u.fmt(
      [[
      for {}, {} := range {} {{
        {}
      }}
  ]],
      {
        u.c(1, { u.i 'key', u.t '_' }),
        u.c(2, { u.i 'value', u.t '_' }),
        u.i(3, 'Map'),
        u.i(4, ''),
      }
    )
  ),
  u.s(
    'for-range-slice',
    u.fmt(
      [[
      for {}, {} := range {} {{
        {}
      }}
  ]],
      {
        u.c(1, { u.i 'Counter', u.t '_' }),
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
  -- -- :TODO: bring i++/i+= to be a choichenode
  u.s(
    'fori',
    u.fmt(
      [[
     for {} := {}; {} < {}; {}{} {{
      {}
     }}
  ]],
      {
        u.i(1, 'Counter'),
        u.i(2, 'Start'),
        u.f(function(args, parent, user_args)
          return args[1][1]
        end, { 1 }),
        u.i(3, 'End'),
        u.f(function(args, parent, user_args)
          return args[1][1]
        end, { 1 }),
        u.i(4, 'Increment'),
        u.i(5, ''),
      }
    )
  ),
}
