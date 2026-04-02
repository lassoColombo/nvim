local u = require 'plugs.cmp.snippets.utils'

return {
  u.s(
    'mod',
    u.fmt(
      [[
      local M = {{}}

      {}

      return M
  ]],
      {
        u.i(1, ''),
      }
    )
  ),
  u.s(
    'mod-require',
    u.fmt("local {} = require '{}'", {
      u.i(1, 'name'),
      u.i(2, 'module.path'),
    })
  ),
  u.s(
    'mod-setup',
    u.fmt(
      [[
      local M = {{}}

      function M.setup(opts)
        opts = opts or {{}}
        {}
      end

      return M
  ]],
      {
        u.i(1, ''),
      }
    )
  ),
}
