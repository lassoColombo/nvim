if vim.filetype then
  vim.filetype.add {
    filename = {
      ['docker-compose.yaml'] = 'yaml.docker-compose',
      ['docker-compose.yml'] = 'yaml.docker-compose',
      ['*docker-compose.yaml'] = 'yaml.docker-compose',
      ['*docker-compose.yml'] = 'yaml.docker-compose',
    },
  }
else
  vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = {
      'docker-compose.yaml',
      'docker-compose.yml',
      '*docker-compose.yaml',
      '*docker-compose.yml',
    },
    callback = function()
      vim.bo.filetype = 'yaml.docker-compose'
    end,
  })
end
