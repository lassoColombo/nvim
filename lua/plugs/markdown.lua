return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    ft = 'markdown',
    opts = {
      completions = { lsp = { enabled = true } },
    },
    keys = {
      {
        '<leader><leader><leader>r',
        function()
          local render = require 'render-markdown'
          render.toggle()
          require 'toggle'('render markdown', render.get())
        end,
        mode = 'n',
        ft = { 'markdown' },
        desc = '[T]oggle [R]ender',
      },
    },
  },
  {
    'richardbizik/nvim-toc',
    ft = 'markdown',
    opts = {},
    keys = {
      {
        '<leader><leader>T',
        '<cmd>TOCList<cr>',
        mode = 'n',
        ft = { 'markdown' },
        desc = 'Generate [T]OC',
      },
    },
  },
  {
    'brianhuster/live-preview.nvim',
    ft = 'markdown',
    keys = {
      {
        '<leader><leader>p',
        function()
          vim.cmd.LivePreview(require('livepreview').is_running() and 'close' or 'start')
        end,
        mode = 'n',
        ft = { 'markdown' },
        desc = 'Toggle browser [P]review',
      },
    },
  },
}
