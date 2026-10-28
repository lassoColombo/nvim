local u = require 'plugs.cmp.snippets.utils'

return {
  -- if
  u.s(
    'if',
    u.fmt(
      [[
      if {} {{
        {}
      }}
      ]],
      {
        u.i(1, 'condition'),
        u.i(2, 'body'),
      }
    )
  ),

  -- if-else
  u.s(
    'if-else',
    u.fmt(
      [[
      if {} {{
        {}
      }} else {{
        {}
      }}
      ]],
      {
        u.i(1, 'condition'),
        u.i(2, 'if-body'),
        u.i(3, 'else-body'),
      }
    )
  ),

  -- if-elseif-else (Nushell uses `else if`)
  u.s(
    'if-elseif-else',
    u.fmt(
      [[
      if {} {{
        {}
      }} else if {} {{
        {}
      }} else {{
        {}
      }}
      ]],
      {
        u.i(1, 'condition'),
        u.i(2, 'if-body'),
        u.i(3, 'elif-condition'),
        u.i(4, 'elif-body'),
        u.i(5, 'else-body'),
      }
    )
  ),

  -- elseif (else if)
  u.s(
    'elseif',
    u.fmt(
      [[
      else if {} {{
        {}
      }}
      ]],
      {
        u.i(1, 'condition'),
        u.i(2, 'body'),
      }
    )
  ),

  -- else
  u.s(
    'else',
    u.fmt(
      [[
      else {{
        {}
      }}
      ]],
      {
        u.i(1, 'body'),
      }
    )
  ),
}
