local u = require 'custom.cmp.snippets.utils'
return {
  u.s(
    'Println',
    u.fmt('fmt.Println({})', {
      u.i(1, 'arg'),
    })
  ),
  u.s(
    'Printf',
    u.fmt('fmt.Printf("{}\\n", {})', {
      u.i(1, 'content'),
      u.i(2, 'vars'),
    })
  ),
  u.s(
    'Sprintf',
    u.fmt('fmt.Sprintf("{}\\n", {})', {
      u.i(1, 'content'),
      u.i(2, 'vars'),
    })
  ),
  u.s(
    'inspect',
    u.fmt('fmt.Printf("{} %+v\\n", {})', {
      u.i(1, ''),
      u.i(2, ''),
    })
  ),
  u.s(
    'Print-type',
    u.fmt('fmt.Printf("%T\\n", {})', {
      u.i(1, 'var'),
    })
  ),
}
