return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.git').setup()
    require('mini.files').setup(require 'plugs.mini.files')
    require('mini.ai').setup(require 'plugs.mini.around-inside')
    require('mini.hipatterns').setup(require 'plugs.mini.hipatterns')
    require('mini.surround').setup(require 'plugs.mini.surround')
    require('mini.align').setup(require 'plugs.mini.align')
    require('mini.sessions').setup(require 'plugs.mini.sessions')
    require('mini.pairs').setup(require 'plugs.mini.pairs')
    require('mini.indentscope').setup(require 'plugs.mini.indentscope')
    require('mini.extra').setup()
    require('mini.jump2d').setup()
    require('mini.icons').setup()

    require 'plugs.mini.statusline'
    require 'plugs.mini.keys'
    require 'plugs.mini.aucmd'
  end,
}
