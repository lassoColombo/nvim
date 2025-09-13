local u = require 'plugs.cmp.snippets.utils'

return {
  u.s(
    'notify',
    u.fmt(
      [[
      vim.notify("{}", vim.log.levels.{})
      ]],
      {
        u.i(1, 'Message'),
        u.c(2, {
          u.t 'INFO',
          u.t 'WARN',
          u.t 'ERROR',
          u.t 'DEBUG',
        }),
      }
    )
  ),
  u.s(
    'inspect',
    u.fmt(
      [[
      vim.notify("vim.inspect({})", vim.log.levels.{})
      ]],
      {
        u.i(1, 'Message'),
        u.c(2, {
          u.t 'INFO',
          u.t 'WARN',
          u.t 'ERROR',
          u.t 'DEBUG',
        }),
      }
    )
  ),
}
