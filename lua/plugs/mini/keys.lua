-- minifiles

local minifiles_toggle = function(...)
  if not MiniFiles.close() then
    MiniFiles.open(...)
  end
end

vim.keymap.set('n', '<leader>e', minifiles_toggle, { desc = '[E]xplorer' })

-- Yank in register full path of entry under cursor
local copypath = function(manipulation)
  local absolute = (MiniFiles.get_fs_entry() or {}).path
  if absolute == nil then
    return vim.notify 'Cursor is not on valid entry'
  end

  local path = manipulation and vim.fn.fnamemodify(absolute, manipulation) or absolute
  vim.fn.setreg('"', path) -- Neovim unnamed register
  vim.fn.setreg('*', path) -- System clipboard
  vim.notify('Copied: ' .. path)
end

local copyimport = function()
  local absolute = (MiniFiles.get_fs_entry() or {}).path
  if absolute == nil then
    return vim.notify 'Cursor is not on valid entry'
  end
  local relative = vim.fn.fnamemodify(absolute, ':.')
  local noext = vim.fn.fnamemodify(relative, ':r')
  local ext = vim.fn.fnamemodify(absolute, ':e')

  local i = ''
  if ext == 'lua' then
    local p = noext:gsub('^lua/', ''):gsub('/', '.')
    i = "require('" .. p .. "')"
  elseif ext == 'py' then
    local p = noext:gsub('/', '.')
    i = 'import ' .. p
  elseif ext == 'go' then
    i = noext:gsub('/', '.')
  else
    vim.notify('cannot generate import statement for ' .. relative, vim.log.levels.WARN)
    return
  end

  if i then
    vim.fn.setreg('*', i)
    vim.notify('Copied: ' .. i)
  end
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local b = args.data.buf_id

    local mappings = {
      { key = 'ya', mod = '', desc = 'Yank absolute path' },
      { key = 'yr', mod = ':.', desc = 'Yank path relative to cwd' },
      { key = 'yh', mod = ':h', desc = 'Yank head' },
      { key = 'yt', mod = ':t', desc = 'Yank tail' },
      { key = 'ye', mod = ':e', desc = 'Yank extension' },
      { key = 'yh', mod = ':~', desc = 'Yank path with ~ for home' },
    }

    for _, m in ipairs(mappings) do
      vim.keymap.set('n', m.key, function()
        copypath(m.mod)
      end, { buffer = b, desc = m.desc })
    end

    vim.keymap.set('n', 'yi', copyimport, { buffer = b, desc = 'Yank relative' })
  end,
})

-- jump2d
vim.keymap.set('n', 'f', function()
  MiniJump2d.start(MiniJump2d.builtin_opts.single_character)
end, { desc = '[J]ump char' })
vim.keymap.set('n', 'F', function()
  MiniJump2d.start(MiniJump2d.builtin_opts.line_start)
end, { desc = '[J]ump line' })

-- indentscope
vim.keymap.set('n', '<leader><leader><leader>S', function()
  local state = vim.b.miniindentscope_disable or false
  vim.b.miniindentscope_disable = not state
  local level = state and vim.log.levels.INFO or vim.log.levels.WARN
  vim.notify(('set indentscope to %s'):format(tostring(state)), level)
end, { desc = '[T]oggle indent[S]cope' })

-- sessions
vim.keymap.set('n', '<leader><leader>ss', function()
  local cwd = vim.fn.getcwd()
  local dotted = cwd:gsub('/', '.')
  require('mini.sessions').read(dotted)
end, { desc = '[S]ession [R]esume' })
vim.keymap.set('n', '<leader><leader>sd', function()
  local session_names = {}
  for name, _ in pairs(require('mini.sessions').detected) do
    table.insert(session_names, name)
  end
  vim.ui.select(session_names, { prompt = 'Delete session:' }, function(choice)
    if choice ~= nil then
      require('mini.sessions').delete(choice)
      vim.notify('Deleted session: ' .. choice, vim.log.levels.INFO)
    end
  end)
end, { desc = '[S]ession [D]elete' })
vim.keymap.set('n', '<leader><leader>sl', function()
  local session_names = {}
  for name, _ in pairs(require('mini.sessions').detected) do
    table.insert(session_names, name)
  end
  vim.notify(vim.inspect(session_names))
end, { desc = '[S]ession [L]ist' })
vim.keymap.set('n', '<leader><leader>si', function()
  local session_names = {}
  for name, _ in pairs(require('mini.sessions').detected) do
    table.insert(session_names, name)
  end
  vim.ui.select(session_names, { prompt = 'Inspect session:' }, function(choice)
    if choice ~= nil then
      vim.notify(vim.inspect(require('mini.sessions').detected[choice]))
    end
  end)
end, { desc = '[S]ession [I]nspect' })
vim.keymap.set('n', '<leader><leader>sn', function()
  local cwd = vim.fn.getcwd()
  local dotted = cwd:gsub('/', '.')
  require('mini.sessions').write(dotted)
end, { desc = '[S]ession [N]ew' })
