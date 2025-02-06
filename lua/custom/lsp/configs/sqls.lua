return {
  cmd = { 'sqls', '-config', '~/.config/sqls/config.yml' },
  on_attach = function(client, bufnr)
    require('sqls').on_attach(client, bufnr) -- require sqls.nvim

    vim.keymap.set({ 'n', 'v' }, '<leader>x', '<cmd>SqlsExecuteQuery<CR>', { desc = 'e[X]ecute' })
    -- :NOTE: useless
    -- vim.keymap.set('n', '<leader>lld', '<cmd>SqlsShowDatabases<CR>', { desc = '[L]SP [L]ist [D]atabases' })
    -- vim.keymap.set('n', '<leader>lls', '<cmd>SqlsShowSchemas<CR>', { desc = '[L]SP [L]ist [S]chema' })
    -- vim.keymap.set('n', '<leader>llc', '<cmd>SqlsShowConnections<CR>', { desc = '[L]SP [L]ist [C]onnections' })
    vim.keymap.set('n', '<Space><Space>d', '<cmd>SqlsSwitchDatabase<CR>', { desc = '[L]SP [S]witch [D]atabase' })
    vim.keymap.set('n', '<Space><Space>c', '<cmd>SqlsSwitchConnection<CR>', { desc = '[L]SP [S]witch [C]onnection' })
  end,
}
