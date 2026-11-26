vim.opt_local.foldmethod = 'indent'
vim.opt_local.foldlevel = 2

-- kubectl on the buffer (normal mode) or the selection (visual mode)
for key, method in pairs { a = 'apply', d = 'delete', r = 'replace' } do
  vim.keymap.set({ 'n', 'x' }, '<leader><leader>k' .. key, function()
    require('kubectl')[method]()
  end, { buffer = true, desc = ('[K]ubectl [%s]%s'):format(key:upper(), method:sub(2)) })
end
