local M = {}

M.make_header = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local mode = vim.fn.mode()

  local start_line, end_line
  if mode == 'v' or mode == 'V' then
    start_line = vim.fn.getpos("'<")[2]
    end_line = vim.fn.getpos("'>")[2]
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
  else
    start_line = vim.api.nvim_win_get_cursor(0)[1]
    end_line = start_line
  end

  local lines = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)
  if #lines == 0 then
    return
  end

  -- Trim empty lines
  while #lines > 0 and lines[1]:match '^%s*$' do
    table.remove(lines, 1)
  end
  while #lines > 0 and lines[#lines]:match '^%s*$' do
    table.remove(lines, #lines)
  end
  if #lines == 0 then
    return
  end

  -- Get comment string for current filetype
  local cs = vim.bo.commentstring or '# %s'
  local comment_left, comment_right = cs:match '^(.-)%%s(.-)$'
  comment_right = comment_right or ''

  -- Find maximum length
  local max_len = 0
  for _, l in ipairs(lines) do
    if #l > max_len then
      max_len = #l
    end
  end

  local pad = 2 -- spaces on each side
  local total_len = max_len + pad * 2
  local border = comment_left .. string.rep('-', total_len) .. comment_right

  local result = { border }
  for _, l in ipairs(lines) do
    local padded = l .. string.rep(' ', max_len - #l + pad)
    table.insert(result, comment_left .. ' ' .. padded .. ' ' .. comment_right)
  end
  table.insert(result, border)

  vim.api.nvim_buf_set_lines(bufnr, start_line - 1, end_line, false, result)
  vim.api.nvim_win_set_cursor(0, { start_line, 0 })
  require('conform').format()
end

return M
