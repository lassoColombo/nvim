local M = {}

M.get_directories = function(dir)
  local dirs = {}
  local handle = vim.loop.fs_scandir(dir)
  if not handle then
    return dirs
  end
  table.insert(dirs, dir)
  while true do
    local name, typ = vim.loop.fs_scandir_next(handle)
    if not name then
      break
    end
    if typ == 'directory' then
      local full_path = dir .. '/' .. name
      table.insert(dirs, full_path)
      -- Recursively call the function for subdirectories
      local subdirs = M.get_directories(full_path)
      for _, subdir in ipairs(subdirs) do
        table.insert(dirs, subdir)
      end
    end
  end
  return dirs
end

return M
