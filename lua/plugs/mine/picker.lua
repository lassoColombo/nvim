return {
  dir = vim.fn.stdpath 'config' .. '/lua/picker',
  name = 'picker',
  event = 'VeryLazy',
  config = function()
    require('picker').setup()
  end,
  -- keys = {
  --   {
  --     '<leader>l',
  --     function()
  --       require('picker').open()
  --     end,
  --     desc = 'Open Lazygit (float)',
  --   },
  -- },
}
