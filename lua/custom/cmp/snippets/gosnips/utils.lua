local u = require 'custom.cmp.snippets.utils'
return {
  u.s(
    'sleep',
    u.fmt(
      [[
      time.Sleep(time.{})
    ]],
      {
        u.i(1, 'Value'),
      }
    )
  ),
  u.s(
    'Getenv',
    u.fmt(
      [[
      {} := os.Getenv("{}")
	  if {} == "" {{
      {}
	  }}
    ]],
      {
        u.i(1, 'Value'),
        u.i(2, 'VarName'),
        u.f(function(args, parent, user_args)
          return args[1][1]
        end, { 1 }),
        u.i(3, 'IfNotSetBody'),
      }
    )
  ),
  u.s(
    'print-point',
    u.fmt(
      [[
        fmt.Println("{}")
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
