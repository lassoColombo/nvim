-- vim.ui.input({ prompt = 'Enter your name: ' }, function(input)
--   if input == nil then
--     print 'User cancelled'
--   else
--     print('Hello, ' .. input .. '!')
--   end
-- end)
--
-- -- vim.ui.select({ 'Apple', 'Banana', 'Cherry' }, {
-- --   prompt = 'Pick a fruit:',
-- --   format_item = function(item)
-- --     return '🍎 ' .. item
-- --   end,
-- -- }, function(choice, idx)
-- --   if choice == nil then
-- --     print 'User cancelled'
-- --   else
-- --     print('You picked ' .. choice .. ' at index ' .. idx)
-- --   end
-- -- end)
-- local o = { a = 1, c = { d = 3 } }
local a = 1 + 2

local function asd()
  local ts_utils = require 'nvim-treesitter.ts_utils'
  local node = ts_utils.get_node_at_cursor()

  local query = vim.treesitter.query.parse(
    'lua',
    [[
    (binary_expression
      left: (_) @left
      right: (_) @right)
  ]]
  )

  local te = ts_utils.get_node_text(node, 0)
  vim.notify(vim.inspect(te), vim.log.levels.INFO)

  for _, match in query:iter_matches(node, 0) do
    local left_node = match[query.captures]
    local right_node = match[query.captures]

    -- local left_text = ts_utils.get_node_text(left_node, 0)
    -- local right_text = ts_utils.get_node_text(right_node, 0)

    vim.notify('Left: ' .. vim.inspect(left_node) .. ' Right: ' .. vim.inspect(right_node))
  end
end

vim.keymap.set('n', '<tab><tab><tab>', asd)
