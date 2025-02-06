return {
  'nvim-neotest/neotest',
  event = 'BufEnter',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    -- adapters
    'nvim-neotest/neotest-go',
    -- 'nvim-neotest/neotest-python',
  },
  opts = {},
  config = function()
    -- :NOTE: Need to define an autocommand to determine the root testing directory
    -- vim.api.nvim_create_autocmd('SetNeoTestingWorkspaceRoot', {
    --   desc = "Sets 'neotesting_root' variable in order to correctly execut workspace tests",
    --   group = vim.api.nvim_create_augroup('SetNeoTestingWorkspaceRoot', { clear = true }),
    --   callback = function()
    --     vim.highlight.on_yank()
    --   end,
    -- })
    --
    -- :NOTE: The below config is optional but recommended if you enabled the diagnostic option of neotest.
    -- Especially testify makes heavy use of tabs and newlines in the error messages,
    -- which reduces the readability of the generated virtual text otherwise.
    -- get neotest namespace (api call creates or returns namespace)
    local neotest_ns = vim.api.nvim_create_namespace 'neotest'
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
          return message
        end,
      },
    }, neotest_ns)

    require('neotest').setup {
      adapters = {
        require 'neotest-go' {
          recursive_run = true,
        },
        -- require 'neotest-python' {},
      },
    }
  end,
  keys = {
    --   {
    --     '=1',
    --     function()
    --       require('neotest').run.run()
    --     end,
    --     mode = 'n',
    --     desc = '=[U]nittest [N]earest',
    --   },
    --   {
    --     '=2',
    --     function()
    --       require('neotest').run.run(vim.fn.expand '%')
    --     end,
    --     mode = 'n',
    --     desc = '=[U]nittest [F]ile',
    --   },
    --   {
    --     '=3',
    --     function()
    --       require('neotest').run.run(vim.fn.getcwd())
    --     end,
    --     mode = 'n',
    --     desc = '=[U]nittest [W]orkspace',
    --   },
    --   {
    --     '=0',
    --     function()
    --       require('neotest').summary.toggle()
    --     end,
    --     mode = 'n',
    --     desc = '=[U]nittest [S]ummary',
    --   },
    --   {
    --     '=-',
    --     function()
    --       require('neotest').output.open { enter = true, auto_close = true }
    --     end,
    --     mode = 'n',
    --     desc = '=[U]nittest [O]utput panel',
    --   },
    --   {
    --     '==',
    --     function()
    --       require('neotest').output_panel.toggle()
    --     end,
    --     mode = 'n',
    --     desc = '=[U]nittest [O]utput window',
    --   },
    --   {
    --     '=w',
    --     function()
    --       require('neotest').watch.toggle()
    --     end,
    --     mode = 'n',
    --     desc = '=[U]nittest [W]atch',
    --   },
    --   {
    --     '=a',
    --     function()
    --       require('neotest').run.attach { interactive = true }
    --     end,
    --     mode = 'n',
    --     desc = '=[U]nittest [A]ttach',
    --   },
    --   {
    --     '=x',
    --     function()
    --       require('neotest').run.stop { interactive = true }
    --     end,
    --     mode = 'n',
    --     desc = '=[U]nittest [X]Abort',
    --   },
  },
}
