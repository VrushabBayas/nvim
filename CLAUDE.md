# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Configuration Architecture

This is a Neovim configuration using Lua, structured as follows:

- **init.lua**: Main entry point that requires all modules
- **lua/plugins/init.lua**: Plugin manager setup using lazy.nvim with all plugin configurations
- **lua/keymaps.lua**: All key mappings and shortcuts
- **lua/options.lua**: Neovim settings and options
- **lua/lsp/**: LSP configurations
  - **tsserver.lua**: Complete TypeScript/JavaScript LSP setup with multiple language servers
  - **init.lua**: LSP initialization and TreeSitter setup
- **lua/config/**: Plugin-specific configurations
  - **lualine.lua**: Status line configuration
  - **gitsigns.lua**: Git integration
  - **fugitive.lua**: Git workflow setup
- **lua/plugins/**: Individual plugin configurations
  - **neotree.lua**: File explorer setup

## Plugin Management

Uses **lazy.nvim** as the package manager. All plugins are configured in `lua/plugins/init.lua`. Key plugins include:

- **Telescope**: Fuzzy finder
- **Neo-tree**: File explorer
- **TreeSitter**: Syntax highlighting (disabled by default)
- **LSP**: Full language server setup with Mason
- **nvim-cmp**: Autocompletion with LuaSnip
- **vim-test**: Test running with Jest support
- **LazyGit**: Git interface
- **Copilot**: AI assistance

## Common Operations

### Configuration Management
- **Reload config**: `<leader><CR>` (sources init.lua)
- **Edit config**: Files are in `~/.config/nvim/`

### File Operations
- **Find files**: `<leader>ff` (Telescope with fd, excludes node_modules)
- **Live grep**: `<leader>fg` (Telescope with exclusions)
- **File explorer**: `<leader>e` (toggle Neo-tree)
- **Save file**: `<leader>w`

### Testing
- **Test nearest**: `<leader>tn`
- **Test file**: `<leader>tf`
- **Test suite**: `<leader>ts`
- **Test watch mode**: `<leader>tw`

### Git Integration
- **Git status**: `<leader>gs`
- **LazyGit**: `<leader>z`
- **Git blame**: `<leader>gbl`
- **Git diff**: `<leader>gd`

### LSP Features
- **Go to definition**: `gd`
- **Hover documentation**: `K`
- **Rename**: `<space>rn`
- **Code actions**: `<space>ca`
- **Format**: `<space>f`
- **Diagnostics**: `<leader>r` (opens floating window)

## Language Server Setup

Comprehensive LSP setup in `lua/lsp/tsserver.lua` includes:
- **TypeScript/JavaScript**: ts_ls server
- **ESLint**: With auto-fix on save
- **JSON**: With schema validation
- **HTML/CSS**: For web development
- **Tailwind CSS**: For styling
- **Emmet**: For HTML/JSX snippets

Auto-formatting is enabled on save for JS/TS files.

## Development Workflow

1. **Opening files**: Use `<leader>ff` for fuzzy finding or `<leader>e` for file explorer
2. **Editing**: LSP provides completion, diagnostics, and formatting
3. **Testing**: Use `<leader>tn` for nearest test or `<leader>tf` for file tests
4. **Git workflow**: Use `<leader>z` for LazyGit or individual git commands
5. **Debugging**: Use `<leader>r` for diagnostics and `K` for hover information

## Key Customizations

- **Leader key**: Space bar
- **Relative line numbers**: Enabled for easy navigation
- **Auto-format**: On save for JS/TS/CSS files
- **Scrolling**: Centered cursor with `<C-d>` and `<C-u>`
- **Search**: Centered results with `n` and `N`
- **Clipboard**: System clipboard integration with `<leader>y` and `<leader>Y`

## Theme Management

Multiple themes are available but commented out in `lua/options.lua`. Currently using knightfox theme. To change themes, uncomment the desired theme in the options file.