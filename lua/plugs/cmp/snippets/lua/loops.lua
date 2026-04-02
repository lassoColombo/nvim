local u = require 'plugs.cmp.snippets.utils'

return {
  u.s(
    'for-i',
    u.fmt(
      [[
      for {} = {}, {} do
        {}
      end
  ]],
      {
        u.i(1, 'i'),
        u.i(2, '1'),
        u.i(3, 'n'),
        u.i(4, ''),
      }
    )
  ),
  u.s(
    'for-i-step',
    u.fmt(
      [[
      for {} = {}, {}, {} do
        {}
      end
  ]],
      {
        u.i(1, 'i'),
        u.i(2, '1'),
        u.i(3, 'n'),
        u.i(4, 'step'),
        u.i(5, ''),
      }
    )
  ),
  u.s(
    'for-range',
    u.fmt(
      [[
      for {}, {} in ipairs({}) do
        {}
      end
  ]],
      {
        u.i(1, 'i'),
        u.i(2, 'v'),
        u.i(3, 'tbl'),
        u.i(4, ''),
      }
    )
  ),
  u.s(
    'for-map',
    u.fmt(
      [[
      for {}, {} in pairs({}) do
        {}
      end
  ]],
      {
        u.i(1, 'k'),
        u.i(2, 'v'),
        u.i(3, 'tbl'),
        u.i(4, ''),
      }
    )
  ),
  u.s(
    'while',
    u.fmt(
      [[
      while {} do
        {}
      end
  ]],
      {
        u.i(1, 'condition'),
        u.i(2, ''),
      }
    )
  ),
  u.s(
    'repeat',
    u.fmt(
      [[
      repeat
        {}
      until {}
  ]],
      {
        u.i(1, ''),
        u.i(2, 'condition'),
      }
    )
  ),
}
