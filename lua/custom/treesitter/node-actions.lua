return {
  'lassoColombo/ts-node-action',
  branch = 'range-as-an-opt',
  event = 'VimEnter',
  dependencies = { 'nvim-treesitter' },
  opts = function()
    -- :NOTE: trying to integrate into none-ls
    -- vim.keymap.set('n', '<Space>T', require('ts-node-action').available_actions, { desc = '[T]reesitter available [A]ctions' })
    -- vim.keymap.set('n', '<Space>t', require('ts-node-action').node_action, { desc = '[T]reesitter [A]ctions' })
    -- require('ts-node-action').setup {
    --   python = require 'custom.treesitter.node-actions.python',
    --   lua = require 'custom.treesitter.node-actions.lua-actions',
    --   go = require 'custom.treesitter.node-actions.go',
    -- }
  end,
  -- config = function()
  --   vim.keymap.set('n', '<leader>cta', require('ts-node-action').node_action, { desc = '[C]ode [T]reesitter [A]ctions' })
  -- end,
  setup = {},
}
