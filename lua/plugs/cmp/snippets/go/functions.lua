local u = require 'plugs.cmp.snippet_utils'

return {
  u.s(
    'func-defer',
    u.fmt(
      [[
      defer func({}) {} {{
        {}
      }}({})
  ]],
      {
        u.i(1, ''),
        u.i(2, ''),
        u.i(3, ''),
        u.i(4, ''),
      }
    )
  ),
  u.s(
    'func-goroutine',
    u.fmt(
      [[
      go func({}) {} {{
        {}
      }}({})
  ]],
      {
        u.i(1, ''),
        u.i(2, ''),
        u.i(3, ''),
        u.i(4, ''),
      }
    )
  ),
  u.s(
    'func',
    u.fmt(
      [[
      func {}({}) {} {{
        {}
      }}
  ]],
      {
        u.i(1, 'FuncName'),
        u.i(2, ''),
        u.i(3, ''),
        u.i(4, ''),
      }
    )
  ),
  u.s(
    'func-anon',
    u.fmt(
      [[
      func({}) {} {{
        {}
      }}
  ]],
      {
        u.i(1, ''),
        u.i(2, ''),
        u.i(3, ''),
      }
    )
  ),
  u.s(
    'func-method',
    u.fmt(
      [[
      func ({} *{}) {}({}) {} {{
        {}
      }}
  ]],
      {
        u.i(1, 'Receiver'),
        u.i(2, 'Type'),
        u.i(3, 'FuncName'),
        u.i(4, ''),
        u.i(5, ''),
        u.i(6, ''),
      }
    )
  ),
  u.s(
    'func-main',
    u.fmt(
      [[
      func main() {{
        {}
      }}
  ]],
      {
        u.i(1, 'Body'),
      }
    )
  ),
}
