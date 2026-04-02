local u = require 'plugs.cmp.snippets.utils'

return {
  u.s(
    'error-check',
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
    'error-return',
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
    'error-assign',
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
    'error-return-val',
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
    'error-defer',
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
