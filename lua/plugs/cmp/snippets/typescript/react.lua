local u = require 'plugs.cmp.snippet_utils'

return {
  u.s(
    'react-state',
    u.fmt('const [{}, set{}] = useState<{}>({})', {
      u.i(1, 'state'),
      u.f(function(args)
        local s = args[1][1]
        return s:sub(1, 1):upper() .. s:sub(2)
      end, { 1 }),
      u.i(2, 'Type'),
      u.i(3, ''),
    })
  ),
  u.s(
    'react-ref',
    u.fmt('const {} = useRef<{}>({})', {
      u.i(1, 'ref'),
      u.i(2, 'Type'),
      u.i(3, 'null'),
    })
  ),
  u.s(
    'react-component',
    u.fmt(
      [[
      interface {}Props {{
        {}
      }}

      const {}: React.FC<{}Props> = ({{{}}}) => {{
        return (
          {}
        )
      }}

      export default {}
  ]],
      {
        u.i(1, 'Name'),
        u.i(2, ''),
        u.rep(1),
        u.rep(1),
        u.i(3, ''),
        u.i(4, '<div></div>'),
        u.rep(1),
      }
    )
  ),
}
