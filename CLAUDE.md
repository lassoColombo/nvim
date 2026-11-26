# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager. The config is written entirely in Lua, with one plugin spec file per concern under `lua/plugs/`.

## Formatting

All Lua code is formatted with **stylua**:
- 2-space indentation
- 160 column width
- Single quotes preferred
- No parentheses on function calls where optional

Run `stylua .` from the repo root, or `stylua lua/path/to/file.lua` from the root for a single file. stylua reads `.stylua.toml` from the working directory only, so running it from a subdirectory formats with its defaults (4 spaces, 80 columns) and breaks lines that the root pass will not rejoin.

## Architecture

### Entry Point

`init.lua` loads the core modules (`opts`, `keys`, `aucmds`), sets up the personal modules (`filewatch`, `sessions`), bootstraps lazy.nvim and calls `require('lazy').setup 'plugs'`, which imports every `lua/plugs/<concern>.lua` (and `lua/plugs/<concern>/init.lua`).

### Core (`lua/`)

| File | Holds |
|------|-------|
| `opts.lua` | Options, disabled builtin plugins, `vim.diagnostic.config` |
| `keys.lua` | Core maps: windows, quickfix, clipboard, diagnostics, LSP (global, they act on whatever client is attached), inlay hints, treesitter inspection, option toggles |
| `aucmds.lua` | Yank highlight, `q` to close helper windows, LSP document highlight |
| `toggle.lua` | The one function every `<leader><leader><leader>` toggle reports its new state through |

### Plugin Specs (`lua/plugs/`)

Each file returns a list of lazy specs for one concern; a file may hold several plugins. A directory is used only when a plugin has private helpers next to its spec (`cmp/` with the snippets), and only its `init.lua` is imported.

| File | Concern |
|------|---------|
| `cmp/` | nvim-cmp, LuaSnip and the hand-written snippets |
| `colorscheme.lua` | catppuccin with the Rose Pine palette (tinty writes between the `tinty:` markers) |
| `dap.lua` | nvim-dap, dap-ui, Go and Python adapters, virtual text, breakpoint jumps |
| `format.lua` | conform.nvim, format on save |
| `git.lua` | gitsigns, diffview |
| `lsp.lua` | lspconfig and the enabled servers, mason, mason-tool-installer, lazydev, none-ls |
| `markdown.lua` | render-markdown, nvim-toc, live-preview |
| `mini.lua` | mini.nvim: files, ai, hipatterns, surround, pairs, indentscope, icons, statusline |
| `python.lua` | venv-selector |
| `quickfix.lua` | nvim-bqf |
| `sql.lua` | sqls.nvim |
| `telescope.lua` | telescope |
| `treesitter.lua` | nvim-treesitter, context, text objects, autotag |
| `whichkey.lua` | which-key |

### LSP Server Configs

Servers are enabled by name in the `vim.lsp.enable { ... }` list in `lua/plugs/lsp.lua` and run on nvim-lspconfig's defaults. A server that needs settings gets `after/lsp/<name>.lua` returning a `vim.lsp.Config` table, which Neovim merges into the server's config. The files live in `after/` because lazy puts the plugins after the config dir on the runtimepath, so nvim-lspconfig's own `lsp/<name>.lua` would win over a top-level `lsp/<name>.lua` on shared keys.

### Snippets

LuaSnip snippets are hand-written in `lua/plugs/cmp/snippets/` and loaded by LuaSnip's Lua loader: `<ft>.lua` or `<ft>/*.lua`, where `<ft>` is the Neovim filetype (`python`, `nu`, `typescript`, ...). Each file returns a list of snippet definitions using helpers from `lua/plugs/cmp/snippet_utils.lua`. Snippets valid in both JS and TS live in `javascript/`, typed ones in `typescript/`; `filetype_extend` in `lua/plugs/cmp/init.lua` gives typescript and both react filetypes the `javascript/` set, and typescriptreact the `typescript/` set too.

### Personal Modules (`lua/`)

Plain Lua modules, not lazy specs. `init.lua` calls `setup()` on the first two, and each `setup()` creates its own keymaps.

- `sessions/` — session save/restore
- `filewatch/` — keeps buffers in sync across multiple Neovim instances
- `kubectl/` — kubectl CLI integration; its maps are buffer-local in `ftplugin/yaml.lua`

sqls follows the `usql` Nushell module's queries dir without a module of its own: `after/lsp/sqls.lua` gives a buffer under `<queries>/<folder>/` its own server (root_dir = the folder) started on one connection, the folder's or `$USQL_CONNECTION`, with the config rendered from `usql -X -c '\cset'` right before the spawn; elsewhere sqls runs bare on its own config.

## Key Conventions

- **Shell**: the default (`$SHELL`, zsh). The only `nu` call is the README generator in `ftplugin/markdown.lua`, which runs `nu -l -c` so the login config puts the module on `NU_LIB_DIRS`.
- **Keymaps**: a plugin's global maps go in its spec's `keys` field; buffer-local maps in an `on_attach` or a ftplugin; core maps in `keys.lua`; a personal module's maps in its `setup()`. Toggles live under `<leader><leader><leader>` and report through `require 'toggle'`.
- **Mason**: `mason-tool-installer` installs every tool on startup. Each spec file declares the tools it uses with a `{ 'WhoIsSethDaniel/mason-tool-installer.nvim', opts_extend = { 'ensure_installed' }, opts = { ensure_installed = { ... } } }` fragment (servers and linters in `lsp.lua`, formatters in `format.lua`, debug adapters in `dap.lua`). Every fragment needs its own `opts_extend`: lazy merges fragments in import order and only sees the `opts_extend` of the fragments merged so far, so without it a later list replaces an earlier one.
- **Formatters**: configured in `lua/plugs/format.lua` with per-filetype formatter lists. Format on save is on by default; `<leader><leader><leader>f` flips a local flag in that file.
- **Lazy loading**: plugins specify `event`, `cmd`, `ft` or `keys`. A spec with `keys` becomes lazy, so a plugin that must run at startup (mini.nvim, telescope) also sets `lazy = false`.
- **`<leader>`**: Space key.
