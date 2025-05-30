return {
  'echasnovski/mini.hipatterns',
  event = 'BufEnter',
  opts = function()
    local hi = require 'mini.hipatterns'
    return {
      highlighters = {
        hex_color = hi.gen_highlighter.hex_color { priority = 2000 },
        shorthand = {
          pattern = '()#%x%x%x()%f[^%x%w]',
          group = function(_, _, data)
            ---@type string
            local match = data.full_match
            local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
            local hex_color = '#' .. r .. r .. g .. g .. b .. b

            return require('mini.hipatterns').compute_hex_color_group(hex_color, 'bg')
          end,
          extmark_opts = { priority = 2000 },
        },
      },
    }
  end,
  keys = {
    {
      '<leader><leader>h',
      function()
        require('mini.hipatterns').toggle()
      end,
      mode = 'n',
      desc = '[T]oggle [H]ighlight patterns',
    },
  },
}
