return {
  'echasnovski/mini.indentscope',
  version = false, -- wait till new 0.7.0 release to put it back on semver
  event = 'BufEnter',
  opts = {
    symbol = '╎',
    options = { try_as_border = true },
    mappings = {
      object_scope = 'ii',
      object_scope_with_border = 'ai',
      goto_top = '[i',
      goto_bottom = ']i',
    },
  },
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'help',
        'alpha',
        'dashboard',
        'neo-tree',
        'Trouble',
        'trouble',
        'lazy',
        'mason',
        'notify',
        'toggleterm',
        'lazyterm',
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
}
