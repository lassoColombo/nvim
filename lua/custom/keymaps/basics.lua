vim.keymap.set({ 'n', 'v' }, '<Esc>', function()
  vim.cmd 'nohlsearch'
end, { desc = '[]dismiss hilight and notifications' })

-- copy paste from sys clip
vim.keymap.set({ 'n', 'v' }, '<C-p>', '"+p', { desc = '[P]aste from system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<C-y>', '"+y', { desc = '[Y]ank to system clipboard' })

-- Tab
vim.keymap.set({ 'n', 'i' }, ']t', 'gt', { desc = ']Next Tab' })
vim.keymap.set({ 'n', 'i' }, '[t', 'gT', { desc = '[Prev Tab' })
-- Window
vim.keymap.set('n', '<C-right>', '<cmd>vertical resize +5<CR>', { desc = '[]Resize right' })
vim.keymap.set('n', '<C-left>', '<cmd>vertical resize -5<CR>', { desc = '[]Resize left' })
vim.keymap.set('n', '<C-up>', '<cmd>horizontal resize +3<CR>', { desc = '[]Resize up' })
vim.keymap.set('n', '<C-down>', '<cmd>horizontal resize -3<CR>', { desc = '[]Resize down' })
-- Buffer
vim.keymap.set({ 'n', 'i' }, '<leader>w', '<cmd>w<cr><esc>', { desc = '[S]ave buffer' })
vim.keymap.set({ 'n', 'i' }, '<leader>W', '<cmd>wa<cr><esc>', { desc = '[S]ave all buffers' })
