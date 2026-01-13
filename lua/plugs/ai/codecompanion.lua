return {
  'olimorris/codecompanion.nvim',
  version = '^18.0.0',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    interactions = {
      chat = {
        adapter = 'copilot',
        opts = {
          completion_provider = 'cmp',
        },
      },
      inline = {
        adapter = 'copilot',
        opts = {
          completion_provider = 'cmp',
        },
      },
      cmd = {
        adapter = 'copilot',
        opts = {
          completion_provider = 'cmp',
        },
      },
      background = {
        adapter = 'copilot',
        opts = {
          completion_provider = 'cmp',
        },
      },
    },
  },
  keys = {
    {
      '<leader>ia',
      '<cmd>CodeCompanionActions<cr>',
      mode = { 'n', 'v' },
      desc = ']AI Actions',
    },
    {
      '<leader>ic',
      '<cmd>CodeCompanionChat Toggle<cr>',
      mode = { 'n', 'v' },
      desc = ']AI Chat',
    },
    {
      '<leader>iw',
      '<cmd>CodeCompanionChat Add<cr>',
      mode = { 'n', 'v' },
      desc = ']AI Add',
    },
  },
}
