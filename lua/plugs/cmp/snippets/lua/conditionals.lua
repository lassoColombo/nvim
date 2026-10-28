local u = require 'plugs.cmp.snippet_utils'

return {
  u.s('ternary', u.fmt('{} and {} or {}', { u.i(1, 'cond'), u.i(2, 'value'), u.i(3, 'fallback') })),
}
