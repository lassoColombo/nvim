local show_dotfiles = true

-- The global filter reads the current choice: `MiniFiles.open` rebuilds its options
-- from `MiniFiles.config`, so the toggle survives closing the explorer.
local filter = function(fs_entry)
  return show_dotfiles or not vim.startswith(fs_entry.name, '.')
end
MiniFiles.config.content.filter = filter

local toggle_dotfiles = function()
  show_dotfiles = not show_dotfiles
  vim.notify('set show-dotfiles to ' .. tostring(show_dotfiles))
  MiniFiles.refresh { content = { filter = filter } }
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local buf_id = args.data.buf_id
    vim.keymap.set('n', 'H', toggle_dotfiles, { buffer = buf_id })
  end,
})
