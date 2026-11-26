-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Close read-only helper windows with q',
  group = vim.api.nvim_create_augroup('q-quits', { clear = true }),
  pattern = { 'checkhealth', 'git', 'gitsigns-blame', 'help', 'qf', 'sqls_output' },
  callback = function(event)
    vim.keymap.set('n', 'q', '<cmd>q<CR>', { desc = 'quit', buffer = event.buf })
  end,
})

-- Highlight the symbol under the cursor while an attached client can provide it
local lsp_highlight = vim.api.nvim_create_augroup('lsp-highlight', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP: highlight references of the symbol under the cursor',
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not (client and client:supports_method('textDocument/documentHighlight', event.buf)) then
      return
    end
    -- a second capable client on the buffer must not stack another pair
    vim.api.nvim_clear_autocmds { group = lsp_highlight, buffer = event.buf }
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      group = lsp_highlight,
      buffer = event.buf,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      group = lsp_highlight,
      buffer = event.buf,
      callback = vim.lsp.buf.clear_references,
    })
  end,
})

vim.api.nvim_create_autocmd('LspDetach', {
  desc = 'LSP: stop highlighting when no attached client can',
  group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
  callback = function(event)
    for _, client in ipairs(vim.lsp.get_clients { bufnr = event.buf }) do
      if client.id ~= event.data.client_id and client:supports_method('textDocument/documentHighlight', event.buf) then
        return
      end
    end
    vim.lsp.util.buf_clear_references(event.buf)
    vim.api.nvim_clear_autocmds { group = lsp_highlight, buffer = event.buf }
  end,
})
