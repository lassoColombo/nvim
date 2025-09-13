local u = require 'plugs.cmp.snippets.utils'

return {
  -- def
  u.s(
    'def',
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

  -- export def
  u.s(
    'export-def',
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

  -- def-env (modifies environment)
  u.s(
    'def-env',
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

  -- export def-env
  u.s(
    'export-def-env',
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

  -- def with signature (returns type)
  u.s(
    'def-sig',
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
