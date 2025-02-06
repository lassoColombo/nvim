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

local function extract_args(node)
  local query = vim.treesitter.query.parse(
    'go',
    [[
        (
          (function_declaration
           parameters: (parameter_list) @rettype)
        )
    ]]
  )
  local args = nil
  for _, capt, _ in query:iter_captures(node, 0) do
    args = capt
    break
  end
  return args
end

local function extract_rettype(node)
  local query = vim.treesitter.query.parse(
    'go',
    [[
    (
      (function_declaration[
         result: (type_identifier)
         result: (parameter_list)
      ] @ret ) 
    )
        ]]
  )
  local rettype = nil
  for _, capt, _ in query:iter_captures(node, 0) do
    rettype = capt
    break
  end
  return rettype
end

local function extract_fnname(node)
  local query = vim.treesitter.query.parse(
    'go',
    [[
        (
          (function_declaration
           name: (identifier) @fnname)
        )
        ]]
  )
  local rettype = nil
  for _, capt, _ in query:iter_captures(node, 0) do
    rettype = capt
    break
  end
  return rettype
end

return {
  function(node)
    local args = extract_args(node)
    local rettype = extract_rettype(node)
    local fnname = extract_fnname(node)

    local start_row, start_col, _, _ = node:range()

    local preface = helpers.node_text(fnname) .. ' ...'
    local docstring = { fmt(preface, start_col) }

    local child_count = args:named_child_count()
    if child_count > 0 then
      local inputs_header = comment(indent(start_col + 2, '- inputs:'))
      table.insert(docstring, inputs_header)
    end
    for i = 0, child_count - 1 do
      local child = args:named_child(i)
      local fmtd_arg = comment(indent(start_col + 4, helpers.node_text(child) .. ': ...'))
      table.insert(docstring, fmtd_arg)
    end

    if rettype then
      if rettype:type() == 'type_identifier' then
        local rettype_header = comment(indent(start_col + 2, '- return value:'))
        table.insert(docstring, rettype_header)
        local fmtd_ret = indent(start_col, comment(indent(4, helpers.node_text(rettype) .. ': ...')))
        table.insert(docstring, fmtd_ret)
      else
        local rettype_header = comment(indent(start_col + 2, '- return values:'))
        table.insert(docstring, rettype_header)
        for i = 0, rettype:named_child_count() - 1 do
          local child = rettype:named_child(i)
          local fmtd_ret = indent(start_col, comment(indent(4, helpers.node_text(child) .. ': ...')))
          table.insert(docstring, fmtd_ret)
        end
      end
    end

    table.insert(docstring, '')
    return docstring, { target = { start_row, 0, start_row, 0 } }
  end,

  name = 'generate doc for function',
}
