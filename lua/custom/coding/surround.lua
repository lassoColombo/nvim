return {
  'echasnovski/mini.surround',
  version = false,
  init = function()
    require('which-key').add {
      {
        mode = { 'n', 'v' },
        { '<bs>', group = '[]Surround' },
        { '<bs>_', hidden = true },
      },
    }
  end,
  opts = {
    -- Add custom surroundings to be used on top of builtin ones. For more
    -- information with examples, see `:h MiniSurround.config`.
    custom_surroundings = nil,

    -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
    highlight_duration = 500,

    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
      add = '<bs>a', -- Add surrounding in Normal and Visual modes
      delete = '<bs>d', -- Delete surrounding
      find = '<bs>f', -- Find surrounding (to the right)
      find_left = '<bs>F', -- Find surrounding (to the left)
      highlight = '<bs>h', -- Highlight surrounding
      replace = '<bs>r', -- Replace surrounding
      update_n_lines = '<bs>n', -- Update `n_lines`

      suffix_last = 'l', -- Suffix to search with "prev" method
      suffix_next = 'n', -- Suffix to search with "next" method
    },

    -- Number of lines within which surrounding is searched
    n_lines = 40,

    -- Whether to respect selection type:
    -- - Place surroundings on separate lines in linewise mode.
    -- - Place surroundings on each line in blockwise mode.
    respect_selection_type = false,

    -- How to search for surrounding (first inside current line, then inside
    -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
    -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
    -- see `:h MiniSurround.config`.
    search_method = 'cover',

    -- Whether to disable showing non-error feedback
    silent = false,
  },
}
