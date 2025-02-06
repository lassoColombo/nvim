return {
  'someone-stole-my-name/yaml-companion.nvim',
  event = 'BufEnter',
  ft = { 'yaml', 'yaml.docker-compose', 'yaml.ansible' },
  config = function()
    local cfg = require('yaml-companion').setup {
      -- detect k8s schemas based on file content
      builtin_matchers = {
        kubernetes = { enabled = true },
      },
      -- schemas available in Telescope picker
      schemas = {
        {
          name = 'Argo CD Application',
          uri = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json',
        },
        {
          name = 'Gitlab CI',
          uri = 'https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json',
        },
        {
          name = 'Docker Compose',
          uri = 'https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json',
        },
      },
    }
    require('telescope').load_extension 'yaml_schema'
    require('lspconfig')['yamlls'].setup(cfg)
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
  opts = {
    config = function()
      require('telescope').load_extension 'yaml_schema'
    end,
  },
}
