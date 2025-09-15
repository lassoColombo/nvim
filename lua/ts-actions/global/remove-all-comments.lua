local M = {}

M.run = function(ft, bufnr, _)
  local ts = vim.treesitter

  local lang = ts.language.get_lang(ft) or ft

  local ok, parser = pcall(ts.get_parser, bufnr, lang)
  if not ok then
    return vim.notify('No parser for ' .. ft, vim.log.levels.WARN)
  end

  local tree = parser:parse()[1]
  local root = tree:root()

  local query = ts.query.parse(lang, '(comment) @comment')

  local ranges = {}
  for _, node in query:iter_captures(root, bufnr, 0, -1) do
    table.insert(ranges, { node:range() })
  end

  if #ranges == 0 then
    return vim.notify('No comments found.', vim.log.levels.INFO)
  end
  ---
  vim.ui.select({ 'Greedy', 'Cautious', 'No' }, { prompt = 'Delete ' .. #ranges .. ' comments?' }, function(choice)
    if choice == 'No' then
      return
    end
    ---

    table.sort(ranges, function(a, b)
      if a[1] == b[1] then
        return a[2] < b[2]
      end
      return a[1] > b[1]
    end)

    if choice == 'Greedy' then
      for _, r in ipairs(ranges) do
        vim.api.nvim_buf_set_text(bufnr, r[1], r[2], r[3], r[4], {})
      end
      require('conform').format { bufnr = 0 }
      vim.notify(#ranges .. 'comments deleted.')
      return
    end

    -- local ns = vim.api.nvim_create_namespace 'my_temp_highlight'
    for _, r in ipairs(ranges) do
      local start_row, start_col, end_row, end_col = r[1], r[2], r[3], r[4]

      vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })

      -- local hl_id = vim.api.nvim_buf_set_extmark(bufnr, ns, start_row, start_col, {
      --   end_row = end_row,
      --   end_col = end_col,
      --   hl_group = 'Visual',
      --   hl_eol = true,
      -- })
      -- 3. Prompt user
      local choice = vim.fn.confirm('Delete this region?', '&Yes\n&No', 2)
      if choice == 1 then
        vim.api.nvim_buf_set_text(bufnr, start_row, start_col, end_row, end_col, {})
      end
      ---
      -- vim.api.nvim_buf_del_extmark(bufnr, ns, hl_id)
    end

    require('conform').format { bufnr = 0 }
    vim.notify(#ranges .. 'comments deleted.')
  end)
end

return M
