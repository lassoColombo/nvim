local M = {}

M.run = function(ft, bufnr, node)
  require('ts-actions.bases.toggle-multilineness').run(ft, bufnr, node, {
    query = [[
    (literal_value (literal_element) @field)
  ]],
    open = '{',
    close = '}',
  })
end

return M
