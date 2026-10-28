local u = require 'plugs.cmp.snippet_utils'

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
        u.rep(1),
      }
    )
  ),
}
