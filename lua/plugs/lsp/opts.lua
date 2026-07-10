-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = true },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      return diagnostic.message
    end,
  },
  -- virtual_lines on the current line duplicates the inline virtual_text; disabled.
  -- virtual_lines = { current_line = true },
}

-- Toggle full-window virtual_lines (all diagnostics expanded) vs the default
-- compact virtual_text + current-line virtual_lines.
-- vim.keymap.set('n', '<leader><leader><leader>d', function()
--   local cfg = vim.diagnostic.config()
--   local full = type(cfg.virtual_lines) == 'table' and cfg.virtual_lines.current_line ~= true
--   if full then
--     vim.diagnostic.config { virtual_text = { source = 'if_many', spacing = 2 }, virtual_lines = { current_line = true } }
--   else
--     vim.diagnostic.config { virtual_text = false, virtual_lines = true }
--   end
--   vim.notify('diagnostics: ' .. (full and 'compact' or 'expanded'), vim.log.levels.INFO)
-- end, { desc = '[T]oggle [D]iagnostic virtual lines' })
