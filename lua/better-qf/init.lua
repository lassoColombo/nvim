local M = {}

M.setup = function(opts)
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'qf',
    callback = function(args)
      local list_buf = args.buf
      local preview_win, preview_buf

      vim.api.nvim_create_autocmd('BufLeave', {
        buffer = list_buf,
        callback = function()
          if preview_win and vim.api.nvim_win_is_valid(preview_win) then
            vim.api.nvim_win_close(preview_win, true)
            preview_win = nil
          end
        end,
      })

      vim.api.nvim_set_hl(0, 'QfPreviewScope', { bg = '#444444', fg = 'NONE' })

      vim.api.nvim_create_autocmd('CursorMoved', {
        buffer = list_buf,
        callback = function()
          local winid = vim.api.nvim_get_current_win()
          local wininfo = vim.fn.getwininfo(winid)[1]

          local items = (wininfo.loclist == 1) and vim.fn.getloclist(wininfo.winid) or vim.fn.getqflist()

          local lnum = vim.api.nvim_win_get_cursor(0)[1]
          local item = items[lnum]
          if not item or not item.bufnr or item.bufnr == 0 then
            return
          end

          if not vim.api.nvim_buf_is_loaded(item.bufnr) then
            pcall(vim.fn.bufload, item.bufnr)
            pcall(vim.api.nvim_buf_call, item.bufnr, function()
              vim.cmd 'filetype detect'
            end)
          end

          if not (preview_buf and vim.api.nvim_buf_is_valid(preview_buf)) then
            preview_buf = vim.api.nvim_create_buf(false, true)
          end

          if not (preview_win and vim.api.nvim_win_is_valid(preview_win)) then
            preview_win = vim.api.nvim_open_win(preview_buf, false, {
              relative = 'editor',
              width = vim.o.columns,
              height = wininfo.winrow - 3,
              row = 0,
              col = 0,
              style = 'minimal',
              border = 'rounded',
            })
          end

          vim.wo[preview_win].number = true
          vim.wo[preview_win].relativenumber = false

          local lines = vim.api.nvim_buf_get_lines(item.bufnr, 0, -1, false)
          vim.api.nvim_buf_set_lines(preview_buf, 0, -1, false, lines)

          pcall(vim.api.nvim_win_set_cursor, preview_win, { item.lnum, math.max(item.col - 1, 0) })

          vim.bo[preview_buf].filetype = vim.bo[item.bufnr].filetype

          vim.api.nvim_buf_clear_namespace(preview_buf, -1, 0, -1)

          local start_line = item.lnum - 1
          local start_col = math.max(item.col - 1, 0)
          local end_line = (item.end_lnum and item.end_lnum > 0) and (item.end_lnum - 1) or start_line
          local end_col = (item.end_col and item.end_col > 0) and (item.end_col - 1) or -1

          if end_col == -1 then
            vim.api.nvim_buf_add_highlight(preview_buf, -1, 'QfPreviewScope', start_line, 0, -1)
          else
            vim.api.nvim_buf_set_extmark(preview_buf, vim.api.nvim_create_namespace 'qfpreview', start_line, start_col, {
              end_line = end_line,
              end_col = end_col,
              hl_group = 'QfPreviewScope',
              hl_eol = true,
            })
          end
        end,
      })
    end,
  })

  local function remove_current()
    local idx = vim.fn.line '.'
    local l = vim.fn.getqflist()
    table.remove(l, idx)
    vim.fn.setqflist(l, 'r')
    vim.cmd 'copen'

    local new_idx = math.max(idx - 1, 1)
    vim.api.nvim_win_set_cursor(0, { new_idx, 0 })
  end

  vim.api.nvim_create_autocmd('FileType', {

    pattern = 'qf',
    callback = function(args)
      vim.keymap.set('n', '<C-x>', remove_current, { buffer = args.buf, silent = true, desc = '[Q]delete current entry' })
    end,
  })

  vim.keymap.set('n', '<leader>q', '<cmd>copen<cr>', { desc = '[Q]open' })
  vim.keymap.set('n', '<leader>l', '<cmd>lopen<cr>', { desc = '[L]open' })
end

return M
