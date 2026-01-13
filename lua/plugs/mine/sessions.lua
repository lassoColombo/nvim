return {
  dir = vim.fn.stdpath 'config' .. '/lua/sessions',
  name = 'sessions',
  lazy = false,
  config = function()
    require('sessions').setup()
  end,
  keys = {
    {
      '<leader><leader>sl',
      function()
        vim.notify(vim.inspect(require('sessions').list()))
      end,
      mode = 'n',
      desc = '[S]essions [L]ist',
    },
    {
      '<leader><leader>ss',
      require('sessions').resume,
      mode = 'n',
      desc = '[S]essions re[S]ume',
    },
    {
      '<leader><leader>sw',
      require('sessions').write,
      mode = 'n',
      desc = '[S]essions [W]rite',
    },
    {
      '<leader><leader>sx',
      require('sessions').delete,
      mode = 'n',
      desc = '[S]essions Delete',
    },
    {
      '<leader><leader>sd',
      function()
        vim.notify(vim.inspect(require('sessions').detected()))
      end,
      mode = 'n',
      desc = '[S]essions [D]etected',
    },
  },
}
