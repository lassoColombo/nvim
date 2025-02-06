return {
  ['string_content'] = {
    require 'custom.treesitter.node-actions.pythonacts.f-string',
  },
  ['interpolation'] = {
    require 'custom.treesitter.node-actions.pythonacts.f-string',
  },
  ['dictionary'] = {
    require 'custom.treesitter.node-actions.pythonacts.dict.literaldict-to-dictconstructor',
  },
  ['identifier'] = {
    require 'custom.treesitter.node-actions.pythonacts.dict.dictconstructor-to-literaldict',
  },
  ['class_definition'] = {
    require 'custom.treesitter.node-actions.pythonacts.doc.class',
  },
  ['function_definition'] = {
    require 'custom.treesitter.node-actions.pythonacts.doc.method',
  },
}
