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
| `mine/` | Custom modules: sessions, filewatch, kubectl, input, usql |

### LSP Server Configs

Individual server configs live in `lua/plugs/lsp/servers/<name>.lua`. Each file returns a table passed directly to `lspconfig.<server>.setup()`. Add a new server by creating a file there and requiring it in `lua/plugs/lsp/lspconfig.lua`.

Currently configured: `pyright`, `ruff`, `gopls`, `rust_analyzer`, `lua_ls`, `jsonls`, `yamlls`, `ansiblels`, `sqls`, `taplo`, `eslint`.

### Snippets

LuaSnip snippets are hand-written in `lua/plugs/cmp/snippets/` organized by language. Each language file returns a list of snippet definitions using helpers from `snippets/utils.lua`.

### Custom Modules (`lua/`)

- `sessions/` — session save/restore
- `filewatch/` — keeps buffers in sync across multiple Neovim instances
- `kubectl/` — kubectl CLI integration
- `input/` — custom vim.ui.input replacement
- `usql/` — keeps the sqls LSP on the connection a query file belongs to (top-level folder of `$USQL_QUERIES` = alias; `:Usql <alias>` / `$USQL_CONNECTION` as session default); aliases are read from the server (`showConnections`), switches go through `switchConnections`

## Key Conventions

- **Shell**: the default (`$SHELL`, zsh). Only `lua/plugs/lsp/servers/sqls.lua` calls `nu` explicitly (`nu -l -c`, which loads env.nu and config.nu so `use sqls-config` resolves).
- **Mason**: Tool/server installation is managed via `mason-tool-installer`. Add tools to the ensure_installed list in `lua/plugs/lsp/lspconfig.lua`.
- **Formatters**: Configured in `lua/plugs/qol/conform.lua` with per-filetype formatter lists. Autoformat on save is enabled globally via `vim.g.autoformat`.
- **Lazy loading**: Plugins specify `event`, `cmd`, or `ft` keys; avoid setting `lazy = false` unless the plugin must be available immediately on startup.
- **`<leader>`**: Space key.
