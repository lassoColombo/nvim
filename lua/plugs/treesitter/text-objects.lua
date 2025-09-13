return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  lazy = true,
  event = 'BufEnter',
  config = function()
    require('nvim-treesitter.configs').setup {
      textobjects = {
        select = {
          enable = true,
          set_jumps = true,
          lookahead = true,
          keymaps = {
            ['aa'] = { query = '@assignment.outer', desc = '[A]round [A]ssignment' },
            ['ia'] = { query = '@assignment.inner', desc = '[I]nner [A]ssignment' },
            ['na'] = { query = '@assignment.lhs', desc = '[N]ame (LHS) of [A]ssignment' },
            ['la'] = { query = '@assignment.rhs', desc = '[L]iteral (RHS) of [A]ssignment' },
            ['aA'] = { query = '@attribute.outer', desc = '[A]round [A]ttribute' },
            ['iA'] = { query = '@attribute.inner', desc = '[I]nner [A]ttribute' },
            ['ab'] = { query = '@block.outer', desc = '[A]round [B]lock' },
            ['ib'] = { query = '@block.inner', desc = '[I]nner [B]lock' },
            ['aC'] = { query = '@call.outer', desc = '[A]round [C]all' },
            ['iC'] = { query = '@call.inner', desc = '[I]nner [C]all' },
            ['ac'] = { query = '@class.outer', desc = '[A]round [C]lass' },
            ['ic'] = { query = '@class.inner', desc = '[I]nner [C]lass' },
            ['a-'] = { query = '@comment.outer', desc = '[A]round []Comment' },
            ['i-'] = { query = '@comment.inner', desc = '[I]nner []Comment' },
            ['ai'] = { query = '@conditional.outer', desc = '[A]round [I]f (Conditional)' },
            ['ii'] = { query = '@conditional.inner', desc = '[I]nner [I]f (Conditional)' },
            ['am'] = { query = '@function.outer', desc = '[A]round [M]ethod/[F]unction' },
            ['im'] = { query = '@function.inner', desc = '[I]nner [M]ethod/[F]unction' },
            ['al'] = { query = '@loop.outer', desc = '[A]round [L]oop' },
            ['il'] = { query = '@loop.inner', desc = '[I]nner [L]oop' },
            ['ar'] = { query = '@parameter.outer', desc = '[A]round pa[R]ameter' },
            ['ir'] = { query = '@parameter.inner', desc = '[I]nner pa[R]ameter' },
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']m'] = { query = '@function.outer', desc = ']Next [M]ethod' },
            [']c'] = { query = '@class.outer', desc = ']Next [C]lass' },
            [']l'] = { query = '@loop.outer', desc = ']Next [L]oop' },
            [']i'] = { query = '@conditional.outer', desc = ']Next []Conditional' },
            [']a'] = { query = '@assignment.outer', desc = ']Next []Assignment' },
            [']r'] = { query = '@parameter.outer', desc = ']Next [A]rgument' },
            [']-'] = { query = '@comment.outer', desc = ']Next []comment' },
          },
          goto_previous_start = {
            ['[m'] = { query = '@function.outer', desc = ']Prev [M]ethod' },
            ['[c'] = { query = '@class.outer', desc = ']Prev [C]lass' },
            ['[l'] = { query = '@loop.outer', desc = ']Prev [L]oop' },
            ['[i'] = { query = '@conditional.outer', desc = ']Prev []Conditional' },
            ['[a'] = { query = '@assignment.outer', desc = ']Prev []Assignment' },
            ['[r'] = { query = '@parameter.outer', desc = ']Prev [A]rgument' },
          },
        },
        swap = {
          enable = false,
        },
      },
    }
  end,
}
