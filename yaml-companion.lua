return {
  'someone-stole-my-name/yaml-companion.nvim',
  event = 'BufEnter',
  ft = { 'yaml', 'yaml.docker-compose', 'yaml.ansible' },
  opts = function(opts)
    local yaml_cfg = require('yaml-companion').setup {
      lspconfig = {
        settings = {
          yaml = {
            -- schemas = require('schemastore').yaml.schemas(), -- optional, usually handled by yaml-companion
          },
        },
      },
    }
    -- require('lspconfig').yamlls.setup(yaml_cfg)
  end,
  keys = {
    {
      '<Space><Space>s',
      function()
        require('yaml-companion').open_ui_select()
      end,
      mode = 'n',
      ft = { 'yaml', 'yaml.docker-compose', 'yaml.ansible' },
      desc = '[Y]AML [S]chema',
    },
  },
}
