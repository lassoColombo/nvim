local M = {}

function M.run()
  local file = vim.api.nvim_buf_get_name(0)
  local database = vim.fn.fnamemodify(file, ':p:h:t')
  local cmd = string.format('mole cfg set %s; mole run -f %s', database, vim.fn.shellescape(file))

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      if data then
        M.show_output(data)
      end
    end,
    on_stderr = function(_, data)
      if data and #data > 0 then
        M.show_output(data)
      end
    end,
  })
end

function M.show_output(lines)
  -- Remove empty lines at the end
  while lines[#lines] == '' do
    table.remove(lines, #lines)
  end

  -- Create a new scratch buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Floating window config
  local width = math.floor(vim.o.columns * 0.7)
  local height = math.floor(vim.o.lines * 0.7)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })
end

return M
