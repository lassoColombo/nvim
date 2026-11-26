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

-- diagnostics to quickfix
vim.keymap.set('n', '<leader>d', function()
  vim.fn.setqflist(vim.diagnostic.toqflist(vim.diagnostic.get(0)), 'r')
  vim.cmd.copen()
end, { desc = '[D]iagnostics (buffer)' })
vim.keymap.set('n', '<leader>D', vim.diagnostic.setqflist, { desc = '[D]iagnostics (workspace)' })

-- lsp
vim.keymap.set('n', '<leader>r', vim.lsp.buf.references, { desc = '[R]eferences' })
vim.keymap.set('n', '<leader>R', vim.lsp.buf.rename, { desc = '[R]ename' })
vim.keymap.set('n', '<leader>T', vim.lsp.buf.type_definition, { desc = '[T]ype definition' })
vim.keymap.set('n', '<leader>t', vim.lsp.buf.definition, { desc = 'Defini[t]ion' })
vim.keymap.set('n', '<leader>N', vim.lsp.buf.declaration, { desc = 'Declaratio[N]' })
vim.keymap.set('n', '<leader>i', vim.lsp.buf.implementation, { desc = '[I]mplementations' })
vim.keymap.set({ 'n', 'x' }, '<leader>a', vim.lsp.buf.code_action, { desc = 'Code [A]ction' })
vim.keymap.set('n', '<leader>s', vim.lsp.buf.document_symbol, { desc = '[S]ymbols (buffer)' })
vim.keymap.set('n', '<leader>S', vim.lsp.buf.workspace_symbol, { desc = '[S]ymbols (workspace)' })

-- copy paste from sys clip
vim.keymap.set({ 'n', 'v' }, '<C-p>', '"+p', { desc = '[P]aste from system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<C-y>', '"+y', { desc = '[Y]ank to system clipboard' })

-- toggle stuff on and off
local toggle = require 'toggle'

vim.keymap.set('n', '<leader><leader><leader>w', function()
  vim.wo.wrap = not vim.wo.wrap
  toggle('wrap', vim.wo.wrap)
end, { desc = '[T]oggle line [W]rap' })

vim.keymap.set('n', '<leader><leader><leader>n', function()
  vim.wo.relativenumber = not vim.wo.relativenumber
  toggle('relativenumber', vim.wo.relativenumber)
end, { desc = '[T]oggle relative line[N]umbers' })

vim.keymap.set('n', '<leader><leader><leader>N', function()
  vim.wo.relativenumber = false
  vim.wo.number = not vim.wo.number
  toggle('number', vim.wo.number)
end, { desc = '[T]oggle line[N]umbers' })

vim.keymap.set('n', '<leader><leader><leader>d', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  toggle('diagnostics', vim.diagnostic.is_enabled())
end, { desc = '[T]oggle [D]iagnostics' })

vim.keymap.set('n', '<leader><leader><leader>h', function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = 0 })
  toggle('inlay hints', vim.lsp.inlay_hint.is_enabled { bufnr = 0 })
end, { desc = '[T]oggle Inlay [H]ints' })

-- treesitter
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
vim.keymap.set('n', '<leader><leader>ni', '<cmd>InspectTree<CR>', { desc = '[T]treesitter [I]nspectTree' })
