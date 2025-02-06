local helpers = require 'ts-node-action.helpers'

local function parse_pair(pair)
  local key = pair:child(0)
  local ktype = key:type()
  local value = pair:child(2)
  local ktext = helpers.node_text(key)
  local vtext = helpers.node_text(value)

  if ktype == 'string' then
    ktext = helpers.node_text(key:child(1))
  end

  return ktext .. '=' .. vtext
end

return {
  function(node)
    local args = {}
    for pair in node:iter_children() do
      local ntype = pair:type()
      if pair:type() == 'pair' then
        table.insert(args, parse_pair(pair))
      elseif pair:type() == 'dictionary_splat' then
        table.insert(args, helpers.node_text(pair))
      end
    end

    local res = '('
    for i = 1, #args - 1 do
      res = res .. args[i] .. ', '
    end
    res = res .. args[#args] .. ')'

    return 'dict' .. res
  end,

  name = 'literal dict to dict constructor',
}
