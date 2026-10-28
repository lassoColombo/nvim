# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager. The config is written entirely in Lua and organized into modular plugin categories under `lua/plugs/`.

## Formatting

All Lua code is formatted with **stylua**:
- 2-space indentation
- 160 column width
- Single quotes preferred
- No parentheses on function calls where optional

Run: `stylua .` to format everything, or `stylua lua/path/to/file.lua` for a single file.

## Architecture

### Entry Point

`init.lua` loads three global config modules (`opts`, `keys`, `aucmds`), bootstraps lazy.nvim, then imports 8 plugin category modules from `lua/plugs/`.

### Plugin Categories (`lua/plugs/`)

Each category has an `init.lua` that returns a flat list of plugin specs (aggregated from sub-files) for lazy.nvim. Categories:

| Directory | Purpose |
|-----------|---------|
| `treesitter/` | Syntax, text objects, context display |
| `lsp/` | LSP servers, diagnostics, keybindings |
| `cmp/` | Completion engine + LuaSnip snippets |
| `mini/` | mini.nvim modules (files, ai, pairs, statusline, etc.) |
| `qol/` | Telescope, conform, gitsigns, colorscheme, etc. |
| `dap/` | Debug adapter (Python via debugpy, Go via delve) |
| `lang/` | Language-specific extras (markdown, Python venv, SQL) |
| `mine/` | Custom modules: sessions, filewatch, kubectl, usql |

### LSP Server Configs

Individual server configs live in `lua/plugs/lsp/servers/<name>.lua`. Each file returns a `vim.lsp.Config` table. Servers that use lspconfig defaults are listed as `name = {}` directly in `lua/plugs/lsp/lspconfig.lua`; add a file only when the server needs settings.

The full server list is the `servers` table in `lua/plugs/lsp/lspconfig.lua`.

### Snippets

LuaSnip snippets are hand-written in `lua/plugs/cmp/snippets/` and loaded by LuaSnip's Lua loader: `<ft>.lua` or `<ft>/*.lua`, where `<ft>` is the Neovim filetype (`python`, `nu`, `typescript`, ...). Each file returns a list of snippet definitions using helpers from `lua/plugs/cmp/snippet_utils.lua`. Snippets valid in both JS and TS live in `javascript/`, typed ones in `typescript/`; `filetype_extend` in `lua/plugs/cmp/init.lua` gives typescript and both react filetypes the `javascript/` set, and typescriptreact the `typescript/` set too.

### Custom Modules (`lua/`)

- `sessions/` — session save/restore
- `filewatch/` — keeps buffers in sync across multiple Neovim instances
- `kubectl/` — kubectl CLI integration
- `usql/` — keeps the sqls LSP on the connection a query file belongs to (top-level folder of `$USQL_QUERIES` = alias; `:Usql <alias>` / `$USQL_CONNECTION` as session default); aliases are read from the server (`showConnections`), switches go through `switchConnections`

## Key Conventions

- **Shell**: the default (`$SHELL`, zsh). Only `lua/plugs/lsp/servers/sqls.lua` calls `nu` explicitly (`nu -l -c`, which loads env.nu and config.nu so `use sqls-config` resolves).
- **Mason**: Tool/server installation is managed via `mason-tool-installer`. Add tools to the ensure_installed list in `lua/plugs/lsp/lspconfig.lua`.
- **Formatters**: Configured in `lua/plugs/qol/conform.lua` with per-filetype formatter lists. Autoformat on save is enabled globally via `vim.g.autoformat_on_save`.
- **Lazy loading**: Plugins specify `event`, `cmd`, or `ft` keys; avoid setting `lazy = false` unless the plugin must be available immediately on startup.
- **`<leader>`**: Space key.
