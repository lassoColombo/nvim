return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',

  keys = {
    {
      '<leader><leader>ni',
      '<cmd>InspectTree<CR>',
      mode = 'n',
      desc = '[T]treesitter [I]nspectTree',
    },
  },
  config = function()
    require('nvim-treesitter').install(require 'plugs.treesitter.ensure-installed')
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local ok = pcall(vim.treesitter.start, args.buf)
        if ok then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
