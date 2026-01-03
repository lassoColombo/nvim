vim.opt.sessionoptions:remove 'options'

return {
  autoread = true,

  autowrite = true,

  directory = '',

  file = 'Session.vim',

  force = {
    read = true,
    write = true,
    delete = false,
  },

  hooks = {
    pre = {
      read = nil,
      write = nil,
      delete = nil,
    },
    post = {
      read = nil,
      write = nil,
      delete = nil,
    },
  },

  verbose = {
    read = false,
    write = true,
    delete = true,
  },
}
