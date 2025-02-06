return {
  -- integrations with git
  -- See `:help gitsigns` to understand what the configuration keys do
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  event = 'BufEnter',
  opts = function()
    return {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '-' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    }
  end,
  keys = {
    {
      'gs',
      '<cmd>Gitsigns stage_hunk<cr>',
      mode = 'n',
      desc = '[G]it [S]tage hunk',
    },
    {
      'gS',
      '<cmd>Gitsigns stage_buffer<cr>',
      mode = 'n',
      desc = '[G]it [S]tage hunk',
    },
    {
      'gr',
      '<cmd>Gitsigns undo_stage_hunk<cr>',
      mode = 'n',
      desc = '[G]it Unstage hunk',
    },
    {
      'gx',
      '<cmd>Gitsigns reset_hunk<cr>',
      mode = 'n',
      desc = '[G]it [R]eset hunk',
    },
    {
      'gX',
      '<cmd>Gitsigns reset_buffer<cr>',
      mode = 'n',
      desc = '[G]it [R]eset buffer',
    },
    {
      ']g',
      '<cmd>Gitsigns next_hunk<cr>',
      mode = 'n',
      desc = ']Next git hunk',
    },
    {
      'gj',
      '<cmd>Gitsigns next_hunk<cr>',
      mode = 'n',
      desc = ']Next git hunk',
    },
    {
      '[g',
      '<cmd>Gitsigns prev_hunk<cr>',
      mode = 'n',
      desc = '[Prev git hunk',
    },
    {
      'gk',
      '<cmd>Gitsigns prev_hunk<cr>',
      mode = 'n',
      desc = '[Prev git hunk',
    },
    {
      '<leader><leader>B',
      '<cmd>Gitsigns blame<cr>',
      mode = 'n',
      desc = '[G]it [B]lame',
    },
    {
      '<leader><leader>g',
      '<cmd>Gitsigns toggle_signs<cr>',
      mode = 'n',
      desc = '[T]oggle [G]it signs',
    },
  },
}
