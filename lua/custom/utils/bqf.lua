return {
  'kevinhwang91/nvim-bqf',
  dependencies = {
    'junegunn/fzf',
  },
  ft = 'qf',
  config = function()
    require('bqf').setup {
      preview = {
        win_height = 999,
        win_vheight = 999,
      },
    }
  end,
}
