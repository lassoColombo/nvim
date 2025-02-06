-- lsp go to definition
vim.keymap.set({ 'n' }, '<C-g>', vim.lsp.buf.declaration, { desc = '[G]oto [D]eclaration' })
vim.keymap.set({ 'n' }, '<C-G>', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition' })
vim.keymap.set({ 'n' }, '<space>t', vim.lsp.buf.declaration, { desc = '[L]SP [D]eclaration' })
vim.keymap.set({ 'n' }, '<space>T', vim.lsp.buf.definition, { desc = '[L]SP [D]efinition' })
-- lsp rename
vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, { desc = '[L]SP [R]ename' })
-- lsp code actions
vim.keymap.set('n', '<Space>a', vim.lsp.buf.code_action, { desc = '[L]SP [A]ctions' })
-- lsp hover
vim.keymap.set('n', '<Space>h', vim.lsp.buf.hover, { desc = '[L]SP [H]hover' })
-- lsp references to quickfix
vim.keymap.set('n', '<space>f', vim.lsp.buf.references, { desc = '[L]SP []References' })
-- lsp implementations to quickfix
vim.keymap.set('n', '<space>i', vim.lsp.buf.implementation, { desc = '[L]SP [I]mplementations' })
-- stylua: ignore start
-- lsp diagnostics
vim.keymap.set('n', '<Space>v', function() vim.diagnostic.open_float { source = true } end, { desc = '[V]iew line diagnostics' })
vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev { float = { source = true } } end, { desc = '[Prev [D]iagnostic message' })
vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next { float = { source = true } } end, { desc = ']Next [D]iagnostic message' })
-- stylua: ignore end
-- lsp diagnostics to quickfix
vim.keymap.set('n', '<space>D', vim.diagnostic.setqflist, { desc = '[L]SP workspace [D]iagnostics' })
vim.keymap.set('n', '<space>d', function()
  local bufnr = vim.api.nvim_get_current_buf()
  local diagnostics = vim.diagnostic.get(bufnr)
  vim.fn.setqflist({}, ' ', {
    title = 'Diagnostics for Current Buffer',
    items = vim.diagnostic.toqflist(diagnostics),
  })
  vim.cmd 'copen'
end, { desc = '[L]SP buffer [D]iagnostics' })
-- lsp calls
vim.keymap.set('n', '<Space>c', vim.lsp.buf.incoming_calls, { desc = '[L]SP [C]alls [I]n' })
vim.keymap.set('n', '<Space>C', vim.lsp.buf.outgoing_calls, { desc = '[L]SP [C]alls [O]ut' })
-- symbols
vim.keymap.set('n', '<Space>s', vim.lsp.buf.document_symbol, { desc = '[L]SP [S]ymbols [D]ocument' })
vim.keymap.set('n', '<Space>S', vim.lsp.buf.workspace_symbol, { desc = '[L]SP [S]ymbols [W]orkspace' })
-- restart
vim.keymap.set('n', '<Space>R', '<cmd>LspRestart<CR>', { desc = '[L]SP [R]estart' })
vim.keymap.set('n', '<Space>I', '<cmd>LspInfo<CR>', { desc = '[L]SP [I]info' })
