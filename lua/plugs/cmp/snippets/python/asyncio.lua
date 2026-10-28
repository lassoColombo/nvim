local u = require 'plugs.cmp.snippets.utils'

return {
  u.s(
    'func-async',
    u.fmt(
      [[
      async def {}({}) -> {}:
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
    'await',
    u.fmt('{} = await {}', {
      u.i(1, 'result'),
      u.i(2, 'coroutine'),
    })
  ),
  u.s(
    'async-with',
    u.fmt(
      [[
      async with {} as {}:
          {}
  ]],
      {
        u.i(1, 'context'),
        u.i(2, 'name'),
        u.i(3, 'pass'),
      }
    )
  ),
  u.s(
    'async-for',
    u.fmt(
      [[
      async for {} in {}:
          {}
  ]],
      {
        u.i(1, 'item'),
        u.i(2, 'aiter'),
        u.i(3, 'pass'),
      }
    )
  ),
  u.s(
    'async-run',
    u.fmt('asyncio.run({}())', {
      u.i(1, 'main'),
    })
  ),
  u.s(
    'async-gather',
    u.fmt('{} = await asyncio.gather({}, {})', {
      u.i(1, 'results'),
      u.i(2, 'coro1'),
      u.i(3, 'coro2'),
    })
  ),
  u.s(
    'async-task',
    u.fmt('{} = asyncio.create_task({}())', {
      u.i(1, 'task'),
      u.i(2, 'coroutine'),
    })
  ),
  u.s(
    'async-main',
    u.fmt(
      [[
      async def main() -> None:
          {}


      if __name__ == '__main__':
          asyncio.run(main())
  ]],
      {
        u.i(1, 'pass'),
      }
    )
  ),
}
