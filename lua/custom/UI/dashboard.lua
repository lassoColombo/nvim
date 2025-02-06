return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  opts = function()
    local logo = [[
              __..--''``---....___   _..._    __
    /// //_.-'    .-/";  `        ``<._  ``.''_ `. / // /
   ///_.-' _..--.'_    \                    `( ) ) // //
   / (_..-' // (< _     ;_..__               ; `' / ///
    / // // //  `-._,_)' // / ``--...____..-' /// / // 
    ]]

    logo = string.rep('\n', 4) .. logo .. '\n\n'

    local opts = {
      theme = 'doom',
      hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = false,
      },
      config = {
        header = vim.split(logo, '\n'),
        -- stylua: ignore
        center = {
          { action = "Oil",                                                                           desc = " Oil explorer",     icon = "🛢️ ", key = "o" },
          { action = "ene | startinsert",                                                             desc = " New file",        icon = "📝 ", key = "n" },
          { action = 'lua require("telescope.builtin").find_files()',                                 desc = " Find file",       icon = "🔎 ", key = "f" },
          { action = "Telescope live_grep",                                                           desc = " Find text",       icon = "🕵 ", key = "g" },
          { action = "Telescope oldfiles",                                                            desc = " Recent files",    icon = "🕐 ", key = "r" },
          { action = 'Neotree toggle',                                                                desc = " Toggle Tree",     icon = "🌳 ", key = "t" },
          { action = "LazyGit",                                                                       desc = " LazyGit",         icon = "📌 ", key = "l" },
          { action = 'lua require("telescope.builtin").find_files { cwd = vim.fn.stdpath "config"}',  desc = " Config",          icon = "⚙️ ",  key = "c" },
          { action = 'lua require("persistence").load()',                                             desc = " Restore Session", icon = "🔙 ", key = "s" },
          { action = 'DBUIToggle',                                                                    desc = " DBUI",            icon = "💽 ", key = "d" },
          { action = 'CodeCompanionChat',                                                             desc = " AI Chat",         icon = "💬 ", key = "a" },
          { action = "qa",                                                                            desc = " Quit",            icon = "🚪 ", key = "q" },

        },
        footer = function()
          local stats = require('lazy').stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms' }
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(' ', 43 - #button.desc)
      button.key_format = '  %s'
    end

    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == 'lazy' then
      vim.cmd.close()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'DashboardLoaded',
        callback = function()
          require('lazy').show()
        end,
      })
    end

    return opts
  end,
  keys = {
    {
      '<leader><leader>0',
      '<cmd>Dashboard<cr>',
      mode = 'n',
      desc = '[T]oggle [D]ashboard',
    },
  },
}
