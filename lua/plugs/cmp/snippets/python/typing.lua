local u = require 'plugs.cmp.snippets.utils'

return {
  u.s(
    'type-var',
    u.fmt("{} = TypeVar('{}')", {
      u.i(1, 'T'),
      u.rep(1),
    })
  ),
  u.s(
    'type-var-bound',
    u.fmt("{} = TypeVar('{}', bound={})", {
      u.i(1, 'T'),
      u.rep(1),
      u.i(2, 'BaseClass'),
    })
  ),
  u.s(
    'type-protocol',
    u.fmt(
      [[
      class {}(Protocol):
          def {}(self, {}) -> {}:
              {}
  ]],
      {
        u.i(1, 'Name'),
        u.i(2, 'method'),
        u.i(3, ''),
        u.i(4, 'None'),
        u.i(5, '...'),
      }
    )
  ),
  u.s(
    'type-generic',
    u.fmt(
      [[
      class {}(Generic[{}]):
          def __init__(self, val: {}) -> None:
              {}
  ]],
      {
        u.i(1, 'Name'),
        u.i(2, 'T'),
        u.rep(2),
        u.i(3, 'pass'),
      }
    )
  ),
  u.s(
    'type-dict',
    u.fmt(
      [[
      class {}(TypedDict):
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
    'type-optional',
    u.fmt('Optional[{}]', {
      u.i(1, 'Type'),
    })
  ),
  u.s(
    'type-union',
    u.fmt('Union[{}, {}]', {
      u.i(1, 'TypeA'),
      u.i(2, 'TypeB'),
    })
  ),
  u.s(
    'type-list',
    u.fmt('list[{}]', {
      u.i(1, 'Type'),
    })
  ),
  u.s(
    'type-dict-inline',
    u.fmt('dict[{}, {}]', {
      u.i(1, 'KeyType'),
      u.i(2, 'ValueType'),
    })
  ),
  u.s(
    'type-callable',
    u.fmt('Callable[[{}], {}]', {
      u.i(1, 'ArgType'),
      u.i(2, 'ReturnType'),
    })
  ),
}
