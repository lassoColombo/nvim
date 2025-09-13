local u = require 'plugs.cmp.snippets.utils'

return {
  u.s(
    'DDD',
    u.fmt(
      [[
      - name: DDD {}
      ansible.builtin.debug:
        var: {}
      }}
  ]],
      {
        u.i(1, ''),
        ---@diagnostic disable-next-line: unused-local
        u.f(function(args, parent, user_args)
          return args[1][1]
        end, { 1 }),
      }
    )
  ),
}
