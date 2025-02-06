local helpers = require 'ts-node-action.helpers'

local function indent(text, spaces)
  return string.format('%s%s', string.rep(' ', spaces), text)
end

local function multiinsert(dest, ...)
  local src = { ... }
  for _, el in ipairs(src) do
    table.insert(dest, el)
  end
end

local function extract_args(node)
  local query = vim.treesitter.query.parse(
    'python',
    [[
        (
          (function_definition
           parameters: (parameters) @args)
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
    'python',
    [[
        (
          (function_definition
           return_type: (type) @rettype)
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
    'python',
    [[
        (
          (function_definition
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

    local _, indent_start, _, _ = node:range()
    -- we want to indent by four spaces more with respect to the class definition
    indent_start = indent_start + 4

    local docstring = { indent('"""', indent_start), indent(string.format('%s ...', helpers.node_text(fnname)), indent_start) }

    local argtexts = {}
    for i = 0, args:named_child_count() - 1 do
      table.insert(argtexts, helpers.node_text(args:named_child(i)))
    end

    local is_method = argtexts[1] == 'self' or argtexts[1] == 'cls'
    if not (#argtexts == 1 and is_method) then
      local starti = is_method and 2 or 1
      table.insert(docstring, indent('inputs:', indent_start))
      for i = starti, #argtexts do
        table.insert(docstring, indent(string.format('- %s: ...', argtexts[i]), indent_start + 4))
      end
    end

    if rettype then
      multiinsert(docstring, indent('returns:', indent_start), indent(string.format('- %s: ...', helpers.node_text(rettype)), indent_start + 4))
    end

    multiinsert(docstring, indent('"""', indent_start), '')

    local last_node = rettype and rettype or args
    local start_row, start_col, _, _ = last_node:named_child(last_node:named_child_count() - 1):range()
    return docstring, { target = { start_row + 1, 0, start_row + 1, 0 } }
  end,

  name = 'generate doc for method',
}
