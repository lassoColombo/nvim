local M = {}

M.run = function(ft, bufnr, node)
  local text = vim.treesitter.get_node_text(node, bufnr)
  if not text or #text < 2 then
    return vim.notify('Could not get valid string node text', vim.log.levels.ERROR)
  end

  local first, last = text:sub(1, 1), text:sub(-1)
  local body = text:sub(2, -2)

  -- Only handle strings properly enclosed
  if not ((first == '"' or first == "'" or first == '`') and first == last) then
    return vim.notify('Node under cursor is not a simple string literal', vim.log.levels.WARN)
  end

  -- cycle through: " → ' → ` → "
  local cycle = { ['"'] = "'", ["'"] = '"' }
  local new_delim = cycle[first]

  local replacement = new_delim .. body .. new_delim

  local sr, sc, er, ec = node:range()
  vim.api.nvim_buf_set_text(bufnr, sr, sc, er, ec, { replacement })
  vim.notify('Toggled string delimiter: ' .. first .. ' → ' .. new_delim)
end

return M
