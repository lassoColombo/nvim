local helpers = require 'ts-node-action.helpers'

local function indent(text, spaces)
  return string.format('%s%s', string.rep(' ', spaces), text)
end

return {
  function(node)
    local query = vim.treesitter.query.parse(
      'python',
      [[
          (
            (class_definition 
              name: (identifier) @classname
              superclasses: (argument_list) @superclasses)
          )
        ]]
    )
    local cldef, clname, superclasses = nil, nil, nil
    for _, matches, _ in query:iter_matches(node, 0) do
      if #matches ~= 2 then
        vim.notify('😥 something went wrong', vim.log.levels.WARN)
        return
      end
      clname = matches[1]
      superclasses = matches[2]
      break
    end

    local _, indent_start, _, _ = node:range()
    -- we want to indent by four spaces more with respect to the class definition
    indent_start = indent_start + 3

    local docstring = { indent('"""', indent_start), indent(string.format('%s ...', helpers.node_text(clname)), indent_start) }

    if superclasses then
      table.insert(docstring, indent('It inherits from:', indent_start))
      for i = 0, superclasses:named_child_count() - 1 do
        local class = helpers.node_text(superclasses:named_child(i))
        table.insert(docstring, indent(string.format('- %s: ...', class), indent_start + 4))
      end
    end
    table.insert(docstring, indent('"""', indent_start))
    table.insert(docstring, '')

    local start_row, start_col, _, _ = superclasses:child(superclasses:child_count() - 1):range()
    return docstring, { target = { start_row + 1, 0, start_row + 1, 0 } }
  end,

  name = 'generate doc for class',
}
