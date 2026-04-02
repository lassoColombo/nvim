local u = require 'plugs.cmp.snippets.utils'

return {
  u.s(
    'match',
    u.fmt(
      [[
      match {} {{
        {} => {},
        _ => {},
      }}
  ]],
      {
        u.i(1, 'value'),
        u.i(2, 'Pattern'),
        u.i(3, 'expression'),
        u.i(4, ''),
      }
    )
  ),
  u.s(
    'match-struct',
    u.fmt(
      [[
      match {} {{
        {} {{ {}, .. }} => {{
          {}
        }}
        _ => {{}}
      }}
  ]],
      {
        u.i(1, 'value'),
        u.i(2, 'TypeName'),
        u.i(3, 'field'),
        u.i(4, ''),
      }
    )
  ),
  u.s(
    'iter-map',
    u.fmt('.iter().map(|{}| {}).collect::<Vec<_>>()', {
      u.i(1, 'item'),
      u.i(2, 'expression'),
    })
  ),
  u.s(
    'iter-filter',
    u.fmt('.iter().filter(|{}| {}).collect::<Vec<_>>()', {
      u.i(1, 'item'),
      u.i(2, 'predicate'),
    })
  ),
  u.s(
    'vec',
    u.fmt('vec![{}]', {
      u.i(1, ''),
    })
  ),
  u.s(
    'hashmap',
    u.fmt('let mut {}: HashMap<{}, {}> = HashMap::new();', {
      u.i(1, 'name'),
      u.i(2, 'K'),
      u.i(3, 'V'),
    })
  ),
  u.s(
    'derive',
    u.fmt('#[derive({})]', {
      u.c(1, {
        u.t 'Debug',
        u.t 'Debug, Clone',
        u.t 'Debug, Clone, PartialEq',
        u.t 'Debug, Clone, PartialEq, Eq, Hash',
        u.i '',
      }),
    })
  ),
  u.s(
    'test-mod',
    u.fmt(
      [[
      #[cfg(test)]
      mod tests {{
        use super::*;

        #[test]
        fn {}() {{
          {}
        }}
      }}
  ]],
      {
        u.i(1, 'test_name'),
        u.i(2, ''),
      }
    )
  ),
  u.s(
    'log',
    u.fmt('println!("{}", {})', {
      u.i(1, '{}'),
      u.i(2, 'value'),
    })
  ),
  u.s(
    'log-debug',
    u.fmt('dbg!(&{})', {
      u.i(1, 'value'),
    })
  ),
  u.s(
    'log-fmt',
    u.fmt('eprintln!("{}", {})', {
      u.i(1, '{}'),
      u.i(2, 'value'),
    })
  ),
}
