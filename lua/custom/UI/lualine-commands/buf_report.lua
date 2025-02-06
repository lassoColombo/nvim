local M = {}

local function shorten(path)
  local components = {}
  for component in string.gmatch(path, '[^/]+') do
    table.insert(components, component)
  end
  if #components > 3 then
    for i = 1, #components - 1 do
      components[i] = string.sub(components[i], 1, 3)
    end
  end
  return table.concat(components, '/')
end

M.report = function()
  local buffers = vim.api.nvim_list_bufs()

  local count = 0
  local unsaved_buffer_name = vim.api.nvim_get_option_value('modified', { buf = 0 }) and 'this' or nil
  local from

  for _, buf in ipairs(buffers) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_get_option_value('modified', { buf = buf }) then
      count = count + 1
      if not unsaved_buffer_name then
        unsaved_buffer_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ':.')
      end
    end
  end
  if count == 0 then
    return ''
  end
  return string.format('%d 📝 %s', count, shorten(unsaved_buffer_name) or '')
end

return M
