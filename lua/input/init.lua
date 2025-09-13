local M = {}

M.setup = function(o)
  local function wininput(opts, on_confirm, win_opts)
    local buf = vim.api.nvim_create_buf(false, false)
    vim.bo[buf].buftype = 'prompt'
    vim.bo[buf].bufhidden = 'wipe'

    local prompt = opts.prompt or ''
    local default_text = opts.default or ''

    local deferred_callback = function(input)
      vim.defer_fn(function()
        on_confirm(input)
      end, 10)
    end

    vim.fn.prompt_setprompt(buf, prompt)
    vim.fn.prompt_setcallback(buf, deferred_callback)

    vim.keymap.set({ 'i', 'n' }, '<CR>', '<CR><Esc>:close!<CR>:stopinsert<CR>', {
      silent = true,
      buffer = buf,
    })
    vim.keymap.set('n', '<esc>', function()
      return vim.fn.mode() == 'n' and 'ZQ' or '<esc>'
    end, { expr = true, silent = true, buffer = buf })

    vim.keymap.set('n', 'q', function()
      return vim.fn.mode() == 'n' and 'ZQ' or '<esc>'
    end, { expr = true, silent = true, buffer = buf })

    local default_win_opts = {
      relative = 'editor',
      row = vim.o.lines / 2 - 1,
      col = vim.o.columns / 2 - 25,
      width = 50,
      height = 1,
      focusable = true,
      style = 'minimal',
      border = 'rounded',
      noautocmd = true,
    }

    win_opts = vim.tbl_deep_extend('force', default_win_opts, win_opts)

    local min_width = 80
    local needed_width = #default_text + #prompt + 5
    win_opts.width = math.max(win_opts.width, needed_width, min_width)

    local win = vim.api.nvim_open_win(buf, true, win_opts)

    vim.wo[win].wrap = false

    vim.cmd 'startinsert'

    vim.defer_fn(function()
      vim.api.nvim_buf_set_text(buf, 0, #prompt, 0, #prompt, { default_text })

      vim.api.nvim_win_set_cursor(0, { 1, #prompt + 1 })
    end, 5)
  end

  ---@diagnostic disable-next-line: duplicate-set-field
  vim.ui.input = function(opts, on_confirm)
    wininput(opts, on_confirm, {
      border = 'rounded',
      relative = 'cursor',
      row = 1,
      col = 0,
      width = 0,
    })
  end
end

return M
