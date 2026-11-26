-- mini.files: toggle, yank helpers and the dotfiles filter

local minifiles_toggle = function(...)
  if not MiniFiles.close() then
    MiniFiles.open(...)
  end
end

local copypath = function(manipulation)
  local absolute = (MiniFiles.get_fs_entry() or {}).path
  if absolute == nil then
    return vim.notify 'Cursor is not on valid entry'
  end

  local path = manipulation and vim.fn.fnamemodify(absolute, manipulation) or absolute
  vim.fn.setreg('"', path) -- Neovim unnamed register
  vim.fn.setreg('*', path) -- System clipboard
  vim.notify('Copied: ' .. path)
end

local copyimport = function()
  local absolute = (MiniFiles.get_fs_entry() or {}).path
  if absolute == nil then
    return vim.notify 'Cursor is not on valid entry'
  end
  local relative = vim.fn.fnamemodify(absolute, ':.')
  local noext = vim.fn.fnamemodify(relative, ':r')
  local ext = vim.fn.fnamemodify(absolute, ':e')

  local i = ''
  if ext == 'lua' then
    local p = noext:gsub('^lua/', ''):gsub('/', '.')
    i = "require('" .. p .. "')"
  elseif ext == 'py' then
    local p = noext:gsub('/', '.')
    i = 'import ' .. p
  elseif ext == 'go' then
    i = noext:gsub('/', '.')
  else
    vim.notify('cannot generate import statement for ' .. relative, vim.log.levels.WARN)
    return
  end

  vim.fn.setreg('*', i)
  vim.notify('Copied: ' .. i)
end

local show_dotfiles = true

-- The global filter reads the current choice: `MiniFiles.open` rebuilds its options
-- from `MiniFiles.config`, so the toggle survives closing the explorer.
local filter = function(fs_entry)
  return show_dotfiles or not vim.startswith(fs_entry.name, '.')
end

local toggle_dotfiles = function()
  show_dotfiles = not show_dotfiles
  require 'toggle'('show-dotfiles', show_dotfiles)
  MiniFiles.refresh { content = { filter = filter } }
end

return {
  'nvim-mini/mini.nvim',
  -- statusline and the default explorer (`nvim <dir>`) are needed at startup
  lazy = false,
  keys = {
    { '<leader>e', minifiles_toggle, desc = '[E]xplorer' },
    {
      '<leader><leader><leader>S',
      function()
        vim.b.miniindentscope_disable = not vim.b.miniindentscope_disable
        require 'toggle'('indentscope', not vim.b.miniindentscope_disable)
      end,
      desc = '[T]oggle indent[S]cope',
    },
  },
  config = function()
    require('mini.files').setup { content = { filter = filter } }

    local ai = require 'mini.ai'
    ai.setup {
      n_lines = 500,
      custom_textobjects = {
        o = ai.gen_spec.treesitter({
          a = { '@block.outer', '@conditional.outer', '@loop.outer' },
          i = { '@block.inner', '@conditional.inner', '@loop.inner' },
        }, {}),
        f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
        c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
        t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' },
        d = { '%f[%d]%d+' }, -- digits
        e = { -- Word with case
          {
            '%u[%l%d]+%f[^%l%d]',
            '%f[%S][%l%d]+%f[^%l%d]',
            '%f[%P][%l%d]+%f[^%l%d]',
            '^[%l%d]+%f[^%l%d]',
          },
          '^().*()$',
        },
        g = function() -- Whole buffer, similar to `gg` and 'G' motion
          local from = { line = 1, col = 1 }
          local to = {
            line = vim.fn.line '$',
            col = math.max(vim.fn.getline('$'):len(), 1),
          }
          return { from = from, to = to }
        end,
        u = ai.gen_spec.function_call(), -- u for "Usage"
        U = ai.gen_spec.function_call { name_pattern = '[%w_]' }, -- without dot in function name
      },
    }

    local hipatterns = require 'mini.hipatterns'
    hipatterns.setup {
      highlighters = {
        hex_color = hipatterns.gen_highlighter.hex_color { priority = 2000 },
        shorthand = {
          pattern = '()#%x%x%x()%f[^%x%w]',
          group = function(_, _, data)
            ---@type string
            local match = data.full_match
            local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
            local hex_color = '#' .. r .. r .. g .. g .. b .. b

            return hipatterns.compute_hex_color_group(hex_color, 'bg')
          end,
          extmark_opts = { priority = 2000 },
        },
      },
    }

    require('mini.surround').setup {
      mappings = {
        add = 'ga', -- Add surrounding in Normal and Visual modes
        delete = 'gd', -- Delete surrounding
        replace = 'gr', -- Replace surrounding
        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
      },
    }

    require('mini.pairs').setup()

    require('mini.indentscope').setup {
      symbol = '╎',
      options = { try_as_border = true },
      mappings = {
        -- object_scope = 'ii',
        -- object_scope_with_border = 'ai',
        goto_top = '[s',
        goto_bottom = ']s',
      },
    }

    require('mini.icons').setup()
    -- telescope and diffview ask for nvim-web-devicons: serve them mini.icons
    MiniIcons.mock_nvim_web_devicons()
    require('mini.statusline').setup()

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local b = args.data.buf_id

        local mappings = {
          { key = 'ya', mod = '', desc = 'Yank absolute path' },
          { key = 'yr', mod = ':.', desc = 'Yank path relative to cwd' },
          { key = 'yh', mod = ':h', desc = 'Yank head' },
          { key = 'yt', mod = ':t', desc = 'Yank tail' },
          { key = 'ye', mod = ':e', desc = 'Yank extension' },
          { key = 'y~', mod = ':~', desc = 'Yank path with ~ for home' },
        }

        for _, m in ipairs(mappings) do
          vim.keymap.set('n', m.key, function()
            copypath(m.mod)
          end, { buffer = b, desc = m.desc })
        end

        vim.keymap.set('n', 'yi', copyimport, { buffer = b, desc = 'Yank import statement' })
        vim.keymap.set('n', 'H', toggle_dotfiles, { buffer = b, desc = 'Toggle dotfiles' })
      end,
    })
  end,
}
