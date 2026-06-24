vim.wo.wrap = true

-- Prompt for a Nushell module name (defaulting to the session cwd's basename),
-- generate its `# Commands` section, and drop it in at the cursor. The module
-- must be importable by name (it lives on NU_LIB_DIRS) — `--config`/`--env-config`
-- load that search path, and we `use` it so its commands show up in `scope commands`.
vim.keymap.set('n', '<leader><leader>C', function()
  -- Capture the target buffer/line now; `vim.ui.input` is async, so resolve
  -- where to insert before the prompt steals focus.
  local buf = vim.api.nvim_get_current_buf()
  local row = vim.api.nvim_win_get_cursor(0)[1]

  vim.ui.input({ prompt = 'Module: ', default = vim.fn.fnamemodify(vim.fn.getcwd(), ':t') }, function(module)
    module = vim.trim(module or '')
    if module == '' then
      return
    end

    local result = vim.fn.systemlist {
      'nu',
      '--config',
      vim.fn.expand '~/.config/nushell/config.nu',
      '--env-config',
      vim.fn.expand '~/.config/nushell/env.nu',
      '-c',
      string.format('use %s; use readme-commands-section-generator; readme-commands-section-generator generate %s', module, module),
    }

    if vim.v.shell_error ~= 0 then
      vim.notify(table.concat(result, '\n'), vim.log.levels.ERROR, { title = 'generate-readme-command-section' })
      return
    end

    vim.api.nvim_buf_set_lines(buf, row - 1, row - 1, false, result)
  end)
end, { desc = 'Generate [C]ommands section', buffer = true })
