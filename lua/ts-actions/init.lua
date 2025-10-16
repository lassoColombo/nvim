local actions = {
  go = {
    ['literal_value'] = {
      {
        name = 'toggle-multilineness',
        fn = require('ts-actions.go.toggle-multilineness').run,
      },
    },
  },
  javascript = {
    ['object'] = {
      {
        name = 'toggle-multilineness',
        fn = require('ts-actions.javascript.toggle-multilineness').run,
      },
    },
  },
  json = {
    ['object'] = {
      {
        name = 'toggle-multilineness',
        fn = require('ts-actions.json.toggle-multilineness').run,
      },
    },
  },
  python = {
    ['dictionary'] = {
      {
        name = 'toggle-multilineness',
        fn = require('ts-actions.python.toggle-dict-multilineness').run,
      },
    },
    ['list'] = {
      {
        name = 'toggle-multilineness',
        fn = require('ts-actions.python.toggle-list-multilineness').run,
      },
    },
  },
  lua = {
    ['expression_statement'] = {
      {
        name = 'cycle-operator',
        fn = require('ts-actions.global.cycle-operator').run,
      },
    },
    ['table_constructor'] = {
      {
        name = 'toggle-multilineness',
        fn = require('ts-actions.lua.toggle-multilineness').run,
      },
    },
  },
  ['*'] = {
    ['string'] = {
      {
        name = 'cycle-string',
        fn = require('ts-actions.global.cycle-string').run,
      },
    },
    ['true'] = {
      {
        name = 'cycle-bool',
        fn = require('ts-actions.global.cycle-bool').run,
      },
    },
    ['false'] = {
      {
        name = 'cycle-bool',
        fn = require('ts-actions.global.cycle-bool').run,
      },
    },
    ['*'] = {
      {
        name = 'remove-all-comments',
        fn = require('ts-actions.global.remove-all-comments').run,
      },
    },
  },
}

local M = {}

M.setup = function(o)
  local function run_action()
    local ft = vim.bo.filetype
    local bufnr = vim.api.nvim_get_current_buf()

    local ts_utils = require 'nvim-treesitter.ts_utils'
    local node = ts_utils.get_node_at_cursor()

    local node_type = ''
    if node then
      node_type = node:type()
    else
      node_type = '*'
    end

    local ft_actions = (actions[ft] and actions[ft][node_type]) or {}
    local ft_always = (actions[ft] and actions[ft]['*']) or {}

    local global_actions = actions['*'][node_type] or {}
    local global_always = actions['*']['*'] or {}

    local available = {}
    vim.list_extend(available, ft_actions)
    vim.list_extend(available, ft_always)
    vim.list_extend(available, global_actions)
    vim.list_extend(available, global_always)

    if vim.tbl_isempty(available) then
      vim.notify('No ts-actions available for filetype: ' .. ft, vim.log.levels.WARN)
      return
    end

    local names = vim.tbl_map(function(a)
      return a.name
    end, available)

    vim.ui.select(names, { prompt = 'Run ts-action for ' .. ft }, function(choice)
      if not choice then
        return
      end
      for _, action in ipairs(available) do
        if action.name == choice then
          action.fn(ft, bufnr, node)
        end
      end
    end)
  end

  vim.api.nvim_create_user_command('TsActions', run_action, {})
  vim.keymap.set('n', '<leader><leader>a', run_action, { desc = 'Ts-[A]ction' })
end

return M
