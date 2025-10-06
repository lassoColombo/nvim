local M = {}

M.setup = function(o)
  vim.opt.grepprg = 'rg -i --vimgrep'

  local function Grep(pattern)
    local words = {}
    for w in pattern:gmatch '%S+' do
      table.insert(words, w)
    end

    local cmd = ''
    if #words <= 2 then
      cmd = pattern
    else
      local all_but_last = table.concat(words, ' ', 1, #words - 1)
      local last = words[#words]
      cmd = string.format('%q %s', all_but_last, last)
    end

    local args = vim.opt.grepprg:get() .. ' ' .. vim.fn.expandcmd(cmd)
    return vim.fn.systemlist(args)
  end

  vim.api.nvim_create_user_command('Grep', function(opts)
    local results = Grep(table.concat(opts.fargs, ' '))
    vim.cmd('cgetexpr ' .. vim.fn.string(results))
  end, { nargs = '+', complete = 'file_in_path' })

  vim.api.nvim_create_user_command('LGrep', function(opts)
    local results = Grep(table.concat(opts.fargs, ' '))
    vim.cmd('lgetexpr ' .. vim.fn.string(results))
  end, { nargs = '+', complete = 'file_in_path' })

  local qf_group = vim.api.nvim_create_augroup('quickfix', { clear = true })

  vim.api.nvim_create_autocmd('QuickFixCmdPost', {
    group = qf_group,
    pattern = 'cgetexpr',
    callback = function()
      vim.cmd 'cwindow'
    end,
  })

  vim.api.nvim_create_autocmd('QuickFixCmdPost', {
    group = qf_group,
    pattern = 'lgetexpr',
    callback = function()
      vim.cmd 'lwindow'
    end,
  })

  vim.cmd [[
cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'
]]

  vim.keymap.set('n', '<leader><leader>g', ':Grep ', { desc = '[]Clear' })
end

return M
