-- mini.diff is used purely as an inline overlay viewer: gitsigns owns the
-- gutter, staging and blame. Its own visualization is neutralised below so it
-- paints nothing until `MiniDiff.toggle_overlay` is called (the MiniDiffOver*
-- groups used by the overlay are separate and stay intact).
--
-- view.style has no "off" value, so the MiniDiffSign* groups are linked to
-- LineNr instead: with style='number' the number column then renders exactly
-- as it does on an unchanged line. Two things force a real link rather than
-- `{}` or `{ fg = 'NONE' }` re-applied on ColorScheme:
--   * mini.diff defines these with `default = true` (H.create_default_hl), and
--     an empty/NONE-only definition does not count as "already defined", so
--     its Added/Changed/Removed links would win.
--   * catppuccin's mini integration hard-defines them on every colorscheme
--     load, which happens after this file is required.
local neutralise_signs = function()
  for _, group in ipairs { 'MiniDiffSignAdd', 'MiniDiffSignChange', 'MiniDiffSignDelete' } do
    vim.api.nvim_set_hl(0, group, { link = 'LineNr' })
  end
end

-- Overlay colours. mini.diff links MiniDiffOverChangeBuf -> MiniDiffOverChange,
-- so out of the box the changed words in the *old* text and in the *new* text
-- get an identical background and nothing tells you which side you are reading.
-- MiniDiffOverContext also inherits DiffChange, banding the whole reference
-- line and drowning out the words that actually changed.
--
-- Fix: split the two sides by hue -- old/reference in love, new/buffer in pine
-- -- and flatten the context bands so only changed words carry colour. Tints
-- are blended from the live catppuccin palette, which reflects the tinty
-- overrides, so this follows scheme.yaml without a manual re-sync.
local blend = function(fg, bg, alpha)
  local function parts(hex)
    return tonumber(hex:sub(2, 3), 16), tonumber(hex:sub(4, 5), 16), tonumber(hex:sub(6, 7), 16)
  end
  local fr, fg_, fb = parts(fg)
  local br, bg_, bb = parts(bg)
  local mix = function(a, b)
    return math.floor(a * alpha + b * (1 - alpha) + 0.5)
  end
  return string.format('#%02x%02x%02x', mix(fr, br), mix(fg_, bg_), mix(fb, bb))
end

local colour_overlay = function()
  local ok, palette = pcall(function()
    return require('catppuccin.palettes').get_palette 'frappe'
  end)
  if not ok then
    return
  end

  local base, old, new = palette.base, palette.red, palette.green
  local hl = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- old / reference text (rendered as virtual lines): love, dim, italic
  hl('MiniDiffOverContext', { bg = blend(old, base, 0.08), fg = palette.overlay2, italic = true })
  hl('MiniDiffOverChange', { bg = blend(old, base, 0.26), fg = palette.subtext1, italic = true })
  hl('MiniDiffOverDelete', { bg = blend(old, base, 0.2), fg = palette.subtext1, italic = true })

  -- new / buffer text: pine, bright, upright. Context gets no background at all
  -- so your real code is not tinted -- only the changed words are.
  hl('MiniDiffOverContextBuf', {})
  hl('MiniDiffOverChangeBuf', { bg = blend(new, base, 0.34), fg = palette.text })
  hl('MiniDiffOverAdd', { bg = blend(new, base, 0.16) })
end

local apply_hl = function()
  neutralise_signs()
  colour_overlay()
end

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = apply_hl,
  desc = 'mini.diff: hide signs (gitsigns owns the gutter), recolour the overlay',
})
apply_hl()

return {
  view = { style = 'number' },
  mappings = {
    apply = '', -- gitsigns owns staging (<leader>gs)
    reset = '', -- gitsigns owns reset (<leader>gr)
    textobject = 'gh',
    goto_first = '[H',
    goto_prev = '[h',
    goto_next = ']h',
    goto_last = ']H',
  },
}
