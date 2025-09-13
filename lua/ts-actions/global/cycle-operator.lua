local M = {}

local configs = {
  lua = {
    ['+'] = '-',
    ['-'] = '+',
    ['*'] = '/',
    ['/'] = '*',
    ['=='] = '~=',
    ['~='] = '==',
    ['<'] = '>',
    ['>'] = '<',
    ['<='] = '>=',
    ['>='] = '<=',
  },
  python = {
    ['+'] = '-',
    ['-'] = '+',
    ['*'] = '/',
    ['/'] = '*',
    ['%'] = '//',
    ['//'] = '%',
    ['=='] = '!=',
    ['!='] = '==',
    ['<'] = '>',
    ['>'] = '<',
    ['<='] = '>=',
    ['>='] = '<=',
    ['is'] = 'is not',
    ['is not'] = 'is',
    ['in'] = 'not in',
    ['not in'] = 'in',
  },
  go = {
    ['+'] = '-',
    ['-'] = '+',
    ['*'] = '/',
    ['/'] = '*',
    ['%'] = '/',
    ['=='] = '!=',
    ['!='] = '==',
    ['<'] = '>',
    ['>'] = '<',
    ['<='] = '>=',
    ['>='] = '<=',
  },
  javascript = {
    ['+'] = '-',
    ['-'] = '+',
    ['*'] = '/',
    ['/'] = '*',
    ['%'] = '**',
    ['**'] = '%',
    ['=='] = '!=',
    ['!='] = '==',
    ['==='] = '!==',
    ['!=='] = '===',
    ['<'] = '>',
    ['>'] = '<',
    ['<='] = '>=',
    ['>='] = '<=',
  },
  bash = {
    ['+'] = '-',
    ['-'] = '+',
    ['*'] = '/',
    ['/'] = '*',
    ['-eq'] = '-ne',
    ['-ne'] = '-eq',
    ['-lt'] = '-gt',
    ['-gt'] = '-lt',
    ['-le'] = '-ge',
    ['-ge'] = '-le',
  },
  nu = {
    ['+'] = '-',
    ['-'] = '+',
    ['*'] = '/',
    ['/'] = '*',
    ['mod'] = 'div',
    ['div'] = 'mod',
    ['=='] = '!=',
    ['!='] = '==',
    ['<'] = '>',
    ['>'] = '<',
    ['<='] = '>=',
    ['>='] = '<=',
  },
}

-- Helper to find a named child
local function get_child_by_name(node, name)
  for child in node:iter_children() do
    if child:named() and child:type() == name then
      return child
    end
  end
end

M.run = function(ft, bufnr, node)
  local config = configs[ft]
  if not config then
    return vim.notify('No operator config for ' .. ft, vim.log.levels.ERROR)
  end

  -- Get left and right children (assuming binary_expression)
  local left = get_child_by_name(node, 'left')
  local right = get_child_by_name(node, 'right')

  if not left or not right then
    return vim.notify('Could not find left or right child', vim.log.levels.ERROR)
  end

  local left_text = vim.treesitter.get_node_text(left, bufnr)
  local right_text = vim.treesitter.get_node_text(right, bufnr)

  -- Find operator: node text minus left and right
  local node_text = vim.treesitter.get_node_text(node, bufnr)
  if not node_text then
    return vim.notify('Could not get node text', vim.log.levels.ERROR)
  end

  -- Simple approach: remove left and right texts to get operator
  local operator = node_text:gsub('^' .. vim.pesc(left_text), ''):gsub(vim.pesc(right_text) .. '$', ''):gsub('^%s*(.-)%s*$', '%1')

  local replacement_operator = config[operator]

  if not replacement_operator then
    return vim.notify(string.format('[%s] Operator "%s" is not toggleable', ft, operator), vim.log.levels.WARN)
  end

  -- Replace the full expression in the buffer
  local sr, sc, er, ec = node:range()
  local new_expr = left_text .. replacement_operator .. right_text
  vim.notify(replacement_operator, vim.log.levels.INFO)
  vim.api.nvim_buf_set_text(bufnr, sr, sc, er, ec, { new_expr })

  vim.notify(string.format('[%s] Toggled operator: %s → %s', ft, operator, replacement_operator))
end

return M
