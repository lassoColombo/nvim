return {
  'ofirgall/goto-breakpoints.nvim',
  config = function() end,
  lazy = false,
  keys = {
    {
      ']B',
      function()
        require('goto-breakpoints').next()
      end,
      mode = { 'n', 'v' },
      desc = ']Next breakpoint',
    },
    {
      '[B',
      function()
        require('goto-breakpoints').prev()
      end,
      mode = { 'n', 'v' },
      desc = ']Previous breakpoint',
    },
  },
}
