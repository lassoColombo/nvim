return {
  'aaronik/treewalker.nvim',
  opts = {
    highlight = true, -- Whether to briefly highlight the node after jumping to it
    highlight_duration = 200, -- How long should above highlight last (in ms)
  },
  keys = {
    {
      '<C-k>',
      '<cmd>Treewalker Up<CR>',
      mode = { 'n', 'v' },
      desc = ']next [N]ode [U]p',
    },
    {
      '<C-j>',
      '<cmd>Treewalker Down<CR>',
      mode = { 'n', 'v' },
      desc = ']Next [N]ode [D]own',
    },
    {
      '<C-h>',
      '<cmd>Treewalker Left<CR>',
      mode = { 'n', 'v' },
      desc = ']Next [N]ode [L]eft',
    },
    {
      '<C-l>',
      '<cmd>Treewalker Right<CR>',
      mode = { 'n', 'v' },
      desc = ']next [N]ode [R]ight',
    },
  },
}
