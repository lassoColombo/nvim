local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local lspconfig = require("lspconfig")

local servers = {
  "pyright",
  "sourcery",
  "jedi_language_server",
  "pylsp",
  "clangd",
  "golangci_lint_ls",
  "gopls",
  "html",
  "jdtls",
  "jsonls",
  "lemminx",
  "ltex",
  "omnisharp",
  "csharp_ls",
  "sqlls",
  "sqls",
  "sumneko_lua",
  "cssls",
  "cssmodules_ls"
}

lsp_installer.setup({
  ensure_installed = servers,
})

for _, server in pairs(servers) do
  -- if esiste un file di configurazione, then ...
  -- require 'lspconfig'.server.setup {}
  local opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }
  local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
  end
  lspconfig[server].setup(opts)
end


                                -- trying to configure malfunctioning LSPs
-- local root_dir = function()
-- return vim.fn.getcwd()
-- end

--
-- csharp-ls
-- require 'lspconfig'.csharp_ls.setup {
--   cmd = { "csharp-ls" },
--   filetypes = { "cs" },
--   init_options = { AutomaticWorkspaceInit = true },
--   root_dir = root_dir
-- }
