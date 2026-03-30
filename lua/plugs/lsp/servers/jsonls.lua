return {
  settings = {
    json = {
      format = { enable = true },
      validate = { enable = true },
      schemaStore = { enable = false, url = '' },
      schemas = require('schemastore').json.schemas(),
    },
  },
}
