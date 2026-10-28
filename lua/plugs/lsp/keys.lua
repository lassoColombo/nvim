local M = {}

M.map = function(bufnr, client)
  -- lsp builtins
  -- diagnostics to quickfix
  vim.keymap.set('n', '<leader>d', function()
    vim.fn.setqflist(vim.diagnostic.toqflist(vim.diagnostic.get(0)), 'r')
    vim.cmd.copen()
  end, { buffer = bufnr, desc = '[D]iagnostics (buffer)' })

  vim.keymap.set('n', '<leader>D', vim.diagnostic.setqflist, { buffer = bufnr, desc = '[D]iagnostics (workspace)' })

  vim.keymap.set('n', '<leader>r', vim.lsp.buf.references, { buffer = bufnr, desc = '[R]eferences' })
  vim.keymap.set('n', '<leader>R', vim.lsp.buf.rename, { buffer = bufnr, desc = '[R]ename' })
  vim.keymap.set('n', '<leader>T', vim.lsp.buf.type_definition, { buffer = bufnr, desc = '[T]ype definition' })
  vim.keymap.set('n', '<leader>t', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Defini[t]ion' })
  vim.keymap.set('n', '<leader>N', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'Declaratio[N]' })
  vim.keymap.set('n', '<leader>i', vim.lsp.buf.implementation, { buffer = bufnr, desc = '[I]mplementations' })
  vim.keymap.set({ 'n', 'x' }, '<leader>a', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code [A]ction' })
  vim.keymap.set('n', '<leader>s', vim.lsp.buf.document_symbol, { buffer = bufnr, desc = '[S]ymbols (buffer)' })
  vim.keymap.set('n', '<leader>S', vim.lsp.buf.workspace_symbol, { buffer = bufnr, desc = '[S]ymbols (workspace)' })

  if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, bufnr) then
    vim.keymap.set('n', '<leader><leader><leader>h', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
    end, { buffer = bufnr, desc = '[T]oggle Inlay [H]ints' })
  end
end

return M
