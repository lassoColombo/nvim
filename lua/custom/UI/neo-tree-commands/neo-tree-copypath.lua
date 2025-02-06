return {
  copy_relative_path = function(state)
    local node = state.tree:get_node()
    local filepath = node:get_id()
    local modify = vim.fn.fnamemodify
    filepath = modify(filepath, ':.')

    if filepath then
      vim.fn.setreg('"', filepath)
      vim.notify('Copied: ' .. filepath)
    end
  end,
  copy_absolute_path = function(state)
    local node = state.tree:get_node()
    local filepath = node:get_id()
    if filepath then
      vim.notify('Copied: ' .. filepath)
      vim.fn.setreg('"', filepath)
    end
  end,
  copy_filename = function(state)
    local node = state.tree:get_node()
    local filename = node.name

    if filename then
      vim.fn.setreg('"', filename)
      vim.notify('Copied: ' .. filename)
    end
  end,
  copy_paths = function(state)
    local node = state.tree:get_node()
    local filepath = node:get_id()
    local filename = node.name
    local modify = vim.fn.fnamemodify

    local results = {
      filepath,
      modify(filepath, ':.'),
      modify(filepath, ':~'),
      filename,
      modify(filename, ':r'),
      modify(filename, ':e'),
    }

    vim.ui.select({
      '1. Absolute path: ' .. results[1],
      '2. Path relative to CWD: ' .. results[2],
      '3. Path relative to HOME: ' .. results[3],
      '4. Filename: ' .. results[4],
      '5. Filename without extension: ' .. results[5],
      '6. Extension of the filename: ' .. results[6],
    }, { prompt = 'copy path to clipboard:' }, function(choice)
      if choice then
        local i = tonumber(choice:sub(1, 1))
        if i then
          local result = results[i]
          vim.fn.setreg('"', result)

          vim.notify('Copied: ' .. result)
        else
          vim.notify 'Invalid selection'
        end
      else
        vim.notify 'Selection cancelled'
      end
    end)
  end,
}
