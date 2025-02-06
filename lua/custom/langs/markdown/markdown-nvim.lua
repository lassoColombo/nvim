return {
  'MeanderingProgrammer/markdown.nvim',
  name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  ft = { 'markdown', 'codecompanion' },
  config = function()
    require('render-markdown').setup {}
  end,
  keys = {
    {
      '<leader><leader>r',
      '<cmd>RenderMarkdown toggle<cr>',
      mode = 'n',
      ft = { 'markdown' },
      desc = '[T]oggle [R]ender',
    },
  },
}
