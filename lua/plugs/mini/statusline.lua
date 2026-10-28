local statusline = require 'mini.statusline'

vim.o.laststatus = 3

statusline.setup { use_icons = true }

-- single global statusline: mode, git, diagnostics
statusline.section_active = function()
  return statusline.combine_groups {
    { hl = 'MiniStatuslineMode', strings = { statusline.section_mode { trunc_width = 200 } } },
    {
      hl = 'MiniStatuslineDevinfo',
      strings = {
        statusline.section_git { trunc_width = 75 },
        statusline.section_diagnostics { trunc_width = 75 },
      },
    },
  }
end
