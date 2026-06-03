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
  keys = {
    -- Breakpoints
    { '<F1>', function() require('dap').toggle_breakpoint() end, desc = 'DAP toggle breakpoint' },
    { '<F2>', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = 'DAP conditional breakpoint' },
    { '<F3>', function() require('dap').clear_breakpoints(); vim.notify('DAP breakpoints cleared', vim.log.levels.INFO) end, desc = 'DAP clear breakpoints' },
    { '<F4>', function() require('dap').run_to_cursor() end, desc = 'DAP run to cursor' },
    -- Session
    { '<F5>', function() require('dap').continue() end, desc = 'DAP continue / start' },
    { '<F6>', function() require('dap').restart() end, desc = 'DAP restart' },
    { '<F7>', function() require('dap').disconnect { terminateDebuggee = true }; require('dap').close(); require('dapui').close(); vim.notify('DAP session quit', vim.log.levels.WARN) end, desc = 'DAP quit session' },
    -- Inspect
    { '<F8>', function() require('dapui').toggle() end, desc = 'DAP toggle UI' },
    { '<F9>', function() require('dapui').eval(nil, { enter = true }) end, desc = 'DAP eval' },
    -- Step
    { '<F10>', function() require('dap').step_over() end, desc = 'DAP step over' },
    { '<F11>', function() require('dap').step_into() end, desc = 'DAP step into' },
    { '<F12>', function() require('dap').step_out() end, desc = 'DAP step out' },
    -- Go test debugging
    { '<leader><leader>r', function() require('dap-go').debug_test() end, ft = 'go', desc = 'DAP Go debug test' },
    { '<leader><leader>t', function() require('dap-go').debug_last_test() end, ft = 'go', desc = 'DAP Go debug last test' },
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

    require('dap-python').setup(require('venv-selector').python())

    table.insert(dap.configurations.python, {
      type = 'python',
      request = 'launch',
      name = 'Django manage.py',
      program = '${workspaceFolder}/manage.py',
      args = function()
        return vim.split(vim.fn.input 'manage.py args: ', ' ')
      end,
      django = true,
      justMyCode = false,
    })

    vim.fn.sign_define('DapBreakpoint', { text = '✋', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '🤞', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapLogPoint', { text = '👇', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '👉', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '🖕', texthl = '', linehl = '', numhl = '' })
  end,
}
