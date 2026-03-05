return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  ft = { 'markdown', 'codecompanion' },
  opts = {
    completions = { lsp = { enabled = true } },
  },
  keys = {
    {
      '<leader><leader><leader>r',
      '<cmd>RenderMarkdown toggle<cr>',
      mode = 'n',
      ft = { 'markdown' },
      desc = '[T]oggle [R]ender',
    },
  },
}
