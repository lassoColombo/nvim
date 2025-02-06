require('which-key').add {
  {
    { '<Space>', group = '[L]SP' },
    { '<Space>_', hidden = true },
    {
      mode = { 'n', 'v' },
      { '<Space>', group = '[L]SP', mode = { 'n', 'v' } },
      { '<Space>_', hidden = true, mode = { 'n', 'v' } },
    },
  },
}

return {}
