local u = require 'plugs.cmp.snippet_utils'

return {
  u.s(
    'func',
    u.fmt(
      [[
      def {}({}):
          {}
  ]],
      {
        u.i(1, 'funcName'),
        u.i(2, '*args, **kwargs'),
        u.i(3, 'pass'),
      }
    )
  ),
  u.s(
    'func-lambda',
    u.fmt('lambda {}: {}', {
      u.i(1, 'args'),
      u.i(2, 'expression'),
    })
  ),
}
