local u = require 'plugs.cmp.snippets.utils'

return {
  u.s(
    'vcomp',
    u.fmt(
      [[
      <template>
        <div class="{}">
          {}
        </div>
      </template>

      <script>
      export default {{
        name: '{}',
        components: {{}},
        props: {{}},
        data() {{
          return {{
            {}
          }}
        }},
        computed: {{}},
        methods: {{}},
      }}
      </script>

      <style lang="less" scoped>
      .{} {{
        {}
      }}
      </style>
  ]],
      {
        u.i(1, 'component-name'),
        u.i(2, ''),
        u.i(3, 'ComponentName'),
        u.i(4, ''),
        u.rep(1),
        u.i(5, ''),
      }
    )
  ),
}
