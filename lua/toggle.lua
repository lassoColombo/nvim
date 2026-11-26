-- Every <leader><leader><leader> toggle reports its new state through here:
-- INFO when the thing turns on, WARN when it turns off.
return function(name, enabled)
  vim.notify(('set %s to %s'):format(name, tostring(enabled)), enabled and vim.log.levels.INFO or vim.log.levels.WARN)
end
