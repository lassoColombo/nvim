-- -- toggle
-- toggle word wrap
vim.keymap.set('n', '<leader><leader>w', function()
  vim.wo.wrap = not vim.wo.wrap
  vim.notify('set line wrap to ' .. tostring(vim.wo.wrap), vim.log.levels.WARN)
end, { desc = '[T]oggle line [W]rap' })

-- toggle line relativeness
vim.keymap.set('n', '<leader><leader>l', '<esc>:set relativenumber!<cr>', { desc = '[T]oggle relative [L]ines' })

-- toggle diagnostics
vim.keymap.set('n', '<leader><leader>d', function()
  if vim.diagnostic.is_enabled() then
    vim.diagnostic.enable(false)
  else
    vim.diagnostic.enable(true)
  end
  local is_enabled = vim.diagnostic.is_enabled()
  local log_level = (is_enabled and vim.log.levels.INFO or vim.log.levels.WARN)
  vim.notify('set diagnostics to ' .. tostring(is_enabled), log_level)
end, { desc = '[T]oggle [D]iagnostics' })

-- toggle cmdbar
-- :NOTE: re-enable when and if will ever override again nvim cmdbar
-- vim.cmd 'set cmdheight=0'
-- local __cmdbar = false
-- vim.keymap.set('n', '<leader><leader>C', function()
--   if __cmdbar then
--     vim.cmd 'set cmdheight=0'
--     __cmdbar = false
--   else
--     vim.cmd 'set cmdheight=1'
--     __cmdbar = true
--   end
--   local log_level = (__cmdbar and vim.log.levels.INFO or vim.log.levels.WARN)
--   vim.notify('set cmdbar to ' .. tostring(__cmdbar), log_level)
-- end, { desc = '[T]oggle [C]ommandbar' })
