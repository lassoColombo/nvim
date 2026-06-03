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
        frappe = {
          -- Warm accents (each distinct)
          rosewater = "#e0d0a0",  -- pale gold — warm highlight, star halo
          flamingo = "#e8c8d0",   -- bright pastel pink — light decorative
          pink = "#d8b8c0",       -- pastel pink — gentle emphasis
          mauve = "#c0b6f2",      -- pastel lavender — control flow, rare
          red = "#d0a0a8",        -- muted rose — errors, deletions
          maroon = "#c8b0b8",     -- dim pink — subtle warning
          peach = "#c8b070",      -- warm sand — operators, distant city glow
          yellow = "#d4c87a",     -- pastel gold — keywords, star glow
          green = "#a8d8b0",      -- pastel green — strings
          -- Blues (8 distinct steps through the sky)
          teal = "#6b8fad",       -- steel blue — types, quieter structural
          sky = "#9fc8e0",        -- pastel blue — sky near moon, info
          sapphire = "#4e7a96",   -- slate blue — constructors, cloud shadows
          blue = "#82b4d4",       -- soft blue — functions, bright sky
          lavender = "#b0c8e8",   -- soft ice — references, moon reflection
          text = "#bdd5e8",       -- ice blue — default text, moon glow
          subtext1 = "#a0b8d0",   -- muted ice — dimmed text
          subtext0 = "#7a9cb8",   -- mid blue — comments, cloud edges
          overlay2 = "#6b8fad",   -- steel blue — line numbers
          overlay1 = "#5a7f9e",   -- mid steel — darker UI chrome
          overlay0 = "#4e7a96",   -- slate blue — darkest chrome
          surface2 = "#3d5f7a",   -- dark steel — selections, borders
          surface1 = "#253548",   -- night blue — subtle UI separators
          surface0 = "#1b2838",   -- dark navy — input backgrounds
          base = "#141c2b",       -- deep navy — main background
          mantle = "#121928",     -- deeper navy — sidebars, below base
          crust = "#0e1420",      -- darkest navy — bottommost layer
        },
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
