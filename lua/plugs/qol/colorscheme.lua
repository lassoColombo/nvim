local starry_cat_frappe = {
  -- tinty:start
  -- color slots (catppuccin uses these for syntax highlighting)
  rosewater = '#fce8d4', -- pale cream-peach (hardcoded) — warmest highlight tier
  flamingo = '#f0c0b0', -- light coral (hardcoded) — decorative warm
  pink = '#d6a0c9', -- twilight indigo — shebang/Special, kept distinct from blue/functions
  mauve = '#f2839e', -- bright moon (peachy pink) — reserved keywords (if/else/for/return/func/etc.)
  red = '#eb6f92', -- moon amber — errors, deletions
  maroon = '#e0a0a0', -- coral (hardcoded) — between red and pink, subtle warnings
  peach = '#f4c894', -- warm orange (hardcoded) — operators, numbers, booleans
  yellow = '#ebbcba', -- star yellow — built-in types, italics
  green = '#31748f', -- hill sage — strings, diff added (canonical catppuccin green)
  teal = '#9ccfd8', -- swirl cyan — types
  sky = '#7ba9c4', -- pale sky — operators, info, special punctuation
  sapphire = '#88b8d8', -- medium blue (hardcoded) — constructors
  blue = '#c4a7e7', -- sky-swirl blue — functions/Directory ("blue carries the code")
  lavender = '#d8c8f5', -- (swapped) brighter pale sky — variables, identifiers, @property, @variable.member

  -- text + UI luminance gradient (brightest → darkest)
  text = '#ecdcc4', -- pinned paler than base05 to match alacritty body fg — softer terminal-wide warm cream
  subtext1 = '#908caa', -- swirl bright — dim text
  subtext0 = '#94aac0', -- (hardcoded) — slightly dimmer than subtext1
  overlay2 = '#6e6a86', -- swirl mid — line numbers, comments
  overlay1 = '#6c84a0', -- (hardcoded) — UI chrome
  overlay0 = '#506a88', -- (hardcoded) — darker chrome
  surface2 = '#26233a', -- swirl shadow — selections, borders
  surface1 = '#2e4068', -- (hardcoded) — between surface2 and surface0
  surface0 = '#1f1d2e', -- lighter sky stratum — input bg
  base = '#191724', -- deep cobalt — main background
  mantle = '#0c1830', -- (hardcoded) — slightly darker than base
  crust = '#15131f', -- deepest cobalt — bottommost layer
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
