return {
  custom_surroundings = nil,

  highlight_duration = 500,

  mappings = {
    add = 'ga', -- Add surrounding in Normal and Visual modes
    delete = 'gd', -- Delete surrounding
    replace = 'gr', -- Replace surrounding
    -- find = '<tab>f', -- Find surrounding (to the right)
    -- find_left = '<tab>F', -- Find surrounding (to the left)
    -- highlight = '<tab>h', -- Highlight surrounding
    -- update_n_lines = '<tab>n', -- Update `n_lines`

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
}
