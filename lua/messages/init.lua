local M = {}

M.setup = function(o)
  vim.notify = function(msg, level, opts)
    opts = opts or {}
    level = level or vim.log.levels.INFO

    local hl_group = 'Normal'
    local border_hl = 'NotifyBorderInfo'
    local color = '#7EBBE3'

    if level == vim.log.levels.ERROR then
      hl_group = 'ErrorMsg'
      border_hl = 'NotifyBorderError'
      color = '#DB4B4A'
    elseif level == vim.log.levels.WARN then
      hl_group = 'WarningMsg'
      border_hl = 'NotifyBorderWarn'
      color = '#FF9D65'
    elseif level == vim.log.levels.INFO then
      hl_group = 'Normal'
      border_hl = 'NotifyBorderInfo'
      color = '#7EBBE3'
    end

    vim.api.nvim_set_hl(0, border_hl, { fg = color })

    local lines = vim.split(msg, '\n', { plain = true })
    local width = vim.o.columns

    local longest_line = 0
    for _, line in ipairs(lines) do
      if #line > longest_line then
        longest_line = #line
      end
    end
    local win_width = math.min(longest_line, math.floor(width * 0.6))
    local win_height = #lines

    local col = width - win_width - 2
    local row = 1

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    local win = vim.api.nvim_open_win(buf, false, {
      relative = 'editor',
      width = win_width,
      height = win_height,
      row = row,
      col = col,
      style = 'minimal',
      border = 'rounded',
    })

    vim.api.nvim_win_set_option(win, 'winhl', 'Normal:' .. hl_group .. ',FloatBorder:' .. border_hl)

    -- breaks on multiline messages
    -- vim.cmd('echom ' .. '"' .. vim.fn.string(msg) .. '"')

    local timeout = opts.timeout or 3000
    vim.defer_fn(function()
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
    end, timeout)
  end
end

return M
