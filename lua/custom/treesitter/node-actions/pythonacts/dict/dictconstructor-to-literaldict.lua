local helpers = require 'ts-node-action.helpers'

local function parse_kwarg(kwarg)
  local identifier = kwarg:child(0)
  local itext = '"' .. helpers.node_text(identifier) .. '"'
  local value = kwarg:child(2)
  local vtext = helpers.node_text(value)
  return itext .. ': ' .. vtext
end

return {
  function(node)
    local text = helpers.node_text(node)
    if text ~= 'dict' then
      vim.notify('this is not a dict constructor 😥', vim.log.levels.WARN)
      return text
    end

    local arguments = node:next_sibling()
    local kvpairs = {}
    for child in arguments:iter_children() do
      local ntype = child:type()
      if ntype == 'keyword_argument' then
        table.insert(kvpairs, parse_kwarg(child))
      elseif ntype == 'dictionary_splat' then
        table.insert(kvpairs, helpers.node_text(child))
      end
    end

    local res = '{'
    for i = 1, #kvpairs - 1 do
      res = res .. kvpairs[i] .. ', '
    end
    res = res .. kvpairs[#kvpairs] .. '}'

    local parent_call = node:parent()
    return res, { target = parent_call }
  end,

  name = 'dict constructor to literal',
}
