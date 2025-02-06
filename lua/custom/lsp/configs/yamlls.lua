return {
  -- activate only for plain yaml files
  filetypes = { 'yaml' },
  event = 'BufEnter',

  -- lazy-load schemastore when needed
  on_new_config = function(new_config)
    new_config.settings.yaml.schemas = vim.tbl_deep_extend('force', new_config.settings.yaml.schemas or {}, require('schemastore').yaml.schemas())
  end,
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      validate = true,
      format = { enable = true },
      schemaStore = {
        enable = false,
        hover = true,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = '',
      },
      schemas = {
        -- :NOTE: schemas are loaded via yaml-companion
      },
    },
  },
}
