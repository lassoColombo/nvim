vim.filetype.add {
  pattern = {
    -- specific ansible dirs
    ['.*/host_vars/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/group_vars/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/tasks/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/playbooks/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/roles/.*/handlers/.*%.ya?ml'] = 'yaml.ansible',

    -- anything with "ansible" in path
    ['.*/[^/]*ansible[^/]*/.*%.ya?ml'] = 'yaml.ansible',
  },
}
