local u = require 'plugs.cmp.snippets.utils'

return {
  u.s(
    'tbl',
    u.fmt('local {} = {{}}', {
      u.i(1, 'name'),
    })
  ),
  u.s(
    'tbl-init',
    u.fmt(
      [[
      local {} = {{
        {} = {},
      }}
  ]],
      {
        u.i(1, 'name'),
        u.i(2, 'key'),
        u.i(3, 'value'),
      }
    )
  ),
  u.s(
    'tbl-insert',
    u.fmt('table.insert({}, {})', {
      u.i(1, 'tbl'),
      u.i(2, 'value'),
    })
  ),
  u.s(
    'tbl-insert-pos',
    u.fmt('table.insert({}, {}, {})', {
      u.i(1, 'tbl'),
      u.i(2, 'pos'),
      u.i(3, 'value'),
    })
  ),
  u.s(
    'tbl-remove',
    u.fmt('table.remove({}, {})', {
      u.i(1, 'tbl'),
      u.i(2, 'pos'),
    })
  ),
  u.s(
    'tbl-concat',
    u.fmt('table.concat({}, {})', {
      u.i(1, 'tbl'),
      u.i(2, 'sep'),
    })
  ),
  u.s(
    'tbl-sort',
    u.fmt(
      [[
      table.sort({}, function(a, b)
        {}
      end)
  ]],
      {
        u.i(1, 'tbl'),
        u.i(2, 'return a < b'),
      }
    )
  ),
  u.s(
    'tbl-contains',
    u.fmt('vim.tbl_contains({}, {})', {
      u.i(1, 'tbl'),
      u.i(2, 'value'),
    })
  ),
  u.s(
    'tbl-extend',
    u.fmt('vim.tbl_extend({}, {}, {})', {
      u.c(1, { u.t "'force'", u.t "'keep'", u.t "'error'" }),
      u.i(2, 'tbl1'),
      u.i(3, 'tbl2'),
    })
  ),
}
