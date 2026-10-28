return {
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      validate = true,
      completion = true,
      hover = true,
      format = { enable = true },
      keyOrdering = false,
      schemaStore = {
        -- Disable built-in schemaStore support to use schemastore.nvim
        enable = false,
        url = '',
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
}
