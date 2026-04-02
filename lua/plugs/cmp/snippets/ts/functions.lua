local u = require 'plugs.cmp.snippets.utils'

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
    'func-arrow-inline',
    u.fmt('({}) => {}', {
      u.i(1, 'param'),
      u.i(2, 'expression'),
    })
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
    'func-iife',
    u.fmt(
      [[
      (async () => {{
        {}
      }})()
  ]],
      {
        u.i(1, ''),
      }
    )
  ),
}
