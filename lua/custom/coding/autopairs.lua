-- autopair parentheses
return {
  'windwp/nvim-autopairs',
  event = 'BufEnter',
  dependencies = { 'hrsh7th/nvim-cmp' },
  -- Keymap to toggle autopair.
  keys = {
    vim.keymap.set('n', '<leader><leader>p', function()
      local pairs = require 'nvim-autopairs'
      local log_level = nil
      if pairs.state.disabled then
        pairs.enable()
        log_level = vim.log.levels.INFO
      else
        pairs.disable()
        log_level = vim.log.levels.WARN
      end

      vim.notify('set autopair to ' .. tostring(not pairs.state.disabled), log_level)
    end, { desc = '[T]oggle auto[P]airs' }),
  },
  config = function()
    require('nvim-autopairs').setup {}
    -- If you want to automatically add `(` after selecting a function or method
    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    local cmp = require 'cmp'
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}
