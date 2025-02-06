return {
  'edolphin-ydf/goimpl.nvim',
  ft = { 'go' },
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-lua/popup.nvim' },
    { 'nvim-telescope/telescope.nvim' },
    { 'nvim-treesitter/nvim-treesitter' },
  },
  config = function()
    require('telescope').load_extension 'goimpl'
  end,
  keys = {
    {
      '<Space><Space>I',
      function()
        require('telescope').extensions.goimpl.goimpl {}
      end,
      mode = 'n',
      desc = '[I]mplement [I]interface',
      ft = { 'go' },
    },
  },
}
