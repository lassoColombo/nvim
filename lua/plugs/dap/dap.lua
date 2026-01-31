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

    -- F-keys for DAP controls
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'DAP Continue/start' })
    vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'DAP step Over' })
    vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'DAP step Into' })
    vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'DAP step Out' })
    vim.keymap.set('n', '<F9>', dap.toggle_breakpoint, { desc = 'DAP Breakpoint' })
    vim.keymap.set('n', '<F8>', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'DAP conditional Breakpoint' })
    vim.keymap.set('n', '<F7>', function()
      dapui.eval(nil, { enter = true })
    end, { desc = 'DAP Eval' })
    vim.keymap.set('n', '<F6>', function()
      dap.disconnect { terminateDebuggee = true }
      dap.close()
      dapui.close()
      vim.notify('[]quit debug session', vim.log.levels.WARN)
    end, { desc = 'debugger [Q]uit' })
    vim.keymap.set('n', '<F4>', function()
      dap.clear_breakpoints()
      vim.notify('[]clearing dap breakpoints', vim.log.levels.INFO)
    end, { desc = 'debugger [C]lear breakpoints' })
    vim.keymap.set('n', '<F3>', dapui.toggle, { desc = '[T]oggle [D]AP UI' })

    dapui.setup {

      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
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

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    require('nvim-dap-virtual-text').setup()

    require('dap-go').setup {
      delve = {
        detached = true,
      },
    }
    require('dap-python').setup(require('venv-selector').python())

    vim.fn.sign_define('DapBreakpoint', { text = '✋', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '🤞', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapLogPoint', { text = '👇', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '👉', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '🖕', texthl = '', linehl = '', numhl = '' })
  end,
}
