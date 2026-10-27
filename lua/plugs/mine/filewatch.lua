return {
  dir = vim.fn.stdpath 'config' .. '/lua/filewatch',
  name = 'filewatch',
  lazy = false,
  config = function()
    require('filewatch').setup()
  end,
  keys = {
    {
      '<leader><leader>fd',
      function()
        require('filewatch').diff()
      end,
      mode = 'n',
      desc = '[F]ilewatch [D]iff buffer vs disk',
    },
  },
}
