local ls = require 'luasnip'
local extras = require 'luasnip.extras'

return {
  ls = ls,
  extras = extras,
  s = ls.snippet,
  sn = ls.snippet_node,
  isn = ls.indent_snippet_node,
  t = ls.text_node,
  i = ls.insert_node,
  f = ls.function_node,
  c = ls.choice_node,
  d = ls.dynamic_node,
  r = ls.restore_node,
  events = require 'luasnip.util.events',
  ai = require 'luasnip.nodes.absolute_indexer',
  l = extras.lambda,
  rep = extras.rep,
  p = extras.partial,
  m = extras.match,
  n = extras.nonempty,
  dl = extras.dynamic_lambda,
  fmt = require('luasnip.extras.fmt').fmt,
  fmta = require('luasnip.extras.fmt').fmta,
  conds = require 'luasnip.extras.expand_conditions',
  postfix = require('luasnip.extras.postfix').postfix,
  types = require 'luasnip.util.types',
  parse = require('luasnip.util.parser').parse_snippet,
  ms = ls.multi_snippet,
  k = require('luasnip.nodes.key_indexer').new_key,
  -- :FIXME: there must be a function in the vim stdlib that does that
  concat = function(...)
    local result = {}
    for _, tbl in ipairs { ... } do
      for _, v in ipairs(tbl) do
        table.insert(result, v)
      end
    end

    return result
  end,
}
