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
    local function attach(buf, ft)
      if vim.treesitter.highlighter.active[buf] then return end
      local lang = vim.treesitter.language.get_lang(ft)
      if not lang then return end
      local ok = pcall(vim.treesitter.start, buf, lang)
      if ok then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args) attach(args.buf, args.match) end,
    })
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype ~= '' then
        attach(buf, vim.bo[buf].filetype)
      end
    end
  end,
}
