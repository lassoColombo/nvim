local M = {}

M.map = function(bufnr, client)
  -- lsp builtins
  -- diagnostics to quickfix
  vim.keymap.set('n', '<leader>d', function()
    local diagnostics = vim.diagnostic.get(0)
    local qlist = vim.diagnostic.toqflist(diagnostics)
    vim.fn.setqflist(qlist, 'r')
    vim.cmd 'copen'
  end, { buffer = bufnr, desc = '[D]iagnostics (buffer)' })

  vim.keymap.set('n', '<leader>D', function()
    local diagnostics = vim.diagnostic.get()
    local qlist = vim.diagnostic.toqflist(diagnostics)
    vim.fn.setqflist(qlist, 'r')
    vim.cmd 'copen'
  end, { buffer = bufnr, desc = '[D]iagnostics (workspace)' })

  vim.keymap.set('n', '<leader>r', vim.lsp.buf.references, { buffer = bufnr, desc = '[R]eferences' })
  vim.keymap.set('n', '<leader>R', vim.lsp.buf.rename, { buffer = bufnr, desc = 'Re[n]ame' })
  vim.keymap.set('n', '<leader>T', vim.lsp.buf.type_definition, { buffer = bufnr, desc = '[G]oto Type [D]efinitions' })
  vim.keymap.set('n', '<leader>t', vim.lsp.buf.definition, { buffer = bufnr, desc = '[G]oto [D]eclarations' })
  vim.keymap.set('n', '<leader>N', vim.lsp.buf.declaration, { buffer = bufnr, desc = '[G]oto [D]eclarations' })
  vim.keymap.set('n', '<leader>i', vim.lsp.buf.implementation, { buffer = bufnr, desc = '[G]oto [I]mplementations' })
  vim.keymap.set({ 'n', 'x' }, '<leader>a', vim.lsp.buf.code_action, { buffer = bufnr, desc = '[C]ode [A]ction' })
  vim.keymap.set('n', '<leader>s', vim.lsp.buf.document_symbol, { buffer = bufnr, desc = '[S]ymbols (buffer)' })
  vim.keymap.set('n', '<leader>S', vim.lsp.buf.workspace_symbol, { buffer = bufnr, desc = '[S]ymbols (workspace)' })

  if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, bufnr) then
    vim.keymap.set('n', '<tab><tab>h', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
    end, { buffer = bufnr, desc = '[T]oggle Inlay [H]ints' })
  end
end

return M
