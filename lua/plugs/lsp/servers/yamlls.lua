-- return {
--   -- activate only for plain yaml files
--   filetypes = { 'yaml' },
--   event = 'BufEnter',
--
--   -- lazy-load schemastore when needed
--   on_new_config = function(new_config)
--     new_config.settings.yaml.schemas = vim.tbl_deep_extend(
--       'force',
--       new_config.settings.yaml.schemas or {},
--       require('yaml-companion').setup {
--         lspconfig = {
--           settings = {
--             yaml = {
--               schemas = {
--                 {
--                   name = 'Argo CD Application',
--                   uri = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json',
--                 },
--                 {
--                   name = 'Gitlab CI',
--                   uri = 'https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json',
--                 },
--                 {
--                   name = 'Docker Compose',
--                   uri = 'https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json',
--                 },
--               },
--             },
--           },
--         },
--       }
--     )
--   end,
--
--   settings = {
--     redhat = { telemetry = { enabled = false } },
--     yaml = {
--       validate = true,
--       format = { enable = true },
--       schemaStore = {
--         enable = false,
--         hover = true,
--         -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
--         url = '',
--       },
--
--       schemas = {
--         {
--           name = 'Argo CD Application',
--           uri = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json',
--         },
--         {
--           name = 'Gitlab CI',
--           uri = 'https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json',
--         },
--         {
--           name = 'Docker Compose',
--           uri = 'https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json',
--         },
--       },
--
--       -- schemas = {
--       --
--       --   -- :NOTE: schemas are loaded via yaml-companion
--       -- },
--     },
--   },
-- }

return {
  settings = {
    yaml = {
      schemaStore = {
        -- You must disable built-in schemaStore support if you want to use
        -- this plugin and its advanced options like `ignore`.
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = '',
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
}
