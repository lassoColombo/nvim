local M = {}

M.run = function(ft, bufnr, node, cfg)
  local ts = vim.treesitter

  if not cfg then
    return vim.notify('No config for language: ' .. ft, vim.log.levels.WARN)
  end

  local sr, sc, er, ec = node:range()

  local captures = {}
  for child, _ in node:iter_children() do
    local query = vim.treesitter.query.parse(
      'lua',
      [[
      (field
        name: (_) @key
        value: (table_constructor) @value
      ) @field
  ]]
    )
    -- Execute the query on the child node
    local matches = {}
    for id, match, metadata in query:iter_matches(child, 0, child:start(), child:end_()) do
      table.insert(matches, match)
    end

    if #matches > 0 then
      M.run(ft, bufnr, child, cfg)
      local r, c = child:range()
      table.insert(captures, { node = child, row = r, col = c })
    else
      local r, c = child:range()
      table.insert(captures, { node = child, row = r, col = c })
    end
  end

  table.sort(captures, function(a, b)
    if a.row == b.row then
      return a.col < b.col
    end
    return a.row < b.row
  end)

  local items = {}
  for _, c in ipairs(captures) do
    local txt = ts.get_node_text(c.node, bufnr) or ''
    table.insert(items, txt)
  end

  local node_text = ts.get_node_text(node, bufnr) or ''
  local is_multiline = node_text:find '\n' and true or false

  local replacement_lines = {}

  if is_multiline then
    if #items == 0 then
      replacement_lines = { cfg.open .. cfg.close }
    else
      replacement_lines = { cfg.open .. ' ' .. table.concat(items, ', ') .. ' ' .. cfg.close }
    end
    vim.notify 'Collapsed to single line'
  else
    local inner_indent = string.rep(' ', sc + 2)
    local closing_indent = string.rep(' ', sc)

    table.insert(replacement_lines, cfg.open)
    if #items > 0 then
      for _, it in ipairs(items) do
        table.insert(replacement_lines, inner_indent .. it .. ',')
      end
    end
    table.insert(replacement_lines, closing_indent .. cfg.close)

    vim.notify 'Expanded to multiple lines'
  end

  vim.api.nvim_buf_set_text(bufnr, sr, sc, er, ec, replacement_lines)

  local ok, conform = pcall(require, 'conform')
  if ok then
    conform.format { bufnr = bufnr }
  end
end

return M
