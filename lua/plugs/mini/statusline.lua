local statusline = require 'mini.statusline'

vim.o.laststatus = 3

statusline.setup {
  use_icons = true,
  set_vim_settings = true,
}

local function active()
  return statusline.combine_groups {
    -- Left
    { hl = 'MiniStatuslineMode', strings = { statusline.section_mode { trunc_width = 200 } } },
    {
      hl = 'MiniStatuslineDevinfo',
      strings = {
        statusline.section_git { trunc_width = 75 },
        -- statusline.section_filename { trunc_width = 140 },
        statusline.section_diagnostics { trunc_width = 75 },
      },
    },

    -- Middle
    {
      hl = 'MiniStatuslineFilename',
    },

    -- Right
    {
      hl = 'MiniStatuslineFileinfo',
    },
  }
end

-- Inactive statusline (just filename)
local function inactive()
  return statusline.combine_groups {
    { hl = 'MiniStatuslineInactive', strings = { statusline.section_filename { trunc_width = 140 } } },
  }
end

-- Override sections
statusline.section_active = active
statusline.section_inactive = inactive
