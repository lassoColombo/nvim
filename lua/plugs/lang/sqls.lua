local function execute_query()
  local node = vim.treesitter.get_node()
  while node and node:type() ~= 'statement' do
    node = node:parent()
  end
  if not node then
    vim.notify('No SQL statement found at cursor', vim.log.levels.WARN)
    return
  end
  local start_row = node:start()
  local end_row = node:end_()
  vim.cmd(string.format('%d,%dSqlsExecuteQuery', start_row + 1, end_row + 1))
end

return {
  'nanotee/sqls.nvim',
  -- Not lazy: its lsp/sqls.lua adds the on_attach that creates the :Sqls* commands, and
  -- vim.lsp caches every enabled server's config the first time any buffer gets a
  -- filetype, so the plugin has to be on the runtimepath before that.
  lazy = false,
  keys = {
    {
      '<leader><leader>x',
      execute_query,
      mode = 'n',
      ft = { 'sql' },
      desc = '[S]qls e[X]ecute',
    },
    {
      '<leader><leader>x',
      ':SqlsExecuteQuery<cr>',
      mode = 'v',
      ft = { 'sql' },
      desc = '[S]qls e[X]ecute selection',
    },
    {
      '<leader><leader>d',
      '<cmd>SqlsSwitchDatabase<cr>',
      mode = 'n',
      desc = '[S]qls switch [D]atabase',
      ft = { 'sql' },
    },
    {
      '<leader><leader>c',
      '<cmd>SqlsSwitchConnection<cr>',
      mode = 'n',
      ft = { 'sql' },
      desc = '[S]qls switch [C]onnection',
    },
  },
}
