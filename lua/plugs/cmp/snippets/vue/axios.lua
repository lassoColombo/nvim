local u = require 'plugs.cmp.snippet_utils'

return {
  u.s(
    'axget',
    u.fmt(
      [[
      this.$axios.get('{}', {{ params: {{}} }})
        .then(response => {{
          {}
        }})
        .catch(error => {{
          console.error(error)
          {}
        }})
  ]],
      { u.i(1, '/api/endpoint'), u.i(2, ''), u.i(3, '') }
    )
  ),
  u.s(
    'axpost',
    u.fmt(
      [[
      this.$axios.post('{}', {{
        {}
      }})
        .then(response => {{
          {}
        }})
        .catch(error => {{
          console.error(error)
          {}
        }})
  ]],
      { u.i(1, '/api/endpoint'), u.i(2, ''), u.i(3, ''), u.i(4, '') }
    )
  ),
}
