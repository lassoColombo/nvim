return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    -- delay between pressing a key and opening which-key (milliseconds)
    -- this setting is independent of vim.o.timeoutlen
    delay = 0,

    -- Document existing key chains
    spec = {
      { '<leader>', group = '[]LSP and more' },
      { '<leader>g', group = '[G]it' },
      { '<leader><leader>n', group = 'Ts-[N]ode' },
      { '<leader><leader>s', group = '[S]essions' },
      { '<leader><leader>k', group = '[K]ubectl' },
      { '<leader><leader><leader>', group = '[]toggle' },
      -- { '<leader>a', group = '[A]I' },
      -- { '<leader>u', group = '[T]oggle' },
      -- { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    },
  },
}
