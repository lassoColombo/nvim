return {
  settings = {
    gopls = {
      buildFlags = { '-tags=quality' },
      env = {
        GOOS = 'darwin',
      },
    },
  },
}
