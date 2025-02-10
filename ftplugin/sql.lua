local function switch_connection()
  local lsp_client = vim.lsp.get_clients(--[[ { name = 'sql-language-server' } ]])
  Wbuf(lsp_client)
  -- if not lsp_client then
  --   print 'SQLs language server is not active'
  --   return
  -- end
  --
  -- -- Get the current buffer's URI
  -- local uri = vim.uri_from_bufnr(0)
  --
  -- -- Define the command and arguments
  -- local params = {
  --   command = 'fixAllFixableProblems',
  --   arguments = { uri },
  -- }
  --
  -- -- Send the request to the language server
  -- vim.lsp.buf.execute_command(params)
end

require 'custom.treesitter.textobjects.sql'

local lsp_client = vim.lsp.get_clients { name = 'sql-language-server' }
if not vim.tbl_isempty(lsp_client) then
  return
end
lsp_client = lsp_client[1]

local function on_attach(client, bufnr)
  vim.keymap.set({ 'n' }, '<space><space>c', switch_connection, { desc = '[S]witch [C]onnection' })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = vim.tbl_deep_extend('force', lsp_client.capabilities, capabilities)
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

local cmd = { vim.fn.expand '~/.local/share/nvim/mason/bin/sql-language-server', 'up', '--method', 'stdio' }
local root_dir = vim.fn.getcwd()

local function filter_diagnostics(diagnostics)
  local filtered = {}
  local whitelisted = { 'Where clauses must align to the first clause', 'Columns must align to the first column' }
  for _, diagnostic in ipairs(diagnostics) do
    local is_whitelisted = false
    for _, message in ipairs(whitelisted) do
      if diagnostic.message:find(message) then
        is_whitelisted = true
        break
      end
    end
    if not is_whitelisted then
      table.insert(filtered, diagnostic)
    end
  end
  return filtered
end

local config = {
  name = 'sql-language-server',
  cmd = cmd,
  root_dir = root_dir,
  capabilities = capabilities,
  on_attach = on_attach,
  handlers = {
    ['textDocument/publishDiagnostics'] = function(_, result, ctx, config)
      result.diagnostics = filter_diagnostics(result.diagnostics)
      vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
    end,
  },
}

local id, err = vim.lsp.start_client(config)
if not id then
  vim.notify('cannot start sql-language-server: ' .. err, vim.log.levels.ERROR)
  return
end

vim.lsp.buf_attach_client(0, id)
