return {
  's1n7ax/nvim-window-picker',
  name = 'window-picker',
  event = 'VeryLazy',
  version = '2.*',
  config = function()
    local opts = {
      hint = 'floating-big-letter',
      selection_chars = 'FJDKSLACMRUEIWOQP',
      show_prompt = false,
      highlights = {
        statusline = {
          focused = {
            fg = '#CAD3F5',
            bg = '#8AADF4',
            bold = true,
          },
          unfocused = {
            fg = '#CAD3F5',
            bg = '#8AADF4',
            bold = false,
          },
        },
        winbar = {
          focused = {
            fg = '#CAD3F5',
            bg = '#8AADF4',
            bold = true,
          },
          unfocused = {
            fg = '#CAD3F5',
            bg = '#8AADF4',
            bold = false,
          },
        },
      },
    }
    require('window-picker').setup(opts)
  end,
}
