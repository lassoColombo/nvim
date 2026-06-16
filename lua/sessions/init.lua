local M = {}

local sessions_dir = vim.fn.stdpath 'data' .. '/sessions'

local function ensure_sessions_dir()
  if vim.fn.isdirectory(sessions_dir) == 0 then
    vim.fn.mkdir(sessions_dir, 'p')
  end
end

local function generate_session_path(path)
  local name = path:gsub('[/\\:]', '%%') .. '.vim'
  return vim.fs.joinpath(sessions_dir, name)
end

M.setup = function()
  ensure_sessions_dir()
  vim.api.nvim_create_autocmd('VimLeavePre', {
    callback = function()
      M.write { silent = true }
    end,
  })
end

M.resume = function()
  local session_path = generate_session_path(vim.fn.getcwd())
  if vim.fn.filereadable(session_path) == 1 then
    vim.cmd('silent! source ' .. vim.fn.fnameescape(session_path))
  end
end

M.detected = function()
  local session_path = generate_session_path(vim.fn.getcwd())
  if vim.fn.filereadable(session_path) == 1 then
    return session_path
  end
end

M.write = function(opts)
  opts = opts or {}
  local session_path = generate_session_path(vim.fn.getcwd())
  vim.cmd('mksession! ' .. vim.fn.fnameescape(session_path))
  if not opts.silent then
    vim.notify('Written session: ' .. session_path, vim.log.levels.INFO)
  end
end

M.list = function()
  local uv = vim.uv
  local files = {}
  local handle = uv.fs_scandir(sessions_dir)

  if handle then
    while true do
      local name, t = uv.fs_scandir_next(handle)
      if not name then
        break
      end
      if t == 'file' then
        table.insert(files, name)
      end
    end
  end
  return files
end

M.manage = function()
  local sessions = M.list()
  local buf = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_buf_set_name(buf, 'sessions://manage')
  vim.bo[buf].buftype = 'acwrite'
  vim.bo[buf].bufhidden = 'wipe'
  vim.bo[buf].swapfile = false
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, sessions)
  vim.bo[buf].modified = false

  local width = math.min(100, math.floor(vim.o.columns * 0.7))
  local height = math.min(math.max(#sessions + 2, 8), math.floor(vim.o.lines * 0.7))
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = 'minimal',
    border = 'rounded',
    title = ' Sessions ',
    title_pos = 'center',
  })
  vim.wo[win].number = true
  vim.wo[win].cursorline = true

  vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = buf, nowait = true, silent = true })

  vim.api.nvim_create_autocmd('BufWriteCmd', {
    buffer = buf,
    callback = function()
      local on_disk = {}
      for _, name in ipairs(M.list()) do
        on_disk[name] = true
      end
      local kept = {}
      for _, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
        line = vim.trim(line)
        if line ~= '' then
          kept[line] = true
        end
      end
      local deleted = 0
      for name in pairs(on_disk) do
        if not kept[name] then
          local ok, err = os.remove(vim.fs.joinpath(sessions_dir, name))
          if ok then
            deleted = deleted + 1
          else
            vim.notify('Failed to delete ' .. name .. ': ' .. (err or '?'), vim.log.levels.ERROR)
          end
        end
      end
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, M.list())
      vim.bo[buf].modified = false
      vim.notify('deleted ' .. deleted .. ' sessions', vim.log.levels.INFO)
    end,
  })
end

return M
