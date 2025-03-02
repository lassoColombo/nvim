return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  init = function()
    require('which-key').add {
      {
        mode = { 'n', 'v' },
        { '<leader>f', group = '[F]ormat' },
        { '<leader>f_', hidden = true },
      },
    }
    -- if provided, formats the range
    vim.api.nvim_create_user_command('Format', function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ['end'] = { args.line2, end_line:len() },
        }
      end
      require('conform').format { async = true, lsp_format = 'fallback', range = range }
    end, { range = true })
  end,
  keys = {
    {
      '<space>F',
      '<cmd>ConformInfo<cr>',
      mode = 'n',
      desc = '[F]ormatters [I]nfo',
    },
    {
      '<leader>f',
      '<cmd>Format<cr>',
      mode = { 'n', 'v' },
      desc = '[F]ormat',
    },
    {
      '<leader><leader>f',
      function()
        local log_level = (vim.g.autoformat_on_save and vim.log.levels.WARN or vim.log.levels.INFO)
        vim.g.autoformat_on_save = not vim.g.autoformat_on_save
        vim.notify('set autoformat on save to ' .. tostring(vim.g.autoformat_on_save), log_level)
      end,
      mode = 'n',
      desc = '[T]oggle auto[F]ormat',
    },
  },

  opts = function()
    local opts = {
      notify_on_error = true,
      format_on_save = function(bufnr)
        -- Disable with a global variable
        if not vim.g.autoformat_on_save then
          return
        end
        -- Disable autoformat on certain filetypes
        local ignore_filetypes = { --[[ 'sql' ]]
        }
        if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
          return
        end
        -- Disable autoformat for files in a certain path
        local ignore_paths = { '/node_modules/', '/*venv*/', '/.*venv*/' }
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        for _, path in ipairs(ignore_paths) do
          if bufname:match(path) then
            return
          end
        end
        return { timeout_ms = 500, lsp_fallback = true }
      end,

      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        sql = { 'sqlfmt' },
        mysql = { 'sqlfmt' },
        yaml = { 'prettier' },
        json = { 'prettier' },
        -- Conform can also run multiple formatters sequentially
        go = { 'gofmt', 'goimports' },
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
      },
    }
    -- formatters default configuration
    require('conform').formatters.black = {
      prepend_args = { '--line-length', '160' },
    }
    require('conform').formatters.sqlfmt = {
      prepend_args = { '-l', '20' },
    }
    return opts
  end,
}
