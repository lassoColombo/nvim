return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        -- in visual mode conform formats the selection on its own
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = { 'n', 'v' },
      desc = '[F]ormat',
    },
    {
      '<leader><leader><leader>f',
      function()
        local log_level = (vim.g.autoformat_on_save and vim.log.levels.WARN or vim.log.levels.INFO)
        vim.g.autoformat_on_save = not vim.g.autoformat_on_save
        vim.notify('set autoformat on save to ' .. tostring(vim.g.autoformat_on_save), log_level)
      end,
      mode = 'n',
      desc = '[T]oggle auto[F]ormat',
    },
  },

  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      if not vim.g.autoformat_on_save then
        return
      end
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      for _, dir in ipairs { '/node_modules/', 'venv/' } do
        if bufname:find(dir, 1, true) then
          return
        end
      end
      return { timeout_ms = 500, lsp_format = 'fallback' }
    end,

    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
      sql = { 'sqlfmt' },
      mysql = { 'sqlfmt' },
      yaml = { 'prettier' },
      json = { 'prettier' },
      javascript = { 'prettier' },
      javascriptreact = { 'prettier' },
      typescript = { 'prettier' },
      typescriptreact = { 'prettier' },
      vue = { 'prettier' },
      html = { 'prettier' },
      css = { 'prettier' },
      less = { 'prettier' },
      scss = { 'prettier' },
      go = { 'goimports', 'golines' },
      rust = { 'rustfmt' },
      terraform = { 'terraform_fmt' },
      ['terraform-vars'] = { 'terraform_fmt' },
      hcl = { 'terraform_fmt' },
    },

    formatters = {
      sqlfmt = { prepend_args = { '-l', '80' } },
      -- golines defaults to 100 columns and wraps one argument per line: too aggressive for Go.
      golines = { prepend_args = { '--max-len', '125' } },
    },
  },
}
