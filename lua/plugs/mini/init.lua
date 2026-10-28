return {
  'nvim-mini/mini.nvim',
  config = function()
    require('mini.git').setup()
    require('mini.diff').setup(require 'plugs.mini.diff')
    require('mini.files').setup()
    require('mini.ai').setup(require 'plugs.mini.around-inside')
    require('mini.hipatterns').setup(require 'plugs.mini.hipatterns')
    require('mini.surround').setup(require 'plugs.mini.surround')
    require('mini.pairs').setup()
    require('mini.indentscope').setup(require 'plugs.mini.indentscope')
    require('mini.icons').setup()

    require 'plugs.mini.statusline'
    require 'plugs.mini.keys'
    require 'plugs.mini.aucmd'
  end,
}
