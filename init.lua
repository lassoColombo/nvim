require 'custom.opts'
require 'custom.keymaps'
require 'custom.autocmds'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
  { import = 'custom.utils' },
  { import = 'custom.treesitter' },
  { import = 'custom.lsp' },
  { import = 'custom.cmp' },
  { import = 'custom.UI' },
  { import = 'custom.telescope' },
  { import = 'custom.git' },
  { import = 'custom.coding' },
  -- { import = 'custom.unittest' },
  { import = 'custom.dap' },
  { import = 'custom.langs.python' },
  { import = 'custom.langs.golang' },
  { import = 'custom.langs.sql' },
  { import = 'custom.langs.markdown' },
  { import = 'custom.langs.json' },
  { import = 'custom.langs.yaml' },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '👮',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '🐣',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

vim.keymap.set({ 'n' }, '<Space>l', '<cmd>Lazy<cr>', { desc = '[L]azy' })

require 'custom.UI.select.select'
