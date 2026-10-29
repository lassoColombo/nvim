return {
  'nvim-treesitter/nvim-treesitter-context',
  event = 'BufEnter',
  config = function(_, opts)
    require('treesitter-context').setup(opts)
    vim.keymap.set('n', '<leader><leader><leader>c', function()
      local context = require 'treesitter-context'
      if context.enabled() then
        context.disable()
      else
        context.enable()
      end
      vim.notify('set treesitter context to ' .. tostring(context.enabled()), vim.log.levels.INFO)
    end, { desc = '[T]oggle [C]ontext' })
  end,
  opts = {
    on_attach = function(buf) -- return false to disable attaching
      local ft = vim.bo[buf].filetype
      return ft == 'yaml' or ft == 'json'
    end,
  },
}
