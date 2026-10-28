return {
  capabilities = {
    textDocument = {
      publishDiagnostics = {
        tagSupport = {
          valueSet = { 2 },
        },
      },
    },
  },
  settings = {
    pyright = {
      disableOrganizeImports = true, -- ruff owns it
    },
    python = {
      analysis = {
        typeCheckingMode = 'basic',
        diagnosticMode = 'workspace',
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
}
