-- colorschemes
return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'catppuccin'
      vim.cmd.hi 'Comment gui=none'
    end,
    opts = {
      transparent_background = false,
      show_end_of_buffer = true,
      flavour = 'macchiato', -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = 'latte',
        dark = 'macchiato',
      },
      styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { 'italic' }, -- Change the style of comments
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        neotree = true,
        treesitter = true,
        notify = false,
        dashboard = true,
        flash = true,
        leap = true,
        noice = true,
        -- :TODO: activate when configuring dap
        dap = false,
        dap_ui = false,
        treesitter_context = true,
        lsp_trouble = true,
        which_key = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { 'italic' },
            hints = { 'italic' },
            warnings = { 'italic' },
            information = { 'italic' },
            ok = { 'italic' },
          },
          underlines = {
            errors = { 'underline' },
            hints = { 'underline' },
            warnings = { 'underline' },
            information = { 'underline' },
            ok = { 'underline' },
          },
          inlay_hints = {
            background = true,
          },
        },
        mini = {
          enabled = true,
          indentscope_color = 'blue',
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
    },
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    -- init = function()
    --   vim.cmd.colorscheme 'tokyionight'
    --   vim.cmd.hi 'Comment gui=none'
    -- end,
    opts = {
      transparent = true,
      style = 'night',
      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
      },
    },
  },
}
