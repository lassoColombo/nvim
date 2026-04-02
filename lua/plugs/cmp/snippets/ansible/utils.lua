local u = require 'plugs.cmp.snippets.utils'

return {
  u.s(
    'log-debug',
    u.fmt(
      [[
      - name: debug {}
        ansible.builtin.debug:
          var: {}
  ]],
      {
        u.i(1, ''),
        u.f(function(args, parent, user_args)
          return args[1][1]
        end, { 1 }),
      }
    )
  ),
}
