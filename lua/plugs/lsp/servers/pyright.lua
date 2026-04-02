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
    disableOrganizeImports = true,
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
