local u = require 'plugs.cmp.snippets.utils'

return {
  u.s('vimportvuex', u.fmt("import {{ mapState, mapGetters, mapActions, mapMutations }} from 'vuex'", {})),
  u.s('vmapstate', u.fmt("...mapState('{}', ['{}'])", { u.i(1, 'module'), u.i(2, 'prop') })),
  u.s('vmapgetters', u.fmt("...mapGetters('{}', ['{}'])", { u.i(1, 'module'), u.i(2, 'getter') })),
  u.s('vmapactions', u.fmt("...mapActions('{}', ['{}'])", { u.i(1, 'module'), u.i(2, 'action') })),
  u.s('vmapmutations', u.fmt("...mapMutations('{}', ['{}'])", { u.i(1, 'module'), u.i(2, 'mutation') })),
}
