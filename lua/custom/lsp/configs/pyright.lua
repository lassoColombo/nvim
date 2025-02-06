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
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = 'off',
        typeCheckingMode = 'basic',
        useLibraryCodeForTypes = true,
        diagnosticSeverityOverrides = {},
      },
    },
  },
}
