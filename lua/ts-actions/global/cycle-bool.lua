local M = {}

M.run = function(ft, bufnr, node)
  local text = vim.treesitter.get_node_text(node, bufnr)
  if not text then
    return vim.notify('Could not get node text', vim.log.levels.ERROR)
  end

  -- boolean mappings across languages
  local toggle_map = {
    ['true'] = 'false',
    ['false'] = 'true',
    ['True'] = 'False',
    ['False'] = 'True',
    ['TRUE'] = 'FALSE',
    ['FALSE'] = 'TRUE',
    ['1'] = '0',
    ['0'] = '1',
  }

  local replacement = toggle_map[text]
  if replacement then
    local sr, sc, er, ec = node:range()
    vim.api.nvim_buf_set_text(bufnr, sr, sc, er, ec, { replacement })
    vim.notify('Negated boolean: ' .. text .. ' → ' .. replacement)
  else
    vim.notify('Node under cursor is not a boolean literal', vim.log.levels.WARN)
  end
end

return M
