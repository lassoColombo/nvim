vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = '[]Clear' })

-- Buffer
vim.keymap.set({ 'n' }, '<leader>w', function()
  vim.notify('written ' .. vim.api.nvim_buf_get_name(0))
  vim.cmd 'w'
end, { desc = '[W]rite buffer' })

-- Window
vim.keymap.set('n', '<C-right>', '<cmd>vertical resize +5<CR>', { desc = '[]Resize right' })
vim.keymap.set('n', '<C-left>', '<cmd>vertical resize -5<CR>', { desc = '[]Resize left' })
vim.keymap.set('n', '<C-up>', '<cmd>horizontal resize +3<CR>', { desc = '[]Resize up' })
vim.keymap.set('n', '<C-down>', '<cmd>horizontal resize -3<CR>', { desc = '[]Resize down' })

-- copy paste from sys clip
vim.keymap.set({ 'n', 'v' }, '<C-p>', '"+p', { desc = '[P]aste from system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<C-y>', '"+y', { desc = '[Y]ank to system clipboard' })

-- toggle stuff on and off
local function toggle(opt, scope, state)
  local scopes = { o = vim.o, wo = vim.wo, bo = vim.bo }
  local target = scopes[scope or 'o']
  state = state or not target[opt]
  target[opt] = state or not target[opt]
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
  if vim.diagnostic.is_enabled() then
    vim.diagnostic.enable(false)
  else
    vim.diagnostic.enable(true)
  end
  local is_enabled = vim.diagnostic.is_enabled()
  local log_level = (is_enabled and vim.log.levels.INFO or vim.log.levels.WARN)
  vim.notify('set diagnostics to ' .. tostring(is_enabled), log_level)
end, { desc = '[T]oggle [D]iagnostics' })

-- ts get node type
local function get_node_type()
  local ts_utils = require 'nvim-treesitter.ts_utils'
  local node = ts_utils.get_node_at_cursor()
  if not node then
    return '*'
  end
  return node:type()
end

vim.keymap.set('n', '<leader><leader>nt', function()
  vim.notify(get_node_type())
end, { desc = '[N]ode [T]ype' })
local a = { 'a', 'y' }
