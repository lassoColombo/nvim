local ls = require 'luasnip'

return {
  s = ls.snippet,
  t = ls.text_node,
  i = ls.insert_node,
  f = ls.function_node,
  c = ls.choice_node,
  rep = require('luasnip.extras').rep,
  fmt = require('luasnip.extras.fmt').fmt,
}
