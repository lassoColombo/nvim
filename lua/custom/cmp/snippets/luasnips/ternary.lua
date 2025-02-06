local u = require 'custom.cmp.snippets.utils'

return {
  u.s('ternary', {
    -- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
    u.i(1, 'cond'),
    u.t ' ? ',
    u.i(2, 'then'),
    u.t ' : ',
    u.i(3, 'else'),
  }),
}
