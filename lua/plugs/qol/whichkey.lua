return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  opts = {
    -- delay between pressing a key and opening which-key (milliseconds)
    -- this setting is independent of vim.o.timeoutlen
    delay = 0,
    icons = {
      -- set icon mappings to true if you have a Nerd Font
      mappings = vim.g.have_nerd_font,
      -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
      -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
      keys = {},
    },

    -- Document existing key chains
    spec = {
      { '<leader>', group = '[]LSP and more' },
      { '<leader>g', group = '[G]it' },
      { '<leader><leader>n', group = 'Ts-[N]ode' },
      { '<leader><leader>s', group = '[S]essions' },
      { '<leader><leader>k', group = '[K]ubectl' },
      { '<leader><leader><leader>', group = '[]toggle' },
      { '<leader><leader>i', group = 'A[I]' },
      { '<bs>s', group = '[D]ebugger' },
      -- { '<leader>a', group = '[A]I' },
      -- { '<leader>u', group = '[T]oggle' },
      -- { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    },
  },
}
