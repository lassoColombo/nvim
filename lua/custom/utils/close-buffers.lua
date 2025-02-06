local function closeBuffer(force)
  -- Define the options
  local choices = { 'this', 'all', 'other', 'hidden', 'nameless', 'regex', 'glob' }
  local prompt = 'close buffers on conditions'
  if force then
    prompt = '💀 forcefully ' .. prompt
  else
    prompt = '🌺 gracefully ' .. prompt
  end
  vim.ui.select(choices, {
    prompt = prompt,
    format_item = function(item)
      return item
    end,
  }, function(choice)
    if choice == 'this' or choice == 'all' or choice == 'other' or choice == 'hidden' or choice == 'nameless' then
      require('close_buffers').delete { type = choice, force = force }
      return
    end
    if choice == 'regex' then
      vim.ui.input({ prompt = 'regex: ' }, function(input)
        if input then
          require('close_buffers').delete { regex = input, force = force }
        end
      end)
    end
    if choice == 'glob' then
      vim.ui.input({ prompt = 'glob: ' }, function(input)
        if input then
          require('close_buffers').delete { glob = input, force = force }
        end
      end)
    end
  end)
end

return {
  'kazhala/close-buffers.nvim',
  opts = {
    filetype_ignore = {}, -- Filetype to ignore when running deletions
    file_glob_ignore = {}, -- File name glob pattern to ignore when running deletions (e.g. '*.md')
    file_regex_ignore = {}, -- File name regex pattern to ignore when running deletions (e.g. '.*[.]md')
    preserve_window_layout = { 'this', 'nameless' }, -- Types of deletion that should preserve the window layout
    next_buffer_cmd = function(windows) -- Custom function to retrieve the next buffer when preserving window layout
      -- :NOTE:
      -- Nvim-bufferline.lua can rearrange the buffer orders ignoring the buffer ID.
      -- The following will use the cycle command provided by nvim-bufferline.lua
      -- to get the next buffer when preserving the window layout.
      require('bufferline').cycle(1)
      local bufnr = vim.api.nvim_get_current_buf()
      for _, window in ipairs(windows) do
        vim.api.nvim_win_set_buf(window, bufnr)
      end
    end,
  },
  keys = {
    {
      'X',
      function()
        require('close_buffers').delete { type = 'this' } -- Delete the current buffer
      end,
      mode = 'n',
      desc = '[]close buffer',
    },
    {
      '<leader>b',
      function()
        closeBuffer(false)
      end,
      mode = 'n',
      desc = '[]close buffers on condition',
    },
    {
      '<leader>B',
      function()
        closeBuffer(true)
      end,
      mode = 'n',
      desc = '[]close buffers on condition!',
    },
  },
}
