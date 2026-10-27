-- filewatch: keep buffers in sync with the file on disk when the same file is
-- edited from several nvim instances (e.g. the same repo in multiple zellij
-- sessions).
--
-- What nvim does on its own: it compares timestamps only after a shell
-- command, on FocusGained and on :checktime, and when 'autoread' is set it
-- reloads an unmodified buffer *silently*. Focus events are unreliable through
-- a multiplexer, so a buffer can sit on stale content for hours and then
-- overwrite the other session's work on :w.
--
-- What this module adds:
--   * :checktime on more events plus a background timer, so stale buffers are
--     caught within a couple of seconds (only in normal mode, never mid-typing).
--   * a notification whenever a buffer is reloaded from disk.
--   * a prompt when the buffer is modified AND the file changed on disk, with
--     a "diff against disk" option on top of load/keep.
--   * a loud warning when the file is already open in another running nvim
--     (nvim's default handler silently edits anyway).
local M = {}

local group = vim.api.nvim_create_augroup('filewatch', { clear = true })
local timer

M.config = {
  interval = 2000, -- ms between background checks; 0 disables the timer
}

local function fname(buf)
  return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ':~:.')
end

local function notify(msg, level)
  vim.notify('filewatch: ' .. msg, level or vim.log.levels.INFO)
end

local function can_check()
  local mode = vim.api.nvim_get_mode()
  return (mode.mode == 'n' or mode.mode == 'nt') and not mode.blocking and vim.fn.getcmdwintype() == ''
end

--- Run :checktime, but only when it is safe to prompt or reload.
M.check = function()
  if not can_check() then
    return
  end
  pcall(vim.cmd, 'checktime')
end

--- Open a vertical diff between the buffer and its current content on disk.
M.diff = function(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  local path = vim.api.nvim_buf_get_name(buf)
  if path == '' or vim.fn.filereadable(path) == 0 then
    notify('no readable file on disk for this buffer', vim.log.levels.ERROR)
    return
  end

  local win = vim.fn.bufwinid(buf)
  if win == -1 then
    vim.api.nvim_set_current_buf(buf)
  else
    vim.api.nvim_set_current_win(win)
  end
  vim.cmd 'diffthis'

  vim.cmd 'vnew'
  local scratch = vim.api.nvim_get_current_buf()
  vim.bo[scratch].buftype = 'nofile'
  vim.bo[scratch].bufhidden = 'wipe'
  vim.bo[scratch].swapfile = false
  vim.api.nvim_buf_set_name(scratch, 'filewatch://disk/' .. path)
  vim.api.nvim_buf_set_lines(scratch, 0, -1, false, vim.fn.readfile(path))
  vim.bo[scratch].modifiable = false
  vim.bo[scratch].filetype = vim.bo[buf].filetype
  vim.cmd 'diffthis'

  vim.api.nvim_create_autocmd('BufWipeout', {
    buffer = scratch,
    once = true,
    callback = function()
      if not vim.api.nvim_buf_is_valid(buf) then
        return
      end
      local w = vim.fn.bufwinid(buf)
      if w ~= -1 then
        vim.api.nvim_win_call(w, function()
          vim.cmd 'diffoff'
        end)
      end
    end,
  })

  vim.cmd 'wincmd p'
  notify ':w keeps the buffer, :e! loads disk, close the disk window to leave diff'
end

--- Called from FileChangedShell when the buffer is modified and the file
--- changed on disk. Returns the value for v:fcs_choice.
M.resolve_conflict = function(buf)
  local choice = vim.fn.confirm(
    ('%s changed on disk and this buffer has unsaved changes.'):format(fname(buf)),
    '&Load from disk (discard buffer changes)\n&Keep buffer (:w will overwrite disk)\n&Diff buffer vs disk',
    2,
    'Warning'
  )
  if choice == 1 then
    return 'reload'
  end
  if choice == 3 then
    vim.schedule(function()
      M.diff(buf)
    end)
  end
  return ''
end

M.setup = function(opts)
  M.config = vim.tbl_extend('force', M.config, opts or {})
  vim.o.autoread = true

  vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'TermClose', 'TermLeave' }, {
    group = group,
    desc = 'filewatch: check for files changed on disk',
    callback = M.check,
  })

  vim.api.nvim_create_autocmd('FileChangedShell', {
    group = group,
    desc = 'filewatch: decide what to do with a file changed on disk',
    callback = function(ev)
      local reason = vim.v.fcs_reason
      if reason == 'deleted' then
        vim.v.fcs_choice = ''
        vim.b[ev.buf].filewatch_action = 'keep'
        notify(fname(ev.buf) .. ' was deleted on disk, keeping the buffer', vim.log.levels.WARN)
      elseif reason == 'conflict' then
        vim.v.fcs_choice = M.resolve_conflict(ev.buf)
        vim.b[ev.buf].filewatch_action = vim.v.fcs_choice == 'reload' and 'reload' or 'keep'
      else -- changed / time / mode on an unmodified buffer
        vim.v.fcs_choice = 'reload'
        vim.b[ev.buf].filewatch_action = 'reload'
      end
    end,
  })

  vim.api.nvim_create_autocmd('FileChangedShellPost', {
    group = group,
    desc = 'filewatch: report reloads',
    callback = function(ev)
      local action = vim.b[ev.buf].filewatch_action
      vim.b[ev.buf].filewatch_action = nil
      -- nil means nvim handled it through 'autoread' without asking us
      if action == nil or action == 'reload' then
        notify(fname(ev.buf) .. ' reloaded from disk')
      end
    end,
  })

  vim.api.nvim_create_autocmd('SwapExists', {
    group = group,
    desc = 'filewatch: warn loudly when the file is open in another nvim',
    callback = function(ev)
      -- nvim's default handler runs first and picks "edit anyway" when the
      -- swapfile belongs to a running nvim process
      if vim.v.swapchoice ~= 'e' then
        return
      end
      local info = vim.fn.swapinfo(vim.v.swapname)
      local dirty = info.dirty == 1 and ' with UNSAVED changes there' or ''
      notify(('%s is already open in nvim pid %d%s'):format(vim.fn.fnamemodify(ev.file, ':~:.'), info.pid, dirty), vim.log.levels.WARN)
    end,
  })

  vim.api.nvim_create_user_command('FileWatchCheck', M.check, { desc = 'Check all buffers against disk' })
  vim.api.nvim_create_user_command('FileWatchDiff', function()
    M.diff()
  end, { desc = 'Diff current buffer against its file on disk' })

  if timer then
    timer:stop()
    timer:close()
    timer = nil
  end
  if M.config.interval > 0 then
    timer = vim.uv.new_timer()
    timer:start(M.config.interval, M.config.interval, vim.schedule_wrap(M.check))
  end
end

return M
