return {
  settings = {
    json = {
      format = {
        enable = true,
      },
      validate = { enable = true },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
}
