local u = require 'plugs.cmp.snippets.utils'

return {
  u.s(
    'match-result',
    u.fmt(
      [[
      match {} {{
        Ok({}) => {{
          {}
        }}
        Err({}) => {{
          {}
        }}
      }}
  ]],
      {
        u.i(1, 'expr'),
        u.i(2, 'val'),
        u.i(3, ''),
        u.i(4, 'e'),
        u.i(5, ''),
      }
    )
  ),
  u.s(
    'match-option',
    u.fmt(
      [[
      match {} {{
        Some({}) => {{
          {}
        }}
        None => {{
          {}
        }}
      }}
  ]],
      {
        u.i(1, 'expr'),
        u.i(2, 'val'),
        u.i(3, ''),
        u.i(4, ''),
      }
    )
  ),
  u.s(
    'if-let-some',
    u.fmt(
      [[
      if let Some({}) = {} {{
        {}
      }}
  ]],
      {
        u.i(1, 'val'),
        u.i(2, 'expr'),
        u.i(3, ''),
      }
    )
  ),
  u.s(
    'if-let-ok',
    u.fmt(
      [[
      if let Ok({}) = {} {{
        {}
      }}
  ]],
      {
        u.i(1, 'val'),
        u.i(2, 'expr'),
        u.i(3, ''),
      }
    )
  ),
  u.s(
    'while-let',
    u.fmt(
      [[
      while let Some({}) = {}.next() {{
        {}
      }}
  ]],
      {
        u.i(1, 'val'),
        u.i(2, 'iter'),
        u.i(3, ''),
      }
    )
  ),
  u.s(
    'unwrap-or',
    u.fmt('.unwrap_or({})', {
      u.i(1, 'default'),
    })
  ),
  u.s(
    'ok-or',
    u.fmt('.ok_or({})', {
      u.i(1, 'ErrorType::Variant'),
    })
  ),
  u.s(
    'error-propagate',
    u.fmt('let {} = {}?;', {
      u.i(1, 'val'),
      u.i(2, 'expr'),
    })
  ),
}
