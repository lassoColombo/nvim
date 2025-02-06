return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  lazy = true,
  config = function()
    require('nvim-treesitter.configs').setup {
      textobjects = {
        select = {
          enable = true,
          set_jumps = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['aa'] = { query = '@assignment.outer', desc = 'Select outer part of an assignment' },
            ['ia'] = { query = '@assignment.inner', desc = 'Select inner part of an assignment' },
            ['la'] = { query = '@assignment.lhs', desc = 'Select left hand side of an assignment' },
            ['ra'] = { query = '@assignment.rhs', desc = 'Select right hand side of an assignment' },

            ['ap'] = { query = '@parameter.outer', desc = 'Select outer part of a parameter/argument' },
            ['ip'] = { query = '@parameter.inner', desc = 'Select inner part of a parameter/argument' },

            ['ai'] = { query = '@conditional.outer', desc = 'Select outer part of a conditional' },
            ['ii'] = { query = '@conditional.inner', desc = 'Select inner part of a conditional' },

            ['al'] = { query = '@loop.outer', desc = 'Select outer part of a loop' },
            ['il'] = { query = '@loop.inner', desc = 'Select inner part of a loop' },

            ['af'] = { query = '@call.outer', desc = 'Select outer part of a function call' },
            ['if'] = { query = '@call.inner', desc = 'Select inner part of a function call' },

            ['am'] = { query = '@function.outer', desc = 'Select outer part of a method/function definition' },
            ['im'] = { query = '@function.inner', desc = 'Select inner part of a method/function definition' },

            ['ac'] = { query = '@class.outer', desc = 'Select outer part of a class' },
            ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class' },
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']m'] = { query = '@function.outer', desc = ']Next [M]ethod' },
            [']c'] = { query = '@class.outer', desc = ']Next [C]lass' },
            -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queries.
            [']l'] = { query = '@loop.outer', desc = ']Next [L]oop' },
            -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
            [']i'] = { query = '@conditional.outer', desc = ']Next []Conditional' },
            [']a'] = { query = '@assignment.outer', desc = ']Next []Assignment' },
            [']p'] = { query = '@parameter.outer', desc = ']Next [A]rgument' },
            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
            -- [']s'] = { query = '@local.scope', query_group = 'locals', desc = 'Next scope' },
            -- [']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
          },
          -- goto_next_end = { },
          goto_previous_start = {
            ['[m'] = { query = '@function.outer', desc = ']Prev [M]ethod' },
            ['[c'] = { query = '@class.outer', desc = ']Prev [C]lass' },
            -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queries.
            ['[l'] = { query = '@loop.outer', desc = ']Prev [L]oop' },
            -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
            ['[i'] = { query = '@conditional.outer', desc = ']Prev []Conditional' },
            ['[a'] = { query = '@assignment.outer', desc = ']Prev []Assignment' },
            ['[p'] = { query = '@parameter.outer', desc = ']Prev [A]rgument' },
          },
          -- goto_previous_end = { },
          -- goto_next = { },
          -- goto_previous = { },
        },
        swap = {
          enable = false,
          -- set_jumps = true,
          -- swap_next = {
          --   ['<leader>na'] = '@parameter.inner', -- swap parameters/argument with next
          --   ['<leader>nm'] = '@function.outer', -- swap function with next
          -- },
          -- swap_previous = {
          --   ['<leader>pa'] = '@parameter.inner', -- swap parameters/argument with prev
          --   ['<leader>pm'] = '@function.outer', -- swap function with previous
          -- },
        },
      },
    }
  end,
}
