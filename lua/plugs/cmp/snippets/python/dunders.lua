local u = require 'plugs.cmp.snippet_utils'

local dunders = {
  __new__ = { 'cls', '*args', '**kwargs' },
  __init__ = { 'self', '*args', '**kwargs' },
  __del__ = { 'self' },
  __trunc__ = { 'self' },
  __ceil__ = { 'self' },
  __floor__ = { 'self' },
  __round__ = { 'self', 'ndigits=None' },
  __invert__ = { 'self' },
  __abs__ = { 'self' },
  __neg__ = { 'self' },
  __pos__ = { 'self' },
  __add__ = { 'self', 'other' },
  __sub__ = { 'self', 'other' },
  __mul__ = { 'self', 'other' },
  __floordiv__ = { 'self', 'other' },
  __truediv__ = { 'self', 'other' },
  __mod__ = { 'self', 'other' },
  __divmod__ = { 'self', 'other' },
  __lshift__ = { 'self', 'other' },
  __rshift__ = { 'self', 'other' },
  __and__ = { 'self', 'other' },
  __or__ = { 'self', 'other' },
  __xor__ = { 'self', 'other' },
  __str__ = { 'self' },
  __repr__ = { 'self' },
  __format__ = { 'self', 'formatstr' },
  __hash__ = { 'self' },
  __bool__ = { 'self' },
  __dir__ = { 'self' },
  __sizeof__ = { 'self' },
  __eq__ = { 'self', 'other' },
  __ne__ = { 'self', 'other' },
  __lt__ = { 'self', 'other' },
  __gt__ = { 'self', 'other' },
  __le__ = { 'self', 'other' },
  __pow__ = { 'self', 'other' },
  __ge__ = { 'self', 'other' },
}

local res = {}

for name, arguments in pairs(dunders) do
  table.insert(res, u.s(name, u.fmt(string.format('def %s(%s):\n\t{}', name, table.concat(arguments, ', ')), { u.i(1, 'pass') })))
end

return res
