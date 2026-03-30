return {
  'ofirgall/goto-breakpoints.nvim',
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
