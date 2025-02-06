local quit = function()
  vim.cmd 'Neotree close'

  local modified_buffers = {}
  local bs = vim.api.nvim_list_bufs()
  local function get_relative_path(buf_name)
    local cwd = vim.fn.getcwd()
    return vim.fn.fnamemodify(buf_name, ':~:.'):gsub('^' .. cwd, '.')
  end

  local max_length = 0
  for _, b in ipairs(bs) do
    if vim.api.nvim_buf_is_loaded(b) and vim.api.nvim_get_option_value('modified', { buf = b }) then
      local relative_path = get_relative_path(vim.api.nvim_buf_get_name(b))
      table.insert(modified_buffers, '  - ' .. relative_path)
      if #relative_path > max_length then
        max_length = #relative_path
      end
    end
  end
  if #modified_buffers == 0 then
    vim.cmd 'qa'
  end
  local intro = { '🚧 There are unsaved buffers 🚧', '' }

  local width = 40
  if max_length > width then
    width = max_length + 6
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = buf })
  local win_opts = {
    relative = 'editor',
    width = width,
    height = #modified_buffers + 3,
    row = 10,
    col = 10,
    style = 'minimal',
    border = 'rounded',
  }
  local win = vim.api.nvim_open_win(buf, true, win_opts)
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':q<CR>', { noremap = true, silent = true, desc = '[Q]uit window' })
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.list_extend(intro, modified_buffers))
end

vim.keymap.set('n', '<leader>qq', quit, { desc = '[Q]uit' })
