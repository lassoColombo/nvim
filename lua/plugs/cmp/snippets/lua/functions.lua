local u = require 'plugs.cmp.snippets.utils'

return {
  u.s(
    'func',
    u.fmt(
      [[
      local function {}({})
        {}
      end
  ]],
      {
        u.i(1, 'name'),
        u.i(2, ''),
        u.i(3, ''),
      }
    )
  ),
  u.s(
    'func-global',
    u.fmt(
      [[
      function {}({})
        {}
      end
  ]],
      {
        u.i(1, 'name'),
        u.i(2, ''),
        u.i(3, ''),
      }
    )
  ),
  u.s(
    'func-method',
    u.fmt(
      [[
      function {}:{}({})
        {}
      end
  ]],
      {
        u.i(1, 'Table'),
        u.i(2, 'method'),
        u.i(3, ''),
        u.i(4, ''),
      }
    )
  ),
  u.s(
    'func-anon',
    u.fmt(
      [[
      local {} = function({})
        {}
      end
  ]],
      {
        u.i(1, 'name'),
        u.i(2, ''),
        u.i(3, ''),
      }
    )
  ),
  u.s(
    'func-closure',
    u.fmt(
      [[
      function({})
        {}
      end
  ]],
      {
        u.i(1, ''),
        u.i(2, ''),
      }
    )
  ),
  u.s(
    'func-return',
    u.fmt(
      [[
      return function({})
        {}
      end
  ]],
      {
        u.i(1, ''),
        u.i(2, ''),
      }
    )
  ),
}
