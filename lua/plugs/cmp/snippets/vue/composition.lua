local u = require 'plugs.cmp.snippets.utils'

return {
  u.s(
    'vcomp3',
    u.fmt(
      [[
      <template>
        <div class="{}">
          {}
        </div>
      </template>

      <script setup lang="ts">
      {}
      </script>

      <style scoped>
      .{} {{
        {}
      }}
      </style>
  ]],
      {
        u.i(1, 'component-name'),
        u.i(2, ''),
        u.i(3, ''),
        u.rep(1),
        u.i(4, ''),
      }
    )
  ),
  u.s(
    'vue-ref',
    u.fmt('const {} = ref<{}>({})', {
      u.i(1, 'name'),
      u.i(2, 'Type'),
      u.i(3, ''),
    })
  ),
  u.s(
    'vue-reactive',
    u.fmt(
      [[
      const {} = reactive<{}>( {{
        {}
      }})
  ]],
      {
        u.i(1, 'name'),
        u.i(2, 'Type'),
        u.i(3, ''),
      }
    )
  ),
  u.s(
    'vue-computed',
    u.fmt(
      [[
      const {} = computed(() => {})
  ]],
      {
        u.i(1, 'name'),
        u.i(2, 'expression'),
      }
    )
  ),
  u.s(
    'vue-computed-set',
    u.fmt(
      [[
      const {} = computed({{
        get: () => {},
        set: (val) => {{
          {}
        }},
      }})
  ]],
      {
        u.i(1, 'name'),
        u.i(2, 'expression'),
        u.i(3, ''),
      }
    )
  ),
  u.s(
    'vue-watch',
    u.fmt(
      [[
      watch({}, (newVal, oldVal) => {{
        {}
      }})
  ]],
      {
        u.i(1, 'source'),
        u.i(2, ''),
      }
    )
  ),
  u.s(
    'vue-watcheffect',
    u.fmt(
      [[
      watchEffect(() => {{
        {}
      }})
  ]],
      {
        u.i(1, ''),
      }
    )
  ),
  u.s(
    'vue-onmounted',
    u.fmt(
      [[
      onMounted(() => {{
        {}
      }})
  ]],
      {
        u.i(1, ''),
      }
    )
  ),
  u.s(
    'vue-onunmounted',
    u.fmt(
      [[
      onUnmounted(() => {{
        {}
      }})
  ]],
      {
        u.i(1, ''),
      }
    )
  ),
  u.s(
    'vue-props',
    u.fmt('const props = defineProps<{{ {} }}>()', {
      u.i(1, 'field: Type'),
    })
  ),
  u.s(
    'vue-emits',
    u.fmt('const emit = defineEmits<{{ {} }}>()', {
      u.i(1, 'eventName: [arg: Type]'),
    })
  ),
  u.s(
    'vue-provide',
    u.fmt('provide({}, {})', {
      u.i(1, 'key'),
      u.i(2, 'value'),
    })
  ),
  u.s(
    'vue-inject',
    u.fmt('const {} = inject<{}>({}, {})', {
      u.i(1, 'name'),
      u.i(2, 'Type'),
      u.i(3, 'key'),
      u.i(4, 'default'),
    })
  ),
}
