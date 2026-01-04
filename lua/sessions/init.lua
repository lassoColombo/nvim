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
  return nil
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
  local uv = vim.loop
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

M.delete = function()
  local sessions = M.list()
  if #sessions == 0 then
    vim.notify('No sessions detected.', vim.log.levels.INFO)
    return
  end
  vim.ui.select(sessions, { prompt = 'Delete Session' }, function(choice)
    if not choice then
      vim.notify('Session deletion cancelled', vim.log.levels.DEBUG)
      return
    end
    local session_path = vim.fs.joinpath(sessions_dir, choice)
    local ok, err = os.remove(session_path)
    if ok then
      vim.notify('Deleted session: ' .. choice, vim.log.levels.INFO)
    else
      vim.notify('Failed to delete session: ' .. (err or 'unknown error'), vim.log.levels.ERROR)
    end
  end)
end

return M
