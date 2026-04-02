local u = require 'plugs.cmp.snippets.utils'

return {
  u.s(
    'test-func',
    u.fmt(
      [[
      func Test{}(t *testing.T) {{
        {}
      }}
  ]],
      {
        u.i(1, 'Name'),
        u.i(2, ''),
      }
    )
  ),
  u.s(
    'test-run',
    u.fmt(
      [[
      t.Run("{}", func(t *testing.T) {{
        {}
      }})
  ]],
      {
        u.i(1, 'subtest name'),
        u.i(2, ''),
      }
    )
  ),
  u.s(
    'test-table',
    u.fmt(
      [[
      func Test{}(t *testing.T) {{
        tests := []struct {{
          name  string
          input {}
          want  {}
        }}{{
          {{name: "{}", input: {}, want: {}}},
        }}

        for _, tc := range tests {{
          t.Run(tc.name, func(t *testing.T) {{
            got := {}(tc.input)
            if got != tc.want {{
              t.Errorf("got %v, want %v", got, tc.want)
            }}
          }})
        }}
      }}
  ]],
      {
        u.i(1, 'FuncName'),
        u.i(2, 'InputType'),
        u.i(3, 'WantType'),
        u.i(4, 'case name'),
        u.i(5, 'inputVal'),
        u.i(6, 'wantVal'),
        u.i(7, 'FunctionUnderTest'),
      }
    )
  ),
  u.s(
    'bench-func',
    u.fmt(
      [[
      func Benchmark{}(b *testing.B) {{
        for i := 0; i < b.N; i++ {{
          {}
        }}
      }}
  ]],
      {
        u.i(1, 'Name'),
        u.i(2, ''),
      }
    )
  ),
  u.s('test-helper', u.t 't.Helper()'),
  u.s(
    'test-error',
    u.fmt('t.Errorf("got %v, want %v", {}, {})', {
      u.i(1, 'got'),
      u.i(2, 'want'),
    })
  ),
  u.s(
    'test-fatal',
    u.fmt('t.Fatalf("got %v, want %v", {}, {})', {
      u.i(1, 'got'),
      u.i(2, 'want'),
    })
  ),
  u.s(
    'test-assert',
    u.fmt(
      [[
      if {} != {} {{
        t.Errorf("got %v, want %v", {}, {})
      }}
  ]],
      {
        u.i(1, 'got'),
        u.i(2, 'want'),
        u.rep(1),
        u.rep(2),
      }
    )
  ),
  u.s(
    'test-no-error',
    u.fmt(
      [[
      if err != nil {{
        t.Fatalf("unexpected error: %v", err)
      }}
  ]],
      {}
    )
  ),
}
