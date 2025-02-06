local u = require 'custom.cmp.snippets.utils'
return {
  u.s(
    'function',
    u.fmt(
      [[
      def {}({}, *args, **kwargs):
          {}
  ]],
      {
        u.i(1, 'funcName'),
        u.i(2, 'args'),
        u.i(3, 'pass'),
      }
    )
  ),
  u.s(
    'lambda',
    u.fmt('lambda {}: {}', {
      u.i(1, 'args'),
      u.i(2, 'expression'),
    })
  ),
}
