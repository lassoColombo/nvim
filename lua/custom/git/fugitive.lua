return {
  'tpope/vim-fugitive',
  event = 'VimEnter',
  config = function() end,
  keys = {
    {
      'gi',
      function()
        vim.ui.input({ prompt = 'Revision: ' }, function(input)
          vim.api.nvim_command('Gedit ' .. input .. ':%')
        end)
      end,
      mode = 'n',
      desc = '[G]it [I]nspect',
    },
    {
      'gp',
      '<cmd>Git pull<cr>',
      mode = 'n',
      desc = '[G]it [P]ull',
    },
    {
      'gP',
      '<cmd>Git push<cr>',
      mode = 'n',
      desc = '[G]it [P]ush',
    },
    {
      'gL',
      '<cmd>Git log<cr>',
      mode = 'n',
      desc = '[G]it [L]og',
    },
  },
}
