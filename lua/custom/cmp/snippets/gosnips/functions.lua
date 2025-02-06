local u = require 'custom.cmp.snippets.utils'

return {
  u.s(
    'defer-func',
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
    'go-func',
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
    'function',
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
    'anonimous-function',
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
    'method',
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
    'main',
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
