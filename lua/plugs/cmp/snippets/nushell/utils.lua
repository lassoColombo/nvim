local u = require 'plugs.cmp.snippets.utils'

return {
  u.s(
    'error-make',
    u.fmt(
      [[
        error make {{msg: '{}'}}
      ]],
      {
        u.i(2, ''),
      }
    )
  ),
  u.s(
    'print-color',
    u.fmt(
      [[
        print ($"({}){}(ansi reset)")
      ]],
      {
        u.c(1, {
          u.t 'ansi green',
          u.t 'ansi blue',
          u.t 'ansi red',
          u.t 'ansi yellow',
        }),
        u.i(2, ''),
      }
    )
  ),
}
