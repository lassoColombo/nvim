local u = require 'plugs.cmp.snippets.utils'

return {
  u.s(
    'dec-property',
    u.fmt(
      [[
      @property
      def {}(self) -> {}:
          return self._{}

      @{}.setter
      def {}(self, value: {}) -> None:
          self._{} = value
  ]],
      {
        u.i(1, 'name'),
        u.i(2, 'Type'),
        u.rep(1),
        u.rep(1),
        u.rep(1),
        u.rep(2),
        u.rep(1),
      }
    )
  ),
  u.s(
    'dec-static',
    u.fmt(
      [[
      @staticmethod
      def {}({}) -> {}:
          {}
  ]],
      {
        u.i(1, 'name'),
        u.i(2, ''),
        u.i(3, 'None'),
        u.i(4, 'pass'),
      }
    )
  ),
  u.s(
    'dec-class',
    u.fmt(
      [[
      @classmethod
      def {}(cls, {}) -> {}:
          {}
  ]],
      {
        u.i(1, 'name'),
        u.i(2, ''),
        u.i(3, 'None'),
        u.i(4, 'pass'),
      }
    )
  ),
  u.s(
    'dec-abstract',
    u.fmt(
      [[
      @abstractmethod
      def {}(self, {}) -> {}:
          ...
  ]],
      {
        u.i(1, 'name'),
        u.i(2, ''),
        u.i(3, 'None'),
      }
    )
  ),
  u.s(
    'dec-cache',
    u.fmt(
      [[
      @functools.cache
      def {}({}) -> {}:
          {}
  ]],
      {
        u.i(1, 'name'),
        u.i(2, ''),
        u.i(3, 'None'),
        u.i(4, 'pass'),
      }
    )
  ),
  u.s(
    'dec-context',
    u.fmt(
      [[
      @contextmanager
      def {}({}):
          try:
              yield {}
          finally:
              {}
  ]],
      {
        u.i(1, 'name'),
        u.i(2, ''),
        u.i(3, 'value'),
        u.i(4, 'pass'),
      }
    )
  ),
  u.s(
    'dataclass',
    u.fmt(
      [[
      @dataclass
      class {}:
          {}: {}
  ]],
      {
        u.i(1, 'Name'),
        u.i(2, 'field'),
        u.i(3, 'type'),
      }
    )
  ),
  u.s(
    'dataclass-frozen',
    u.fmt(
      [[
      @dataclass(frozen=True)
      class {}:
          {}: {}
  ]],
      {
        u.i(1, 'Name'),
        u.i(2, 'field'),
        u.i(3, 'type'),
      }
    )
  ),
  u.s(
    'dataclass-field',
    u.fmt('{}: {} = field(default_factory={})', {
      u.i(1, 'name'),
      u.i(2, 'type'),
      u.i(3, 'list'),
    })
  ),
}
