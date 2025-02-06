require('nvim-treesitter.configs').setup {
  textobjects = {
    select = {
      enable = true,
      set_jumps = true,
      lookahead = true,
      keymaps = {
        ['ah'] = { query = '@heading.outer', desc = 'Select outer part of a heading' },
        ['ih'] = { query = '@heading.inner', desc = 'Select inner part of a heading' },
        ['ap'] = { query = '@paragraph.outer', desc = 'Select outer part of a paragraph' },
        ['ip'] = { query = '@paragraph.inner', desc = 'Select inner part of a paragraph' },
        ['al'] = { query = '@list.outer', desc = 'Select outer part of a list' },
        ['il'] = { query = '@list.inner', desc = 'Select inner part of a list' },
        ['ab'] = { query = '@block.outer', desc = 'Select outer part of a block' },
        ['ib'] = { query = '@block.inner', desc = 'Select inner part of a block' },
        ['ac'] = { query = '@codeblock.outer', desc = 'Select outer part of a code block' },
        ['ic'] = { query = '@codeblock.inner', desc = 'Select inner part of a code block' },
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']h'] = { query = '@heading.outer', desc = ']Next [H]eading' },
        [']p'] = { query = '@paragraph.outer', desc = ']Next [P]aragraph' },
        [']l'] = { query = '@list.outer', desc = ']Next [L]ist' },
        [']b'] = { query = '@block.outer', desc = ']Next [B]lock' },
        [']c'] = { query = '@codeblock.outer', desc = ']Next [C]ode block' },
      },
      goto_previous_start = {
        ['[h'] = { query = '@heading.outer', desc = '[Prev [H]eading' },
        ['[p'] = { query = '@paragraph.outer', desc = '[Prev [P]aragraph' },
        ['[l'] = { query = '@list.outer', desc = '[Prev [L]ist' },
        ['[b'] = { query = '@block.outer', desc = '[Prev [B]lock' },
        ['[c'] = { query = '@codeblock.outer', desc = '[Prev [C]ode block' },
      },
    },
    swap = {
      enable = false,
    },
  },
}
