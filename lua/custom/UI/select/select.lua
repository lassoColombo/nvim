---@diagnostic disable-next-line: duplicate-set-field
vim.ui.select = function(items, opts, on_choice)
  require('telescope.pickers')
    .new(
      vim.tbl_extend('force', opts, {
        layout_strategy = 'vertical',
        layout_config = {
          width = 0.5,
          height = 0.4,
          prompt_position = 'top',
        },
        border = true,
        borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      }),
      {
        prompt_title = opts.prompt or 'Select one of:',
        finder = require('telescope.finders').new_table {
          results = items,
          entry_maker = function(item)
            return {
              value = item,
              display = opts.format_item and opts.format_item(item) or tostring(item),
              ordinal = tostring(item),
            }
          end,
        },
        sorter = require('telescope.config').values.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
          local actions = require 'telescope.actions'
          actions.select_default:replace(function()
            local selection = require('telescope.actions.state').get_selected_entry()
            actions.close(prompt_bufnr)
            if on_choice ~= nil then
              on_choice(selection.value)
            end
          end)
          return true
        end,
      }
    )
    :find()
end
