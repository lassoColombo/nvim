return {
  'nanotee/sqls.nvim',
  ft = { 'sql', 'mysql' },
  event = 'BufEnter',
  config = function()
    -- :NOTE: useless
    -- vim.keymap.set('n', '<leader>lld', '<cmd>SqlsShowDatabases<CR>', { desc = '[L]SP [L]ist [D]atabases' })
    -- vim.keymap.set('n', '<leader>lls', '<cmd>SqlsShowSchemas<CR>', { desc = '[L]SP [L]ist [S]chema' })
    -- vim.keymap.set('n', '<leader>llc', '<cmd>SqlsShowConnections<CR>', { desc = '[L]SP [L]ist [C]onnections' })
    vim.keymap.set('n', '<Space><Space>d', '<cmd>SqlsSwitchDatabase<CR>', { desc = '[L]SP [S]witch [D]atabase' })
    vim.keymap.set('n', '<Space><Space>c', '<cmd>SqlsSwitchConnection<CR>', { desc = '[L]SP [S]witch [C]onnection' })
    vim.keymap.set('n', '<Space><Space>x', '<cmd>SqlsExecuteQuery<CR>', { desc = '[L]SP [E]xecute [Q]uery' })
  end,
}
