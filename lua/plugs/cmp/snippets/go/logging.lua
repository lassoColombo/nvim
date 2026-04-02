local u = require 'plugs.cmp.snippets.utils'

return {
  u.s(
    'log',
    u.fmt('fmt.Println({})', {
      u.i(1, 'arg'),
    })
  ),
  u.s(
    'log-fmt',
    u.fmt('fmt.Printf("{}\\n", {})', {
      u.i(1, 'content'),
      u.i(2, 'vars'),
    })
  ),
  u.s(
    'log-str',
    u.fmt('fmt.Sprintf("{}\\n", {})', {
      u.i(1, 'content'),
      u.i(2, 'vars'),
    })
  ),
  u.s(
    'log-inspect',
    u.fmt('fmt.Printf("{} %+v\\n", {})', {
      u.i(1, ''),
      u.i(2, ''),
    })
  ),
  u.s(
    'log-type',
    u.fmt('fmt.Printf("%T\\n", {})', {
      u.i(1, 'var'),
    })
  ),
}
