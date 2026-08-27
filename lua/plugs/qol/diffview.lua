return {
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffviewClose' },
    opts = {
      enhanced_diff_hl = true,
      view = { merge_tool = { layout = 'diff3_mixed' } },
    },
    keys = {
      { '<leader>gv', '<cmd>DiffviewOpen<cr>', desc = 'git [v]iew diff (working tree)' },
      { '<leader>gV', '<cmd>DiffviewFileHistory %<cr>', desc = 'git [V]iew file history' },
      { '<leader>gx', '<cmd>DiffviewClose<cr>', desc = 'git close diffview [x]' },
    },
  },
}
