# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Configuration Architecture

This is a professional Neovim configuration using Lua with a namespace-organized modular architecture:

```
~/.config/nvim/
├── init.lua                          # Minimal bootstrap with lazy.nvim setup
├── lua/
│   └── vrushabhbayas/               # Personal namespace
│       ├── config/                  # Core configuration
│       │   ├── options.lua          # Neovim settings and options
│       │   ├── keymaps.lua          # Core key mappings
│       │   └── autocmds.lua         # Auto-commands and events
│       └── plugins/                 # Plugin specifications (lazy-loaded)
│           ├── lsp.lua              # LSP, Mason, formatting & linting
│           ├── ui.lua               # UI module loader (imports all ui/ modules)
│           ├── ui/                  # Modular UI plugin organization
│           │   ├── interface.lua    # Core interface (lualine, bufferline, indent-guides)
│           │   ├── files.lua        # File management (neo-tree, oil.nvim)
│           │   ├── messages.lua     # Messaging/notifications (noice.nvim, nvim-notify)
│           │   └── enhancements.lua # UI utilities (icons, colorizer, persistence, dressing)
│           ├── editor.lua           # Editor enhancements (telescope, treesitter, cmp)
│           ├── git.lua              # Git integration (gitsigns, fugitive, lazygit)
│           ├── coding.lua           # Development tools (testing, debugging, copilot)
│           └── themes.lua           # Theme management and switching
└── lazy-lock.json                   # Plugin version lock file
```

## Essential Commands

### Configuration Development
- **Check config health**: `:checkhealth` - Diagnose configuration issues
- **Plugin management**: `:Lazy` - Open lazy.nvim UI for plugin management
- **LSP info**: `:LspInfo` - Show LSP server status and configuration
- **Mason management**: `:Mason` - Manage LSP servers, formatters, and linters
- **Reload config**: `<leader><CR>` - Hot reload entire configuration

### Testing Commands (vim-test with Jest/pytest)
- **Run nearest test**: `<leader>tn` - Execute test under cursor
- **Run file tests**: `<leader>tf` - Run all tests in current file
- **Run test suite**: `<leader>ts` - Execute entire test suite
- **Test with coverage**: `<leader>tc` - Run tests with coverage report
- **Test last**: `<leader>tl` - Re-run last test command
- **Watch mode**: `<leader>tw` - Watch current file for changes and auto-test

### Lint and Format Commands
- **Format current buffer**: `<leader>lf` - Format using conform.nvim
- **Auto-format on save**: Enabled for supported file types via LSP
- **Organize imports**: `<leader>io` - Sort and organize imports (TypeScript/JavaScript)

## Key Architecture Patterns

### Namespace Organization
All configuration is under the `vrushabhbayas` namespace to prevent conflicts with other Lua modules. This follows Neovim best practices for personal configurations.

### Modular Plugin Architecture
The UI configuration demonstrates excellent modular organization:
- `ui.lua` serves as a loader that imports all UI submodules
- Each UI submodule (`interface.lua`, `files.lua`, etc.) handles specific functionality
- This pattern reduces file sizes and improves maintainability

### Lazy Loading Strategy
Plugins are configured with specific loading triggers:
- **Event-based**: Load on `BufReadPre`, `InsertEnter`, etc.
- **Command-based**: Load when specific commands are invoked
- **Filetype-based**: Load for specific file types only
- **Key-based**: Load when keybindings are pressed

### Theme System Architecture
Complete theme management with:
- Theme definitions in `plugins/themes.lua`
- Utility functions in `utils/themes.lua`
- Persistence in `theme_preference.lua`
- Telescope picker integration for live preview

## Common Development Tasks

### Adding New Plugins
1. Create or modify appropriate file in `lua/vrushabhbayas/plugins/`
2. Follow the lazy.nvim specification format
3. Add appropriate lazy loading configuration
4. Run `:Lazy sync` to install

### Modifying Keymaps
1. Edit `lua/vrushabhbayas/config/keymaps.lua`
2. Follow the existing pattern: `map("mode", "key", "command", { desc = "Description" })`
3. Reload with `<leader><CR>`

### Adding LSP Servers
1. Edit `lua/vrushabhbayas/plugins/lsp.lua`
2. Add server to Mason's `ensure_installed` list
3. Configure server in `servers` table if needed
4. Run `:Mason` to verify installation

### Debugging Configuration Issues
1. Run `:checkhealth` for general diagnostics
2. Check `:messages` for error messages
3. Use `:Lazy profile` to identify slow plugins
4. Review `~/.local/state/nvim/` for logs

## Integration Points

### Claude Code Integration
This configuration has deep Claude Code integration:
- Terminal handling in `autocmds.lua` for optimal Claude Code experience
- Keybindings in `keymaps.lua` for quick access (`<leader>cc`, `<leader>cf`, etc.)
- Custom terminal settings for clean Claude Code interface

### Testing Integration
vim-test is configured with:
- Jest runner for JavaScript/TypeScript projects
- Python test runner for Python projects
- Smart window sizing and auto-close behavior
- Terminal shortcuts for quick test re-runs

### Git Workflow
Comprehensive git integration through:
- Gitsigns for inline git information
- Fugitive for git operations
- LazyGit for visual git interface
- Diffview for advanced diff viewing

## Performance Considerations

1. **Minimal init.lua**: Bootstrap code is kept minimal with deferred loading
2. **Disabled builtins**: Unused Vim plugins are disabled in `lazy.lua` config
3. **Smart search exclusions**: Telescope configured to exclude `node_modules`, `.git`, etc.
4. **Async operations**: Formatting and diagnostics run asynchronously
5. **Bytecode compilation**: Lazy.nvim compiles modules for faster startup