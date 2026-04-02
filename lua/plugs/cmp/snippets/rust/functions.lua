local u = require 'plugs.cmp.snippets.utils'

return {
  u.s(
    'func',
    u.fmt(
      [[
      fn {}({}) -> {} {{
        {}
      }}
  ]],
      {
        u.i(1, 'name'),
        u.i(2, ''),
        u.i(3, '()'),
        u.i(4, ''),
      }
    )
  ),
  u.s(
    'func-pub',
    u.fmt(
      [[
      pub fn {}({}) -> {} {{
        {}
      }}
  ]],
      {
        u.i(1, 'name'),
        u.i(2, ''),
        u.i(3, '()'),
        u.i(4, ''),
      }
    )
  ),
  u.s(
    'func-async',
    u.fmt(
      [[
      async fn {}({}) -> {} {{
        {}
      }}
  ]],
      {
        u.i(1, 'name'),
        u.i(2, ''),
        u.i(3, '()'),
        u.i(4, ''),
      }
    )
  ),
  u.s(
    'func-pub-async',
    u.fmt(
      [[
      pub async fn {}({}) -> {} {{
        {}
      }}
  ]],
      {
        u.i(1, 'name'),
        u.i(2, ''),
        u.i(3, '()'),
        u.i(4, ''),
      }
    )
  ),
  u.s(
    'func-closure',
    u.fmt(
      [[
      |{}| {{
        {}
      }}
  ]],
      {
        u.i(1, ''),
        u.i(2, ''),
      }
    )
  ),
  u.s(
    'func-closure-move',
    u.fmt(
      [[
      move |{}| {{
        {}
      }}
  ]],
      {
        u.i(1, ''),
        u.i(2, ''),
      }
    )
  ),
  u.s(
    'func-closure-inline',
    u.fmt('|{}| {}', {
      u.i(1, 'param'),
      u.i(2, 'expression'),
    })
  ),
}
