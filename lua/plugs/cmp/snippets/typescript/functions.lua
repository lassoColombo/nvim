local u = require 'plugs.cmp.snippet_utils'

return {
  u.s(
    'func',
    u.fmt(
      [[
      function {}({}): {} {{
        {}
      }}
  ]],
      {
        u.i(1, 'name'),
        u.i(2, ''),
        u.i(3, 'void'),
        u.i(4, ''),
      }
    )
  ),
  u.s(
    'func-async',
    u.fmt(
      [[
      async function {}({}): Promise<{}> {{
        {}
      }}
  ]],
      {
        u.i(1, 'name'),
        u.i(2, ''),
        u.i(3, 'void'),
        u.i(4, ''),
      }
    )
  ),
  u.s(
    'func-arrow',
    u.fmt(
      [[
      const {} = ({}): {} => {{
        {}
      }}
  ]],
      {
        u.i(1, 'name'),
        u.i(2, ''),
        u.i(3, 'void'),
        u.i(4, ''),
      }
    )
  ),
  u.s(
    'func-arrow-async',
    u.fmt(
      [[
      const {} = async ({}): Promise<{}> => {{
        {}
      }}
  ]],
      {
        u.i(1, 'name'),
        u.i(2, ''),
        u.i(3, 'void'),
        u.i(4, ''),
      }
    )
  ),
  u.s(
    'func-anon',
    u.fmt(
      [[
      function({}): {} {{
        {}
      }}
  ]],
      {
        u.i(1, ''),
        u.i(2, 'void'),
        u.i(3, ''),
      }
    )
  ),
  u.s(
    'promise',
    u.fmt(
      [[
      new Promise<{}>((resolve, reject) => {{
        {}
      }})
  ]],
      {
        u.i(1, 'Type'),
        u.i(2, ''),
      }
    )
  ),
}
