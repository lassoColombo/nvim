return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').install 'all'
      local function attach(buf, ft)
        if vim.treesitter.highlighter.active[buf] then
          return
        end
        local lang = vim.treesitter.language.get_lang(ft)
        if not lang then
          return
        end
        local ok = pcall(vim.treesitter.start, buf, lang)
        if ok then
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          attach(args.buf, args.match)
        end,
      })
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype ~= '' then
          attach(buf, vim.bo[buf].filetype)
        end
      end
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'BufEnter',
    keys = {
      {
        '<leader><leader><leader>c',
        function()
          local context = require 'treesitter-context'
          context.toggle()
          require 'toggle'('treesitter context', context.enabled())
        end,
        desc = '[T]oggle [C]ontext',
      },
    },
    opts = {
      on_attach = function(buf) -- return false to disable attaching
        local ft = vim.bo[buf].filetype
        return ft == 'yaml' or ft == 'json'
      end,
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    event = 'VeryLazy',
    config = function()
      require('nvim-treesitter-textobjects').setup {
        select = { lookahead = true, set_jumps = true },
        move = { set_jumps = true },
      }

      local sel = require 'nvim-treesitter-textobjects.select'
      local function s(query)
        return function()
          sel.select_textobject(query, 'textobjects')
        end
      end

      local select_maps = {
        ['aa'] = { '@assignment.outer', '[A]round [A]ssignment' },
        ['ia'] = { '@assignment.inner', '[I]nner [A]ssignment' },
        ['na'] = { '@assignment.lhs', '[N]ame (LHS) of [A]ssignment' },
        ['la'] = { '@assignment.rhs', '[L]iteral (RHS) of [A]ssignment' },
        ['aA'] = { '@attribute.outer', '[A]round [A]ttribute' },
        ['iA'] = { '@attribute.inner', '[I]nner [A]ttribute' },
        ['ab'] = { '@block.outer', '[A]round [B]lock' },
        ['ib'] = { '@block.inner', '[I]nner [B]lock' },
        ['aC'] = { '@call.outer', '[A]round [C]all' },
        ['iC'] = { '@call.inner', '[I]nner [C]all' },
        ['ac'] = { '@class.outer', '[A]round [C]lass' },
        ['ic'] = { '@class.inner', '[I]nner [C]lass' },
        ['a-'] = { '@comment.outer', '[A]round []Comment' },
        ['i-'] = { '@comment.inner', '[I]nner []Comment' },
        ['ai'] = { '@conditional.outer', '[A]round [I]f (Conditional)' },
        ['ii'] = { '@conditional.inner', '[I]nner [I]f (Conditional)' },
        ['am'] = { '@function.outer', '[A]round [M]ethod/[F]unction' },
        ['im'] = { '@function.inner', '[I]nner [M]ethod/[F]unction' },
        ['al'] = { '@loop.outer', '[A]round [L]oop' },
        ['il'] = { '@loop.inner', '[I]nner [L]oop' },
        ['ar'] = { '@parameter.outer', '[A]round pa[R]ameter' },
        ['ir'] = { '@parameter.inner', '[I]nner pa[R]ameter' },
      }

      for lhs, info in pairs(select_maps) do
        vim.keymap.set({ 'x', 'o' }, lhs, s(info[1]), { desc = info[2] })
      end

      local mv = require 'nvim-treesitter-textobjects.move'
      local function ns(query)
        return function()
          mv.goto_next_start(query, 'textobjects')
        end
      end
      local function ps(query)
        return function()
          mv.goto_previous_start(query, 'textobjects')
        end
      end

      vim.keymap.set({ 'n', 'x', 'o' }, ']m', ns '@function.outer', { desc = ']Next [M]ethod' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']c', ns '@class.outer', { desc = ']Next [C]lass' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']l', ns '@loop.outer', { desc = ']Next [L]oop' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']i', ns '@conditional.outer', { desc = ']Next []Conditional' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']a', ns '@assignment.outer', { desc = ']Next []Assignment' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']r', ns '@parameter.outer', { desc = ']Next [A]rgument' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']-', ns '@comment.outer', { desc = ']Next []comment' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[m', ps '@function.outer', { desc = '[Prev [M]ethod' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[c', ps '@class.outer', { desc = '[Prev [C]lass' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[l', ps '@loop.outer', { desc = '[Prev [L]oop' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[i', ps '@conditional.outer', { desc = '[Prev []Conditional' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[a', ps '@assignment.outer', { desc = '[Prev []Assignment' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[r', ps '@parameter.outer', { desc = '[Prev [A]rgument' })
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    opts = {
      opts = { enable_close_on_slash = true },
      aliases = { vue = 'html' },
    },
  },
}
