return {
  'brianhuster/live-preview.nvim',
  ft = 'markdown',
  keys = {
    {
      '<leader><leader>p',
      function()
        vim.cmd.LivePreview(require('livepreview').is_running() and 'close' or 'start')
      end,
      mode = 'n',
      ft = { 'markdown' },
      desc = 'Toggle browser [P]review',
    },
  },
}
