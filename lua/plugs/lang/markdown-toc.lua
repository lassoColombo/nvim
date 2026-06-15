return {
  'hedyhli/markdown-toc.nvim',
  ft = 'markdown',
  cmd = 'Mtoc',
  opts = {},
  keys = {
    {
      '<leader><leader>T',
      '<cmd>Mtoc<cr>',
      mode = 'n',
      desc = 'Generate [T]OC',
    },
  },
}
