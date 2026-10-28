local u = require 'plugs.cmp.snippet_utils'

return {
  u.s(
    'func-arrow-inline',
    u.fmt('({}) => {}', {
      u.i(1, 'param'),
      u.i(2, 'expression'),
    })
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
