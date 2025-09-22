vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = '[]Clear' })
vim.keymap.set('n', '<leader>q', '<cmd>copen<cr>', { desc = '[Q]open' })
vim.keymap.set('n', '<leader>l', '<cmd>lopen<cr>', { desc = '[L]open' })

-- Buffer
vim.keymap.set({ 'n' }, '<tab>w', '<cmd>w<cr><esc>', { desc = '[W]rite buffer' })
vim.keymap.set({ 'n' }, '<tab>W', '<cmd>wa<cr><esc>', { desc = '[W]rite all buffers' })
vim.keymap.set({ 'n' }, '<tab>dd', '<cmd>bd<cr><esc>', { desc = '[D]elete buffer' })
vim.keymap.set('n', '<tab>qq', '<cmd>qa<cr>', { desc = '[Q]uit' })

-- NOTE: does not work in terminal emulators
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window
vim.keymap.set('n', '<C-right>', '<cmd>vertical resize +5<CR>', { desc = '[]Resize right' })
vim.keymap.set('n', '<C-left>', '<cmd>vertical resize -5<CR>', { desc = '[]Resize left' })
vim.keymap.set('n', '<C-up>', '<cmd>horizontal resize +3<CR>', { desc = '[]Resize up' })
vim.keymap.set('n', '<C-down>', '<cmd>horizontal resize -3<CR>', { desc = '[]Resize down' })
-- buffer

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
vim.keymap.set('n', '<tab><tab>w', function()
  toggle('wrap', 'wo')
end, { desc = '[T]oggle line [W]rap' })

-- toggle relative line numbers
vim.keymap.set('n', '<tab><tab>n', function()
  toggle('relativenumber', 'wo')
end, { desc = '[T]oggle relative line[N]umbers' })

-- toggle line numbers
vim.keymap.set('n', '<tab><tab>N', function()
  toggle('relativenumber', 'wo', false)
  toggle('number', 'wo')
end, { desc = '[T]oggle line[N]umbers' })

-- toggle diagnostics
vim.keymap.set('n', '<tab><tab>d', function()
  if vim.diagnostic.is_enabled() then
    vim.diagnostic.enable(false)
  else
    vim.diagnostic.enable(true)
  end
  local is_enabled = vim.diagnostic.is_enabled()
  local log_level = (is_enabled and vim.log.levels.INFO or vim.log.levels.WARN)
  vim.notify('set diagnostics to ' .. tostring(is_enabled), log_level)
end, { desc = '[T]oggle [D]iagnostics' })

local function get_node_type()
  local ts_utils = require 'nvim-treesitter.ts_utils'
  local node = ts_utils.get_node_at_cursor()
  if not node then
    return '*'
  end
  return node:type()
  -- vim.notify(node:type())
end

vim.keymap.set('n', '<leader><leader>nt', function()
  vim.notify(get_node_type())
end, { desc = '[N]ode [T]ype' })
local a = { 'a', 'y' }
