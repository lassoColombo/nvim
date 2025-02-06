require('nvim-treesitter.configs').setup {
  textobjects = {
    select = {
      enable = true,
      set_jumps = true,
      lookahead = true,
      keymaps = {
        ['as'] = { query = '@select.outer', desc = 'Select outer part of a SELECT clause' },
        ['is'] = { query = '@select.inner', desc = 'Select inner part of a SELECT clause' },
        ['aw'] = { query = '@where.outer', desc = 'Select outer part of a WHERE clause' },
        ['iw'] = { query = '@where.inner', desc = 'Select inner part of a WHERE clause' },
        ['ag'] = { query = '@groupby.outer', desc = 'Select outer part of a GROUP BY clause' },
        ['ig'] = { query = '@groupby.inner', desc = 'Select inner part of a GROUP BY clause' },
        ['aj'] = { query = '@join.outer', desc = 'Select outer part of a JOIN clause' },
        ['ij'] = { query = '@join.inner', desc = 'Select inner part of a JOIN clause' },
        ['ah'] = { query = '@having.outer', desc = 'Select outer part of a HAVING clause' },
        ['ih'] = { query = '@having.inner', desc = 'Select inner part of a HAVING clause' },
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']s'] = { query = '@select.outer', desc = ']Next [S]ELECT clause' },
        [']w'] = { query = '@where.outer', desc = ']Next [W]HERE clause' },
        [']g'] = { query = '@groupby.outer', desc = ']Next [G]ROUP BY clause' },
        [']j'] = { query = '@join.outer', desc = ']Next [J]OIN clause' },
        [']h'] = { query = '@having.outer', desc = ']Next [H]AVING clause' },
      },
      goto_previous_start = {
        ['[s'] = { query = '@select.outer', desc = '[Prev [S]ELECT clause' },
        ['[w'] = { query = '@where.outer', desc = '[Prev [W]HERE clause' },
        ['[g'] = { query = '@groupby.outer', desc = '[Prev [G]ROUP BY clause' },
        ['[j'] = { query = '@join.outer', desc = '[Prev [J]OIN clause' },
        ['[h'] = { query = '@having.outer', desc = '[Prev [H]AVING clause' },
      },
    },
    swap = {
      enable = false,
    },
  },
}
