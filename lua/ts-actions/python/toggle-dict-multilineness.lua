local M = {}

M.run = function(ft, bufnr, node)
  require('ts-actions.bases.toggle-multilineness').run(ft, bufnr, node, {
    query = [[
      (dictionary (pair) @field)
    ]],
    open = '{',
    close = '}',
  })
end

return M
