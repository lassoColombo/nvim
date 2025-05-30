return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  build = 'cd app && yarn install',
  init = function()
    vim.g.mkdp_filetypes = { 'markdown' }
  end,
  ft = { 'markdown', 'codecompanion' },
  config = function()
    vim.cmd [[do FileType]]
  end,
  opts = {
    -- set to 1, nvim will open the preview window after entering the Markdown buffer
    mkdp_auto_start = 0,
    -- set to 1, the nvim will auto close current preview window when changing
    -- from Markdown buffer to another buffer
    mkdp_auto_close = 1,
    -- set to 1, Vim will refresh Markdown when saving the buffer or
    -- when leaving insert mode. Default 0 is auto-refresh Markdown as you edit or
    -- move the cursor
    mkdp_refresh_slow = 0,
    -- set to 1, the MarkdownPreview command can be used for all files,
    -- by default it can be use in Markdown files only
    mkdp_command_for_global = 0,
    -- set to 1, the preview server is available to others in your network.
    -- By default, the server listens on localhost (127.0.0.1)
    mkdp_open_to_the_world = 0,
    -- use custom IP to open preview page.
    -- Useful when you work in remote Vim and preview on local browser.
    -- For more details see: https://github.com/iamcco/markdown-preview.nvim/pull/9
    mkdp_open_ip = '',
    -- specify browser to open preview page
    -- for path with space
    -- valid: `/path/with\ space/xxx`
    -- invalid: `/path/with\\ space/xxx`
    mkdp_browser = '',
    -- set to 1, echo preview page URL in command line when opening preview page
    mkdp_echo_preview_url = 0,
    -- a custom Vim function name to open preview page
    -- this function will receive URL as param
    mkdp_browserfunc = '',
    -- options for Markdown rendering
    -- mkit: markdown-it options for rendering
    -- katex: KaTeX options for math
    -- uml: markdown-it-plantuml options
    -- maid: mermaid options
    -- disable_sync_scroll: whether to disable sync scroll, default 0
    -- sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
    --   middle: means the cursor position is always at the middle of the preview page
    --   top: means the Vim top viewport always shows up at the top of the preview page
    --   relative: means the cursor position is always at relative positon of the preview page
    -- hide_yaml_meta: whether to hide YAML metadata, default is 1
    -- sequence_diagrams: js-sequence-diagrams options
    -- content_editable: if enable content editable for preview page, default: v:false
    -- disable_filename: if disable filename header for preview page, default: 0
    mkdp_preview_options = {
      mkit = {},
      katex = {},
      uml = {},
      maid = {},
      disable_sync_scroll = 0,
      sync_scroll_type = 'middle',
      hide_yaml_meta = 1,
      sequence_diagrams = {},
      flowchart_diagrams = {},
      content_editable = false,
      disable_filename = 0,
      toc = {},
    },
    -- use a custom Markdown style. Must be an absolute path
    -- like '/Users/username/markdown.css' or expand('~/markdown.css')
    mkdp_markdown_css = '',
    -- use a custom highlight style. Must be an absolute path
    -- like '/Users/username/highlight.css' or expand('~/highlight.css')
    mkdp_highlight_css = '',
    -- use a custom port to start server or empty for random
    mkdp_port = '',
    -- preview page title
    -- ${name} will be replace with the file name
    mkdp_page_title = '「${name}」',
    -- use a custom location for images
    -- mkdp_images_path = /home/user/.markdown_images,
    -- recognized filetypes
    -- these filetypes will have MarkdownPreview... commands
    mkdp_filetypes = { 'markdown' },
    -- set default theme (dark or light)
    -- By default the theme is defined according to the preferences of the system
    mkdp_theme = 'light',
    -- combine preview window
    -- default: 0
    -- if enable it will reuse previous opened preview window when you preview markdown file.
    -- ensure to set let g:mkdp_auto_close = 0 if you have enable this option
    mkdp_combine_preview = 0,
    -- auto refetch combine preview contents when change markdown buffer
    -- only when g:mkdp_combine_preview is 1
    mkdp_combine_preview_auto_refresh = 1,
  },
}
