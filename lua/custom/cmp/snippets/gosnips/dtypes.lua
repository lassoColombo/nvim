local u = require 'custom.cmp.snippets.utils'

return {
  u.s(
    'struct',
    u.fmt(
      [[
      {} struct {{
        {}
      }}
  ]],
      {
        u.i(1, 'Type'),
        u.i(2, 'Body'),
      }
    )
  ),
  u.s(
    'type-struct',
    u.fmt(
      [[
      type {} struct {{
        {}
      }}
  ]],
      {
        u.i(1, 'Type'),
        u.i(2, 'Body'),
      }
    )
  ),
  u.s(
    'interface',
    u.fmt(
      [[
      type {} interface {{
        {}
      }}
  ]],
      {
        u.i(1, 'Type'),
        u.i(2, 'Body'),
      }
    )
  ),
  u.s(
    'slice',
    u.fmt('[]{}{{{}}}', {
      u.i(1, 'VarType'),
      u.i(2, 'Content'),
    })
  ),
  u.s(
    'slice-declaration',
    u.fmt('{} := []{}{{{}}}', {
      u.i(1, 'VarName'),
      u.i(2, 'VarType'),
      u.i(3, 'Content'),
    })
  ),
  u.s(
    'array',
    u.fmt('[{}]{}{{{}}}', {
      u.i(1, 'Length'),
      u.i(2, 'VarType'),
      u.i(3, 'Content'),
    })
  ),
  u.s(
    'array-declaration',
    u.fmt('{} := [{}]{}{{{}}}', {
      u.i(1, 'VarName'),
      u.i(2, 'Length'),
      u.i(3, 'VarType'),
      u.i(4, 'Content'),
    })
  ),
  u.s(
    'map',
    u.fmt(
      [[
      map[{}]{}{{
        {}
      }}

      ]],
      {
        u.i(1, 'VarType'),
        u.i(2, 'VarType'),
        u.i(3, 'Content'),
      }
    )
  ),
  u.s(
    'map-declaration',
    u.fmt(
      [[
      {} := map[{}]{}{{
        {}
      }}

      ]],
      {
        u.i(1, 'VarName'),
        u.i(2, 'VarType'),
        u.i(3, 'VarType'),
        u.i(4, 'Content'),
      }
    )
  ),
  u.s(
    'chan-unbuf',
    u.fmt('{} := make(chan {})', {
      u.i(1, 'ChanName'),
      u.i(2, 'ChanType'),
    })
  ),
  u.s(
    'chan-buf',
    u.fmt('{} := make(chan {}, {})', {
      u.i(1, 'ChanName'),
      u.i(2, 'ChanType'),
      u.i(3, 'BufSize'),
    })
  ),
}
