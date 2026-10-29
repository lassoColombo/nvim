vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = '[]Clear' })

-- Buffer
vim.keymap.set('n', '<leader>w', '<cmd>update<CR>', { desc = '[W]rite buffer' })

-- Window
vim.keymap.set('n', '<C-right>', '<cmd>vertical resize +5<CR>', { desc = '[]Resize right' })
vim.keymap.set('n', '<C-left>', '<cmd>vertical resize -5<CR>', { desc = '[]Resize left' })
vim.keymap.set('n', '<C-up>', '<cmd>horizontal resize +3<CR>', { desc = '[]Resize up' })
vim.keymap.set('n', '<C-down>', '<cmd>horizontal resize -3<CR>', { desc = '[]Resize down' })

-- lists
vim.keymap.set('n', '<leader>q', '<cmd>copen<CR>', { desc = 'Open [Q]uickfix' })

-- diff mode: jump between changes. gitsigns overrides these per buffer with
-- hunk navigation; this is the fallback for buffers it is not attached to.
vim.keymap.set('n', ']h', ']c', { desc = 'Jump to next diff change' })
vim.keymap.set('n', '[h', '[c', { desc = 'Jump to previous diff change' })

-- copy paste from sys clip
vim.keymap.set({ 'n', 'v' }, '<C-p>', '"+p', { desc = '[P]aste from system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<C-y>', '"+y', { desc = '[Y]ank to system clipboard' })

-- toggle stuff on and off
local function toggle(opt, scope, state)
  local scopes = { o = vim.o, wo = vim.wo, bo = vim.bo }
  local target = scopes[scope or 'o']
  if state == nil then
    state = not target[opt]
  end
  target[opt] = state
  local level = state and vim.log.levels.INFO or vim.log.levels.WARN
  vim.notify(('set %s to %s'):format(opt, tostring(state)), level)
end

-- toggle wrap
vim.keymap.set('n', '<leader><leader><leader>w', function()
  toggle('wrap', 'wo')
end, { desc = '[T]oggle line [W]rap' })

-- toggle relative line numbers
vim.keymap.set('n', '<leader><leader><leader>n', function()
  toggle('relativenumber', 'wo')
end, { desc = '[T]oggle relative line[N]umbers' })

-- toggle line numbers
vim.keymap.set('n', '<leader><leader><leader>N', function()
  toggle('relativenumber', 'wo', false)
  toggle('number', 'wo')
end, { desc = '[T]oggle line[N]umbers' })

-- toggle diagnostics
vim.keymap.set('n', '<leader><leader><leader>d', function()
  local enabled = not vim.diagnostic.is_enabled()
  vim.diagnostic.enable(enabled)
  vim.notify('set diagnostics to ' .. tostring(enabled), enabled and vim.log.levels.INFO or vim.log.levels.WARN)
end, { desc = '[T]oggle [D]iagnostics' })

-- ts get node type
local function get_node_type()
  local node = vim.treesitter.get_node()
  if not node then
    return '*'
  end
  return node:type()
end

vim.keymap.set('n', '<leader><leader>nt', function()
  vim.notify(get_node_type())
end, { desc = '[N]ode [T]ype' })
