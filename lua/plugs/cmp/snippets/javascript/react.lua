local u = require 'plugs.cmp.snippet_utils'

return {
  u.s(
    'react-effect',
    u.fmt(
      [[
      useEffect(() => {{
        {}
        return () => {{
          {}
        }}
      }}, [{}])
  ]],
      {
        u.i(1, ''),
        u.i(2, ''),
        u.i(3, ''),
      }
    )
  ),
  u.s(
    'react-callback',
    u.fmt(
      [[
      useCallback(({}) => {{
        {}
      }}, [{}])
  ]],
      {
        u.i(1, ''),
        u.i(2, ''),
        u.i(3, ''),
      }
    )
  ),
  u.s(
    'react-memo',
    u.fmt('useMemo(() => {}, [{}])', {
      u.i(1, 'expression'),
      u.i(2, ''),
    })
  ),
  u.s(
    'react-context',
    u.fmt('const {} = useContext({})', {
      u.i(1, 'value'),
      u.i(2, 'Context'),
    })
  ),
}
