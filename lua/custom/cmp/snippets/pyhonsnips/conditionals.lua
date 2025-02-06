local u = require 'custom.cmp.snippets.utils'

return {
  u.s('if-else', u.fmt([[
    if {}:
        {}
    else:
        {}
    ]], {
    u.i(1, 'condition'),
    u.i(2, 'expression'),
    u.i(3, 'expression')
  })),
  u.s('if-elif', u.fmt([[
    if {}:
        {}
    elif {}:
        {}
    ]], {
    u.i(1, 'condition'),
    u.i(2, 'expression'),
    u.i(3, 'condition'),
    u.i(4, 'expression')
  })),
  u.s('if-elif-else', u.fmt([[
    if {}:
        {}
    elif {}:
        {}
    else:
        {}
    ]], {
    u.i(1, 'condition'),
    u.i(2, 'expression'),
    u.i(3, 'condition'),
    u.i(4, 'expression'),
    u.i(5, 'expression')
  })),
  u.s('ternary', u.fmt([[{} if {} else {}]],
    { u.i(1, 'expression'),
      u.i(2, 'condition'),
      u.i(3, 'expression') })
  )
}
