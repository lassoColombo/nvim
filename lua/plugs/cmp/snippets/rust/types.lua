local u = require 'plugs.cmp.snippets.utils'

return {
  u.s(
    'struct',
    u.fmt(
      [[
      struct {} {{
        {}: {},
      }}
  ]],
      {
        u.i(1, 'Name'),
        u.i(2, 'field'),
        u.i(3, 'Type'),
      }
    )
  ),
  u.s(
    'struct-derive',
    u.fmt(
      [[
      #[derive({})]
      struct {} {{
        {}: {},
      }}
  ]],
      {
        u.c(1, {
          u.t 'Debug, Clone',
          u.t 'Debug, Clone, PartialEq',
          u.t 'Debug, Clone, PartialEq, Eq, Hash',
          u.t 'Debug, Clone, Serialize, Deserialize',
        }),
        u.i(2, 'Name'),
        u.i(3, 'field'),
        u.i(4, 'Type'),
      }
    )
  ),
  u.s(
    'enum',
    u.fmt(
      [[
      enum {} {{
        {},
        {}({}),
      }}
  ]],
      {
        u.i(1, 'Name'),
        u.i(2, 'Variant'),
        u.i(3, 'TupleVariant'),
        u.i(4, 'Type'),
      }
    )
  ),
  u.s(
    'enum-derive',
    u.fmt(
      [[
      #[derive({})]
      enum {} {{
        {},
        {}({}),
      }}
  ]],
      {
        u.c(1, {
          u.t 'Debug, Clone, PartialEq',
          u.t 'Debug, Clone, PartialEq, Eq, Hash',
        }),
        u.i(2, 'Name'),
        u.i(3, 'Variant'),
        u.i(4, 'TupleVariant'),
        u.i(5, 'Type'),
      }
    )
  ),
  u.s(
    'trait',
    u.fmt(
      [[
      trait {} {{
        fn {}(&self) -> {};
      }}
  ]],
      {
        u.i(1, 'Name'),
        u.i(2, 'method'),
        u.i(3, '()'),
      }
    )
  ),
  u.s(
    'impl',
    u.fmt(
      [[
      impl {} {{
        pub fn new({}) -> Self {{
          {} {{ {} }}
        }}
      }}
  ]],
      {
        u.i(1, 'Name'),
        u.i(2, ''),
        u.rep(1),
        u.i(3, ''),
      }
    )
  ),
  u.s(
    'impl-trait',
    u.fmt(
      [[
      impl {} for {} {{
        fn {}(&self{}) -> {} {{
          {}
        }}
      }}
  ]],
      {
        u.i(1, 'Trait'),
        u.i(2, 'Type'),
        u.i(3, 'method'),
        u.i(4, ''),
        u.i(5, '()'),
        u.i(6, ''),
      }
    )
  ),
  u.s(
    'type-alias',
    u.fmt('type {} = {};', {
      u.i(1, 'Name'),
      u.i(2, 'ExistingType'),
    })
  ),
}
