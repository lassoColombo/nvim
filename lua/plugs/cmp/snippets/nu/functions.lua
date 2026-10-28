local u = require 'plugs.cmp.snippets.utils'

return {
  u.s(
    'func',
    u.fmt(
      [[
      def {} [ {} ] {{
        {}
      }}
      ]],
      {
        u.i(1, 'name'),
        u.i(2, 'params'),
        u.i(3, 'body'),
      }
    )
  ),

  u.s(
    'func-export',
    u.fmt(
      [[
      export def {} [ {} ] {{
        {}
      }}
      ]],
      {
        u.i(1, 'name'),
        u.i(2, 'params'),
        u.i(3, 'body'),
      }
    )
  ),

  u.s(
    'func-env',
    u.fmt(
      [[
      def-env {} [ {} ] {{
        {}
      }}
      ]],
      {
        u.i(1, 'name'),
        u.i(2, 'params'),
        u.i(3, 'body'),
      }
    )
  ),

  u.s(
    'func-env-export',
    u.fmt(
      [[
      export def-env {} [ {} ] {{
        {}
      }}
      ]],
      {
        u.i(1, 'name'),
        u.i(2, 'params'),
        u.i(3, 'body'),
      }
    )
  ),

  u.s(
    'func-typed',
    u.fmt(
      [[
      def {} [ {} ]: {} -> {} {{
        {}
      }}
      ]],
      {
        u.i(1, 'name'),
        u.i(2, 'params'),
        u.i(3, 'input-type'),
        u.i(4, 'output-type'),
        u.i(5, 'body'),
      }
    )
  ),
}
