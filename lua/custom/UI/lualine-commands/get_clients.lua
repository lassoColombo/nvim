local function get_client_name(s, client, buf)
  local name = client.name
  if name == 'null-ls' then
    return nil
  end
  local bufs = client.attached_buffers
  return bufs[buf] and name or nil
end

local function get_clients()
  local clients = vim.lsp.get_clients()
  local n = #clients
  local s = ''
  local buf = vim.api.nvim_get_current_buf()

  for i = 1, n --[[ - 1 ]] do
    local name = get_client_name(s, clients[i], buf)
    s = name and (s .. '🔭 ' .. name .. '') or s
  end
  return s
end
return get_clients
