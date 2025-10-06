local M = {}

M.make_header = function()
  -- Get the current buffer and visual selection
  local bufnr = vim.api.nvim_get_current_buf()
  local mode = vim.fn.mode()

  local start_line, end_line
  if mode == 'v' or mode == 'V' then
    -- Visual mode selection
    start_line = vim.fn.getpos("'<")[2]
    end_line = vim.fn.getpos("'>")[2]
    -- Exit visual mode
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
  else
    -- Just the current line
    start_line = vim.api.nvim_win_get_cursor(0)[1]
    end_line = start_line
  end

  -- Get the selected lines
  local lines = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)

  -- Find max length
  local max_len = 0
  for _, l in ipairs(lines) do
    if #l > max_len then
      max_len = #l
    end
  end

  -- Build header lines
  local border = string.rep('#', max_len + 4) -- padding with 2 spaces
  local result = { border }
  for _, l in ipairs(lines) do
    table.insert(result, '# ' .. l .. string.rep(' ', max_len - #l) .. ' #')
  end
  table.insert(result, border)

  -- Replace buffer lines with header block
  vim.api.nvim_buf_set_lines(bufnr, start_line - 1, end_line, false, result)
end

return M
