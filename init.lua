require 'opts'
require 'keys'
require 'aucmds'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  require 'plugs.treesitter',
  require 'plugs.lsp',
  require 'plugs.cmp',
  require 'plugs.mini',
  require 'plugs.mine',
  require 'plugs.lang',
  require 'plugs.qol',
  require 'plugs.dap',
}
