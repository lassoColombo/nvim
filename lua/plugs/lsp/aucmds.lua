local M = {}

local highlight_augroup = vim.api.nvim_create_augroup('base-lsp-highlight', { clear = true })

vim.api.nvim_create_autocmd('LspDetach', {
  group = vim.api.nvim_create_augroup('base-lsp-detach', { clear = true }),
  callback = function(event)
    vim.lsp.buf.clear_references()
    vim.api.nvim_clear_autocmds { group = highlight_augroup, buffer = event.buf }
  end,
})

M.set = function(bufnr, client)
  if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, bufnr) then
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = bufnr,
      group = highlight_augroup,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      buffer = bufnr,
      group = highlight_augroup,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

return M
