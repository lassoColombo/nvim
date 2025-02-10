Wfile = function(path, data)
  print('writing to ' .. path)
  local file = io.open(path, 'w')
  if not file then
    error('Could not open file: ' .. path)
  end
  file:write(data)
  file:close()
end

PP = function(val)
  print(vim.inspect(val))
end

Wbuf = function(val)
  local lsp_client_str = vim.inspect(val)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(lsp_client_str, '\n'))
  vim.api.nvim_set_current_buf(buf)
end
