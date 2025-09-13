if vim.filetype then
  vim.filetype.add {
    pattern = {
      -- specific ansible dirs
      ['.*/host_vars/.*%.ya?ml'] = 'yaml.ansible',
      ['.*/group_vars/.*%.ya?ml'] = 'yaml.ansible',
      ['.*/tasks/.*%.ya?ml'] = 'yaml.ansible',
      ['.*/playbooks/.*%.ya?ml'] = 'yaml.ansible',
      ['.*/roles/.*/tasks/.*%.ya?ml'] = 'yaml.ansible',
      ['.*/roles/.*/handlers/.*%.ya?ml'] = 'yaml.ansible',

      -- anything with "ansible" in path
      ['.*/[^/]*ansible[^/]*/.*%.ya?ml'] = 'yaml.ansible',
    },
  }
else
  vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = {
      -- dirs
      '*/host_vars/*.yml',
      '*/host_vars/*.yaml',
      '*/group_vars/*.yml',
      '*/group_vars/*.yaml',
      '*/group_vars/*/*.yml',
      '*/group_vars/*/*.yaml',
      '*/tasks/*.yml',
      '*/tasks/*.yaml',
      '*/playbooks/*.yml',
      '*/playbooks/*.yaml',
      '*/roles/*/tasks/*.yml',
      '*/roles/*/tasks/*.yaml',
      '*/roles/*/handlers/*.yml',
      '*/roles/*/handlers/*.yaml',

      -- "ansible" anywhere in path
      '**/*ansible*/**/*.yml',
      '**/*ansible*/**/*.yaml',
    },
    callback = function()
      vim.bo.filetype = 'yaml.ansible'
    end,
  })
end
