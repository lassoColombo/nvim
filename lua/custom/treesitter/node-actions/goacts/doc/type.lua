local helpers = require 'ts-node-action.helpers'

local function indent(spaces, text)
  return string.format('%s%s', string.rep(' ', spaces), text)
end

local function comment(s)
  return '// ' .. s
end

local function fmt(s, indent_level)
  return indent(indent_level, comment(s))
end

local function extract_name(node)
  local query = vim.treesitter.query.parse(
    'go',
    [[
      (
        (type_spec
          name: (type_identifier) @name)
      )
        ]]
  )
  local type_name = nil
  for _, capt, _ in query:iter_captures(node, 0) do
    type_name = capt
    break
  end
  return type_name
end

local function extract_type(node)
  local query = vim.treesitter.query.parse(
    'go',
    [[
      (
        (type_spec
          type: (type_identifier) @type)
      )
        ]]
  )
  local type_node = nil
  for _, capt, _ in query:iter_captures(node, 0) do
    type_node = capt
    break
  end
  return type_node
end

return {
  function(node)
    local start_row, start_col, _, _ = node:range()

    local name = extract_name(node)
    local type_node = extract_type(node)

    local preface = helpers.node_text(name) .. ' ...'
    local docstring = { fmt(preface, start_col), '' }
    -- :NOTE: for now just the name is ok
    return docstring, { target = { start_row, 0, start_row, 0 } }

    -- local type_string = type_node:type()
    -- if type_string ~= 'struct_type' or type_string ~= 'interface_type' then
    -- return docstring, { target = { start_row, 0, start_row, 0 } }
    -- end
    -- if type_string == 'struct_type' then
    --   -- :TODO:
    -- end
    -- if type_string == 'interface_type' then
    --   -- :TODO:
    -- end
  end,

  name = 'generate doc for struct',
}
