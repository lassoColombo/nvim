local show_dotfiles = true

local filter_show = function(fs_entry)
  return true
end

local filter_hide = function(fs_entry)
  return not vim.startswith(fs_entry.name, '.')
end

local toggle_dotfiles = function()
  show_dotfiles = not show_dotfiles
  local new_filter = show_dotfiles and filter_show or filter_hide
  vim.notify('set show-dotfiles to ' .. tostring(show_dotfiles))
  MiniFiles.refresh { content = { filter = new_filter } }
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local buf_id = args.data.buf_id
    vim.keymap.set('n', 'H', toggle_dotfiles, { buffer = buf_id })
  end,
})
