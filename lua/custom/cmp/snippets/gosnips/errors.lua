local u = require 'custom.cmp.snippets.utils'

return {
  u.s(
    'if-err',
    u.fmt(
      [[
      if err != nil {{
        {}
      }}
  ]],
      {
        u.i(1, 'ErrHandling'),
      }
    )
  ),
  u.s(
    'if-err-return-err',
    u.fmt(
      [[
      if err != nil {{
        return err
      }}
  ]],
      {}
    )
  ),
  u.s(
    'if-err-expression',
    u.fmt(
      [[
      {}, err, := {}
      if err != nil {{
        {}
      }}
  ]],
      {
        u.i(1, 'Result'),
        u.i(2, 'FunctionCall'),
        u.i(3, 'ErrHandling'),
      }
    )
  ),
  u.s(
    'return-err',
    u.fmt(
      [[
      if err != nil {{
        return nil, err
      }}
      return {}, nil
  ]],
      {
        u.i(1, 'result'),
      }
    )
  ),
  u.s(
    'defer-panic',
    u.fmt(
      [[
      defer func() {{
        if r := recover(); r != nil {{
          {}
        }}
      }}
  ]],
      {
        u.i(1, 'HandlePanic'),
      }
    )
  ),
}
