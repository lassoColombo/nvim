local rose_pine_frappe = {
  -- tinty:start
  -- color slots (catppuccin uses these for syntax highlighting)
  rosewater = '#fff0ee', -- bright rose — brightest protagonist (H1)
  flamingo = '#ffaace', -- bright accent (palette-driven) — decorative warm
  pink = '#f6c177', -- twilight indigo — shebang/Special, kept distinct from blue/functions
  mauve = '#ffaace', -- bright moon (peachy pink) — reserved keywords (if/else/for/return/func/etc.)
  red = '#eb6f92', -- moon amber — errors, deletions
  maroon = '#eb6f92', -- error/warn family (palette-driven) — subtle warnings
  peach = '#f6c177', -- secondary warm data (palette-driven) — operators, numbers, booleans
  yellow = '#ebbcba', -- star yellow — built-in types, italics
  green = '#31748f', -- hill sage — strings, diff added (canonical catppuccin green)
  teal = '#9ccfd8', -- swirl cyan — types
  sky = '#9ccfd8', -- foam — operators, info, special punctuation
  sapphire = '#d6ffff', -- bright foam — constructors
  blue = '#c4a7e7', -- sky-swirl blue — functions/Directory ("blue carries the code")
  lavender = '#ffecff', -- (swapped) brighter pale sky — variables, identifiers, @property, @variable.member

  -- text + UI luminance gradient (brightest → darkest)
  text = '#e0def4', -- palette body fg
  subtext1 = '#8c88a6', -- swirl bright — dim text
  subtext0 = '#94aac0', -- (hardcoded) — slightly dimmer than subtext1
  overlay2 = '#6e6a86', -- swirl mid — line numbers, comments
  overlay1 = '#6c84a0', -- (hardcoded) — UI chrome
  overlay0 = '#506a88', -- (hardcoded) — darker chrome
  surface2 = '#26233a', -- swirl shadow — selections, borders
  surface1 = '#2e4068', -- (hardcoded) — between surface2 and surface0
  surface0 = '#1f1d2e', -- lighter sky stratum — input bg
  base = '#191724', -- deep cobalt — main background
  mantle = '#090713', -- below base — code block bg
  crust = '#020109', -- deepest cobalt — bottommost layer
  -- tinty:end
}

return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavour = 'frappe',
      transparent_background = true,
      float = {
        transparent = true,
        solid = false,
      },
      color_overrides = {
        frappe = rose_pine_frappe,
      },
      highlight_overrides = {
        frappe = function(C)
          local U = require 'catppuccin.utils.colors'
          local hl = {
            RenderMarkdownBullet = { fg = C.yellow },
            RenderMarkdownTableHead = { fg = C.rosewater, bold = true },
            RenderMarkdownTableRow = { fg = C.overlay2 },
          }
          -- bright rose protagonist first, then one distinct hue per level
          for i, c in ipairs { C.rosewater, C.blue, C.peach, C.teal, C.green, C.subtext1 } do
            hl['RenderMarkdownH' .. i] = { fg = c, bold = true }
            hl['RenderMarkdownH' .. i .. 'Bg'] = { bg = U.darken(c, 0.2, C.base) }
          end
          return hl
        end,
      },
    }

    vim.cmd.colorscheme 'catppuccin'
  end,
}
