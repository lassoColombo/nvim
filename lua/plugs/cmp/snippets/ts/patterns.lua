local u = require 'plugs.cmp.snippets.utils'

return {
  u.s(
    'import-named',
    u.fmt("import {{ {} }} from '{}'", {
      u.i(1, 'name'),
      u.i(2, 'module'),
    })
  ),
  u.s(
    'import-default',
    u.fmt("import {} from '{}'", {
      u.i(1, 'name'),
      u.i(2, 'module'),
    })
  ),
  u.s(
    'export-default',
    u.fmt('export default {}', {
      u.i(1, 'name'),
    })
  ),
  u.s(
    'try-catch',
    u.fmt(
      [[
      try {{
        {}
      }} catch ({}) {{
        {}
      }}
  ]],
      {
        u.i(1, ''),
        u.i(2, 'error'),
        u.i(3, ''),
      }
    )
  ),
  u.s(
    'try-async',
    u.fmt(
      [[
      try {{
        const {} = await {}
        {}
      }} catch ({}) {{
        {}
      }}
  ]],
      {
        u.i(1, 'result'),
        u.i(2, 'promise'),
        u.i(3, ''),
        u.i(4, 'error'),
        u.i(5, ''),
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
  u.s(
    'destr-obj',
    u.fmt('const {{ {} }} = {}', {
      u.i(1, 'field'),
      u.i(2, 'object'),
    })
  ),
  u.s(
    'destr-arr',
    u.fmt('const [{}, {}] = {}', {
      u.i(1, 'first'),
      u.i(2, 'second'),
      u.i(3, 'array'),
    })
  ),
  u.s(
    'destr-default',
    u.fmt('const {{ {} = {} }} = {}', {
      u.i(1, 'field'),
      u.i(2, 'default'),
      u.i(3, 'object'),
    })
  ),
  u.s(
    'log',
    u.fmt('console.log({})', {
      u.i(1, 'value'),
    })
  ),
  u.s(
    'log-inspect',
    u.fmt('console.log(JSON.stringify({}, null, 2))', {
      u.i(1, 'value'),
    })
  ),
  u.s(
    'log-error',
    u.fmt('console.error({})', {
      u.i(1, 'value'),
    })
  ),
  u.s(
    'log-debug',
    u.fmt('console.debug({})', {
      u.i(1, 'value'),
    })
  ),
}
