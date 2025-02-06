return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  config = function()
    require('which-key').setup {
      icons = {
        mappings = false,
      },
    }

    require('which-key').add {
      {
        { '<leader><leader>', group = '[T]oggle' },
        { '<leader>q', group = '[Q]uit' },
        { '<leader><leader>_', hidden = true },
        { '<leader>r', group = '[R]egisters' },
        { '<leader>r_', hidden = true },
        { '<Space><Space>', group = '[L]SP specific' },
        { '<Space><Space>_', hidden = true },
        { ']', group = '[]Next' },
        { ']_', hidden = true },
        { '[', group = '[]Prev' },
        { '[_', hidden = true },
        { '\\', group = '\\S]earch' },
        { '\\_', hidden = true },
        {
          mode = { 'n', 'v' },
          { '<leader>f', group = '[F]ormat' },
          { '<leader>f_', hidden = true },
        },
      },
    }
  end,
}
