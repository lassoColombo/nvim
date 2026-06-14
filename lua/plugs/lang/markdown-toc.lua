return {
  'hedyhli/markdown-toc.nvim',
  ft = 'markdown', -- Lazy load on markdown filetype
  cmd = { 'Mtoc' }, -- Or, lazy load on "Mtoc" command
  keys = {
    {
      '<leader><leader>t',
      '<cmd>Mtoc<cr>',
      mode = 'n',
      ft = { 'markdown' },
      desc = '[]Generate [T]OC',
    },
  },
}
