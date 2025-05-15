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
      ignore = { '*' },
      -- analysis = {
      --   autoSearchPaths = true,
      --   diagnosticMode = 'off',
      --   typeCheckingMode = 'basic',
      --   useLibraryCodeForTypes = true,
      --   diagnosticSeverityOverrides = {},
      -- },
    },
  },
}
