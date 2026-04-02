local u = require 'plugs.cmp.snippets.utils'

return {
  u.s(
    'vfor',
    u.fmt('<{} v-for="{} in {}" :key="{}.{}">\n  {}\n</{}>', {
      u.i(1, 'div'),
      u.i(2, 'item'),
      u.i(3, 'items'),
      u.rep(2),
      u.i(4, 'id'),
      u.i(5, ''),
      u.rep(1),
    })
  ),
  u.s('vife', u.fmt('<div v-if="{}">\n  {}\n</div>\n<div v-else>\n  {}\n</div>', { u.i(1, 'condition'), u.i(2, ''), u.i(3, '') })),
}
