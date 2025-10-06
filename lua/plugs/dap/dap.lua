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

    vim.keymap.set('n', '<leader><leader><leader>D', dapui.toggle, { desc = '[T]oggle [D]AP UI' })
    vim.keymap.set('n', '<bs>c', dap.continue, { desc = 'DAP Continue/start' })
    vim.keymap.set('n', '<bs>i', dap.step_into, { desc = 'DAP step Into' })
    vim.keymap.set('n', '<bs>o', dap.step_over, { desc = 'DAP step Over' })
    vim.keymap.set('n', '<bs>O', dap.step_out, { desc = 'DAP step Out' })
    vim.keymap.set('n', '<bs>b', dap.toggle_breakpoint, { desc = 'DAP Breakpoint' })

    vim.keymap.set('n', '<bs>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'DAP conditional Breakpoint' })
    vim.keymap.set('n', '<bs>e', function()
      dapui.eval(nil, { enter = true })
    end, { desc = 'DAP Eval' })
    vim.keymap.set('n', '<bs>x', function()
      dap.disconnect { terminateDebuggee = true }
      dap.close()
      dapui.close()
      vim.notify('[]quit debug session', vim.log.levels.WARN)
    end, { desc = 'debugger [Q]uit' })
    vim.keymap.set('n', '<bs>C', function()
      dap.clear_breakpoints()
      vim.notify('[]clearing dap breakpoints', vim.log.levels.INFO)
    end, { desc = 'debugger [C]lear breakpoints' })

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
