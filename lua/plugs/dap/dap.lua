-- ══════════════════════════════════════════
-- Breakpoints   F1  toggle breakpoint
--               F2  conditional breakpoint
--               F3  clear all breakpoints
--               F4  run to cursor
-- Session       F5  continue / start
--               F6  restart
--               F7  quit session
-- Inspect       F8  toggle UI
--               F9  eval
-- Step          F10 step over
--               F11 step into
--               F12 step out
-- Go            <leader><leader>r  debug test under cursor
--               <leader><leader>t  debug last test
-- ══════════════════════════════════════════

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {},
      ensure_installed = {
        'debugpy',
        'delve',
      },
    }

    -- Breakpoints
    vim.keymap.set('n', '<F1>', dap.toggle_breakpoint, { desc = 'DAP toggle breakpoint' })
    vim.keymap.set('n', '<F2>', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'DAP conditional breakpoint' })
    vim.keymap.set('n', '<F3>', function()
      dap.clear_breakpoints()
      vim.notify('DAP breakpoints cleared', vim.log.levels.INFO)
    end, { desc = 'DAP clear breakpoints' })
    vim.keymap.set('n', '<F4>', dap.run_to_cursor, { desc = 'DAP run to cursor' })

    -- Session
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'DAP continue / start' })
    vim.keymap.set('n', '<F6>', dap.restart, { desc = 'DAP restart' })
    vim.keymap.set('n', '<F7>', function()
      dap.disconnect { terminateDebuggee = true }
      dap.close()
      dapui.close()
      vim.notify('DAP session quit', vim.log.levels.WARN)
    end, { desc = 'DAP quit session' })

    -- Inspect
    vim.keymap.set('n', '<F8>', function()
      dapui.toggle()
    end, { desc = 'DAP toggle UI' })
    vim.keymap.set('n', '<F9>', function()
      ---@diagnostic disable-next-line: missing-fields
      dapui.eval(nil, { enter = true })
    end, { desc = 'DAP eval' })

    -- Step
    vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'DAP step over' })
    vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'DAP step into' })
    vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'DAP step out' })

    ---@diagnostic disable-next-line: missing-fields
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      ---@diagnostic disable-next-line: missing-fields
      controls = {
        icons = {
          pause = '⏸️',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end

    require('dap-go').setup {
      delve = {
        detached = vim.fn.has 'darwin' == 0,
      },
    }

    -- Go test debugging
    vim.keymap.set('n', '<leader><leader>r', require('dap-go').debug_test, { desc = 'DAP Go debug test' })
    vim.keymap.set('n', '<leader><leader>t', require('dap-go').debug_last_test, { desc = 'DAP Go debug last test' })

    require('dap-python').setup(require('venv-selector').python())

    vim.fn.sign_define('DapBreakpoint', { text = '✋', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '🤞', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapLogPoint', { text = '👇', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '👉', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '🖕', texthl = '', linehl = '', numhl = '' })
  end,
}
