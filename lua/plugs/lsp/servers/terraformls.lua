return {
  init_options = {
    experimentalFeatures = {
      -- run `terraform validate` on save and surface diagnostics
      validateOnSave = true,
      -- autofill required arguments when completing a resource/data block
      prefillRequiredFields = true,
    },
  },
}
