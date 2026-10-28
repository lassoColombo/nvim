local u = require 'plugs.cmp.snippet_utils'

return {
  u.s('log-inspect', {
    u.t "__import__('pprint').pprint(",
    u.i(1, 'expression'),
    u.t ')',
  }),
  u.s(
    'log-debug',
    u.fmt(
      [[
        print("{}")
      ]],
      {
        u.c(1, {
          u.t '$$$$',
          u.t '####',
          u.t '@@@@',
          u.t '!!!!',
          u.t '%%%%',
          u.t '^^^^',
          u.t '&&&&',
          u.t '****',
        }),
      }
    )
  ),
}
