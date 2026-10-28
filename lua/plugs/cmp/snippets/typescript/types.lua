local u = require 'plugs.cmp.snippet_utils'

return {
  u.s(
    'interface',
    u.fmt(
      [[
      interface {} {{
        {}: {}
      }}
  ]],
      {
        u.i(1, 'Name'),
        u.i(2, 'field'),
        u.i(3, 'Type'),
      }
    )
  ),
  u.s(
    'type-alias',
    u.fmt(
      [[
      type {} = {{
        {}: {}
      }}
  ]],
      {
        u.i(1, 'Name'),
        u.i(2, 'field'),
        u.i(3, 'Type'),
      }
    )
  ),
  u.s(
    'type-union',
    u.fmt('type {} = {} | {}', {
      u.i(1, 'Name'),
      u.i(2, 'TypeA'),
      u.i(3, 'TypeB'),
    })
  ),
  u.s(
    'enum',
    u.fmt(
      [[
      enum {} {{
        {} = '{}',
      }}
  ]],
      {
        u.i(1, 'Name'),
        u.i(2, 'Member'),
        u.rep(2),
      }
    )
  ),
  u.s(
    'type-generic',
    u.fmt(
      [[
      type {}<{}> = {{
        {}: {}
      }}
  ]],
      {
        u.i(1, 'Name'),
        u.i(2, 'T'),
        u.i(3, 'field'),
        u.rep(2),
      }
    )
  ),
  u.s(
    'type-record',
    u.fmt('Record<{}, {}>', {
      u.i(1, 'KeyType'),
      u.i(2, 'ValueType'),
    })
  ),
  u.s(
    'type-partial',
    u.fmt('Partial<{}>', {
      u.i(1, 'Type'),
    })
  ),
  u.s(
    'type-required',
    u.fmt('Required<{}>', {
      u.i(1, 'Type'),
    })
  ),
  u.s(
    'type-pick',
    u.fmt("Pick<{}, '{}'>", {
      u.i(1, 'Type'),
      u.i(2, 'field'),
    })
  ),
}
