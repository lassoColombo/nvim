local M = {}

M.copypaath = function(reg)
  local _copy = function(entry)
    vim.fn.setreg(reg, entry)
    vim.notify('Copied: ' .. entry, vim.log.levels.INFO)
  end
  local oil = require 'oil'
  local entry = oil.get_cursor_entry()
  local dir = oil.get_current_dir()
  if not entry or not dir then
    return
  end
  entry = entry.parsed_name
  vim.ui.select({
    '1. Absolute path',
    '2. Path relative to CWD',
    '3. Path relative to HOME',
    '4. Filename',
    '5. Filename without extension',
    '6. Extension of the filename',
  }, { prompt = ' 📋copy path:' }, function(choice)
    if not choice then
      vim.notify('selection cancelled', vim.log.levels.WARN)
      return
    end
    local i = tonumber(choice:sub(1, 1))
    if not i then
      vim.notify('Invalid selection', vim.log.levels.ERROR)
      return
    end
    if i == 1 then
      _copy(vim.fn.fnamemodify(dir .. entry, ':p'))
    elseif i == 2 then
      _copy(vim.fn.fnamemodify(dir, ':.'))
    elseif i == 3 then
      _copy(vim.fn.fnamemodify(dir, ':~'))
    elseif i == 4 then
      _copy(entry)
    elseif i == 5 then
      _copy(entry:match '^.+(%..+)$' or '')
    elseif i == 6 then
      _copy(entry:match '(.+)%..+$' or entry)
    else
      vim.notify('Invalid selection', vim.log.levels.ERROR)
      return
    end
  end)
end

return M
