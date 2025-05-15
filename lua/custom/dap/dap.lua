-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,
      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},
      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        'debugpy',
        'delve',
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<leader><leader>D', dapui.toggle, { desc = '[T]oggle [D]ebugger ui' })
    vim.keymap.set('n', '<leader>dU', dapui.toggle, { desc = '[]debugger [U]I' })
    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = '[]debugger Continue/start' })
    vim.keymap.set('n', '<leader>di', dap.step_into, { desc = '[]debugger step Into' })
    vim.keymap.set('n', '<leader>do', dap.step_over, { desc = '[]debugger step Over' })
    vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = '[]debugger step Out' })
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = '[]debugger Breakpoint' })
    -- vim.keymap.set('n', '--', dap.toggle_breakpoint, { desc = 'debugger [B]reakpoint' })
    vim.keymap.set('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = '[]debugger conditional Breakpoint' })
    vim.keymap.set('n', '<leader>de', function()
      dapui.eval(nil, { enter = true })
    end, { desc = '[]debugger Eval' })
    vim.keymap.set('n', '<leader>dx', function()
      dap.disconnect { terminateDebuggee = true }
      dap.close()
      dapui.close()
      vim.notify('[]quit debug session', vim.log.levels.WARN)
    end, { desc = 'debugger [Q]uit' })
    vim.keymap.set('n', '<leader>dC', function()
      dap.clear_breakpoints()
      vim.notify('[]clearing dap breakpoints', vim.log.levels.INFO)
    end, { desc = 'debugger [C]lear breakpoints' })
    -- "<cmd>lua require'dap'.disconnect()<CR><cmd>lua require'dap'.close()<CR>",

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
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

    -- laungage specific configs
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
