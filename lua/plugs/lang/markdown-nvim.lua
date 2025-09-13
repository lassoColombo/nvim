return {
  'MeanderingProgrammer/markdown.nvim',
  name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  ft = { 'markdown', 'codecompanion' },
  config = function()
    require('render-markdown').setup {}
  end,
  keys = {
    {
      '<tab><tab>r',
      '<cmd>RenderMarkdown toggle<cr>',
      mode = 'n',
      ft = { 'markdown' },
      desc = '[T]oggle [R]ender',
    },
  },
}
