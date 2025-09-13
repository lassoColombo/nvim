return {
  'ofirgall/goto-breakpoints.nvim',
  config = function() end,
  lazy = false,
  keys = {
    {
      ']b',
      function()
        require('goto-breakpoints').next()
      end,
      mode = { 'n', 'v' },
      desc = ']Next breakpoint',
    },
    {
      '[b',
      function()
        require('goto-breakpoints').prev()
      end,
      mode = { 'n', 'v' },
      desc = ']Previous breakpoint',
    },
  },
}
