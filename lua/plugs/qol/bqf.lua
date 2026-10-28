return {
  'kevinhwang91/nvim-bqf',
  ft = 'qf',
  opts = {
    auto_resize_height = true,
    preview = {
      win_height = 30,
      win_vheight = 29,
      delay_syntax = 80,
      should_preview_cb = function(bufnr)
        local size = vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr))
        return size < 100 * 1024
      end,
    },
    func_map = {
      open = 'o',
      openc = '<CR>',
      split = '<C-s>',
      tab = '<C-t>',
    },
  },
}
