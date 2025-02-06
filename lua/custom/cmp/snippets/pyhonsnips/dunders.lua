local u = require 'custom.cmp.snippets.utils'

local dunders = {
  __new__ = { 'self', '*arg', '**kwargs' },
  __init__ = { 'self', '*arg', '**kwargs' },
  __del__ = { 'self', '*arg', '**kwargs' },
  __trunc__ = { 'self' },
  __ceil__ = { 'self' },
  __floor__ = { 'self' },
  __round__ = { 'self' },
  __invert__ = { 'self' },
  __abs__ = { 'self' },
  __neg__ = { 'self' },
  __pos__ = { 'self' },
  __add__ = { 'self', 'other' },
  __sub__ = { 'self', 'other' },
  __mul__ = { 'self', 'other' },
  __floordiv__ = { 'self', 'other' },
  __div__ = { 'self', 'other' },
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
  __unicode__ = { 'self' },
  __format__ = { 'self', 'formatstr' },
  __hash__ = { 'self' },
  __nonzero__ = { 'self' },
  __dir__ = { 'self' },
  __sizeof__ = { 'self' },
  __eq__ = { 'self', 'other' },
  __ne__ = { 'self', 'other' },
  __lt__ = { 'self', 'other' },
  __gt__ = { 'self', 'other' },
  __le__ = { 'self', 'other' },
  __pow__ = { 'self' },
  __ge__ = { 'self', 'other' },
}

local function build_args(args)
  local res = '('
  for i = 1, #args - 1 do
    res = res .. args[i] .. ', '
  end
  res = res .. args[#args] .. ')'
  return res
end

local res = {}

for name, arguments in pairs(dunders) do
  table.insert(res, u.s(name, u.fmt(string.format('def %s%s:\n\t{}', name, build_args(arguments)), { u.i(1, 'pass') })))
end

return res
