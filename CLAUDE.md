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
│           ├── ui.lua               # UI plugins (lualine, neo-tree, themes)
│           ├── editor.lua           # Editor enhancements (telescope, treesitter, cmp)
│           ├── git.lua              # Git integration (gitsigns, fugitive, lazygit)
│           └── coding.lua           # Development tools (testing, debugging, copilot)
└── lazy-lock.json                   # Plugin version lock file
```

## Plugin Management

Uses **lazy.nvim** as the package manager with professional lazy loading patterns. Plugins are organized by feature:

### **LSP & Language Support** (`plugins/lsp.lua`)
- **nvim-lspconfig**: LSP client configurations
- **mason.nvim**: LSP server manager
- **ts_ls**: TypeScript/JavaScript language server with inlay hints
- **none-ls**: ESLint integration and diagnostics
- **schemastore**: JSON schema validation

### **UI & Interface** (`plugins/ui.lua`)
- **nightfox**: Professional colorscheme
- **lualine**: Status line with git integration
- **neo-tree**: File explorer with git status
- **dressing**: Enhanced UI components
- **indent-blankline**: Visual indentation guides

### **Editor Enhancement** (`plugins/editor.lua`)
- **telescope**: Fuzzy finder with smart exclusions
- **nvim-treesitter**: Syntax highlighting and text objects
- **nvim-cmp**: Autocompletion with LSP integration
- **which-key**: Keybind discovery
- **nvim-surround**: Text object manipulation
- **nvim-autopairs**: Automatic bracket pairing

### **Git Integration** (`plugins/git.lua`)
- **gitsigns**: Git diff indicators and hunk operations
- **vim-fugitive**: Complete Git workflow integration
- **lazygit**: Terminal Git UI
- **diffview**: Enhanced diff and merge conflict resolution

### **Development Tools** (`plugins/coding.lua`)
- **vim-test**: Jest test runner with watch mode
- **github/copilot**: AI code assistance
- **nvim-dap**: Debugging support for Node.js/TypeScript
- **nvim-spectre**: Project-wide search and replace
- **rest.nvim**: HTTP client for API testing

### **Plugin Management Commands**
- **:Lazy**: Open lazy.nvim UI for plugin management
- **:Lazy sync**: Update and install plugins
- **:Lazy clean**: Remove unused plugins
- **:Lazy profile**: Performance profiling

## Common Operations

### Configuration Management
- **Reload config**: `<leader><CR>` (sources init.lua)
- **Edit config**: Files are in `~/.config/nvim/`
- **Clear search**: `<leader>/` (remove search highlighting)
- **Quit window**: `<leader>q`

### File Operations
- **Find files**: `<leader>ff` (Telescope with fd, excludes node_modules)
- **Live grep**: `<leader>fg` (Telescope with exclusions)
- **File explorer**: `<leader>e` (toggle Neo-tree)
- **Save file**: `<leader>w`
- **Toggle buffers**: `<leader><leader>` (alternate between two buffers)
- **Vertical explorer**: `<leader>pv` (50-column file explorer)
- **Duplicate line**: `<leader>d` (copy current line below)

### Testing
- **Test nearest**: `<leader>tn` (run test under cursor)
- **Test file**: `<leader>tf` (run all tests in current file)
- **Test suite**: `<leader>ts` (run entire test suite)
- **Test watch mode**: `<leader>tw` (continuous test running)
- **Test runner**: Jest with verbose output configured

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
- **Visual paste**: `<leader>p` (paste without overwriting clipboard)
- **Tab settings**: 2-space indentation with smart indent
- **Cursor line**: Current line highlighting enabled
- **Scrolloff**: 8 lines of context when scrolling

## Theme Management

**Complete theme collection with instant switching** - All 10 themes available in `plugins/themes.lua`:

- **Nightfox** (default) - Professional dark theme with excellent plugin integration
- **Catppuccin Mocha** - Warm, cozy theme with great readability
- **Gruvbox** - Retro groove color scheme with hard contrast
- **Rose Pine Moon** - Natural pine, faux fur and a bit of soho vibes
- **Tokyo Night** - Clean, dark theme inspired by Tokyo's night (multiple variants)
- **OneDark** - Atom's iconic One Dark theme
- **Dracula** - Dark theme with vibrant colors
- **Everforest** - Green based color scheme designed to be warm and soft
- **Oceanic Next** - Sublime Text's Oceanic Next theme
- **Vim One** - Light theme adapted from Atom's One Light

### **Theme Switching Commands:**
- **`<leader>cs`** - Open theme picker (Telescope interface with live preview)
- **`<leader>cp`** - Show current theme info
- **`<leader>cr`** - Switch to random theme
- **`:Theme <name>`** - Switch to specific theme (with tab completion)
- **`:Theme`** - List all available themes

### **Theme Features:**
- **Instant switching** - No restart required
- **Live preview** - See themes before applying in telescope picker
- **Persistent storage** - Remembers your choice across sessions
- **Smart loading** - Only active theme loads (performance optimized)
- **Professional configurations** - Each theme optimized for your plugin setup

## Professional Configuration Patterns

### **Namespace Organization**
- Personal namespace `vrushabhbayas` prevents conflicts
- Clear separation between core config and plugins
- Modular architecture allows easy customization

### **Lazy Loading Strategy**
- **Event-driven loading**: Plugins load on specific events
- **Command-based loading**: UI plugins load on first command
- **Filetype loading**: Language servers load only for relevant files
- **Key-based loading**: Features load when keybinds are used

### **LSP Architecture**
- **Unified on_attach**: Consistent keybindings across all servers
- **Enhanced capabilities**: nvim-cmp integration with LSP
- **Async formatting**: Non-blocking format operations
- **Inlay hints**: TypeScript/JavaScript parameter and type hints
- **Automatic installation**: Mason ensures servers are available

### **Performance Optimizations**
- **Disabled unused plugins**: Removed default Vim plugins
- **Lazy loading by default**: Only loads what's needed
- **Async operations**: Formatting and diagnostics don't block UI
- **Smart file filtering**: Excludes node_modules, .git from searches
- **Bytecode compilation**: lazy.nvim compiles for faster startup

### **Development Workflow Integration**
- **Project-aware configurations**: Different setups for different project types
- **Jest integration**: Optimized for your project's test setup
- **ESLint integration**: Respects your .eslintrc configuration
- **Git workflow**: Comprehensive git operations and conflict resolution
- **Debugging support**: Full DAP setup for Node.js/TypeScript projects