return {
  'kevinhwang91/nvim-bqf',
  ft = 'qf',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    auto_enable = true,
    auto_resize_height = true,

    preview = {
      win_height = 12,
      win_vheight = 12,
      delay_syntax = 80,
      border = 'rounded',
      show_title = true,
      should_preview_cb = function(bufnr)
        local size = vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr))
        return size < 100 * 1024
      end,
    },

    func_map = {
      open = 'o',
      openc = '<CR>',
      split = '<C-s>',
      vsplit = '<C-v>',
      tab = '<C-t>',
      prevfile = '<C-p>',
      nextfile = '<C-n>',
      prevhist = '<',
      nexthist = '>',
    },
  },
}
