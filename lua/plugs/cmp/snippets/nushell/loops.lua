local u = require 'plugs.cmp.snippets.utils'

return {
  u.s(
    'loop',
    u.fmt(
      [[
      loop {{
        {}
      }}
      ]],
      {
        u.i(1, 'body'),
      }
    )
  ),

  -- while
  u.s(
    'while',
    u.fmt(
      [[
      while {} {{
        {}
      }}
      ]],
      {
        u.i(1, 'condition'),
        u.i(2, 'body'),
      }
    )
  ),

  -- for
  u.s(
    'for',
    u.fmt(
      [[
      for {} in {} {{
        {}
      }}
      ]],
      {
        u.i(1, 'var'),
        u.i(2, 'iterable'),
        u.i(3, 'body'),
      }
    )
  ),

  -- each (common idiom in Nushell)
  u.s(
    'each',
    u.fmt(
      [[
      {} | each {{ |{}|
        {}
      }}
      ]],
      {
        u.i(1, 'pipeline'),
        u.i(2, 'it'),
        u.i(3, 'body'),
      }
    )
  ),
  -- par-each (parallel each)
  u.s(
    'par-each',
    u.fmt(
      [[
      {} | par-each {{ |{}|
        {}
      }}
      ]],
      {
        u.i(1, 'pipeline'),
        u.i(2, 'it'),
        u.i(3, 'body'),
      }
    )
  ),
}
