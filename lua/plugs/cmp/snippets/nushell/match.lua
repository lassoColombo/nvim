local u = require 'plugs.cmp.snippets.utils'

return {
  -- Basic match
  u.s(
    'match',
    u.fmt(
      [[
      match {} {{
        {} => {}
        _ => {}
      }}
      ]],
      {
        u.i(1, 'value'),
        u.i(2, 'pattern'),
        u.i(3, 'expression'),
        u.i(4, 'default expression'),
      }
    )
  ),

  -- Match with multiple arms
  u.s(
    'match-multi',
    u.fmt(
      [[
      match {} {{
        {} => {}
        {} => {}
        _ => {}
      }}
      ]],
      {
        u.i(1, 'value'),
        u.i(2, 'pattern1'),
        u.i(3, 'expr1'),
        u.i(4, 'pattern2'),
        u.i(5, 'expr2'),
        u.i(6, 'default expr'),
      }
    )
  ),

  -- Match with guard
  u.s(
    'match-guard',
    u.fmt(
      [[
      match {} {{
        {} if {} => {}
        _ => {}
      }}
      ]],
      {
        u.i(1, 'value'),
        u.i(2, 'pattern'),
        u.i(3, 'condition'),
        u.i(4, 'expression'),
        u.i(5, 'default expression'),
      }
    )
  ),

  -- Match on record destructuring
  u.s(
    'match-record',
    u.fmt(
      [[
      match {} {{
        {{ {} }} => {}
        _ => {}
      }}
      ]],
      {
        u.i(1, 'record'),
        u.i(2, 'field1, field2'),
        u.i(3, 'expression'),
        u.i(4, 'default expression'),
      }
    )
  ),
}
