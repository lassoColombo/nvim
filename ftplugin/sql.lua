require('which-key').add {
  {
    { '<Space>S', group = '[L]SP [S]chema/[D]atabase' },
    { '<Space>S_', hidden = true },
  },
}

require 'custom.treesitter.textobjects.sql'
