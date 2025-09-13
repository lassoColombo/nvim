return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = true,
  opts = {
    display = {
      action_palette = {
        width = 95,
        height = 10,
        prompt = 'Prompt ', -- Prompt used for interactive LLM calls
        provider = 'telescope', -- default|telescope|mini_pick
        opts = {
          show_default_actions = true, -- Show the default actions in the action palette?
          show_default_prompt_library = true, -- Show the default prompt library in the action palette?
        },
      },
    },
    strategies = {
      -- Change the default chat adapter
      chat = {
        adapter = 'copilot',
        slash_commands = {
          ['file'] = {
            callback = 'strategies.chat.slash_commands.file',
            description = 'share a file',
            opts = {
              provider = 'telescope',
              contains_code = true,
            },
          },
          ['buffer'] = {
            callback = 'strategies.chat.slash_commands.file',
            description = 'share a buffer',
            opts = {
              provider = 'telescope',
              contains_code = true,
            },
          },
          ['symbols'] = {
            callback = 'strategies.chat.slash_commands.file',
            description = 'share LSP symbols',
            opts = {
              provider = 'telescope',
              contains_code = true,
            },
          },
        },
      },
      inline = {
        adapter = 'copilot',
      },
    },
    opts = {
      log_level = 'DEBUG',
    },
  },
  keys = {
    {
      '<tab>ia',
      ':CodeCompanion /buffer',
      mode = { 'n', 'v' },
      desc = ']AI Inline',
    },
    {
      '<tab>ic',
      '<cmd>CodeCompanionChat<cr>',
      mode = { 'n', 'v' },
      desc = ']AI Chat',
    },
  },
}
