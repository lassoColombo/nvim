local starry_cat_frappe = {
  -- tinty:start
  -- color slots (catppuccin uses these for syntax highlighting)
  rosewater = '#fce8d4', -- pale cream-peach (hardcoded) — warmest highlight tier
  flamingo = '#f0c0b0', -- light coral (hardcoded) — decorative warm
  pink = '#d8c0ff', -- twilight indigo — shebang/Special, kept distinct from blue/functions
  mauve = '#f0b094', -- bright moon (peachy pink) — reserved keywords (if/else/for/return/func/etc.)
  red = '#eca080', -- moon amber — errors, deletions
  maroon = '#e0a0a0', -- coral (hardcoded) — between red and pink, subtle warnings
  peach = '#f4c894', -- warm orange (hardcoded) — operators, numbers, booleans
  yellow = '#f4cc78', -- star yellow — built-in types, italics
  green = '#b0d8a0', -- hill sage — strings, diff added (canonical catppuccin green)
  teal = '#a8d4e4', -- swirl cyan — types
  sky = '#bcd6ec', -- pale sky — operators, info, special punctuation
  sapphire = '#88b8d8', -- medium blue (hardcoded) — constructors
  blue = '#9cd4fc', -- sky-swirl blue — functions/Directory ("blue carries the code")
  lavender = '#c8e0f4', -- (swapped) brighter pale sky — variables, identifiers, @property, @variable.member

  -- text + UI luminance gradient (brightest → darkest)
  text = '#f0d4a4', -- starlight — default foreground
  subtext1 = '#a4bad0', -- swirl bright — dim text
  subtext0 = '#94aac0', -- (hardcoded) — slightly dimmer than subtext1
  overlay2 = '#8aa4c0', -- swirl mid — line numbers, comments
  overlay1 = '#6c84a0', -- (hardcoded) — UI chrome
  overlay0 = '#506a88', -- (hardcoded) — darker chrome
  surface2 = '#304268', -- swirl shadow — selections, borders
  surface1 = '#2e4068', -- (hardcoded) — between surface2 and surface0
  surface0 = '#1a2842', -- lighter sky stratum — input bg
  base = '#0c1730', -- deep cobalt — main background
  mantle = '#0c1830', -- (hardcoded) — slightly darker than base
  crust = '#04080f', -- deepest cobalt — bottommost layer
  -- tinty:end
}

local catppuccin = {
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
        frappe = starry_cat_frappe,
      },
    }

    vim.cmd.colorscheme 'catppuccin'
  end,
}

local tokyonight = {
  'folke/tokyonight.nvim',
  priority = 1000,
  config = function()
    require('tokyonight').setup {
      styles = {
        comments = { italic = false },
        transparent = true,
        styles = {
          sidebars = 'transparent',
          floats = 'transparent',
        },
      },
    }
    vim.cmd.colorscheme 'tokyonight-night'
  end,
}

local colorschemes = {
  catppuccin = catppuccin,
  tokyonight = tokyonight,
}

local default = 'catppuccin'
local wanted = os.getenv 'NVIM_COLORSCHEME' or default
local got = colorschemes[wanted]

if not got then
  vim.notify('invalid colorscheme: ' .. wanted, vim.log.levels.WARN)
  return colorschemes[default]
end

return got
