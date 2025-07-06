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

## Essential Commands

### **Configuration Development**
- **Check config health**: `:checkhealth` - Diagnose configuration issues
- **Plugin management**: `:Lazy` - Open lazy.nvim UI for plugin management
- **LSP info**: `:LspInfo` - Show LSP server status and configuration
- **Mason management**: `:Mason` - Manage LSP servers, formatters, and linters
- **Reload config**: `<leader><CR>` - Hot reload entire configuration

### **Lint and Format Commands**
- **Format current buffer**: `<leader>f` - Format using conform.nvim with Prettier/stylua
- **Organize imports**: `<leader>io` - Sort and organize imports (TypeScript/JavaScript)
- **Auto-fix ESLint**: Handled automatically on save via LSP
- **Manual format**: `:lua vim.lsp.buf.format()` - Format via LSP server

### **Testing Commands**
- **Run nearest test**: `<leader>tn` - Execute test under cursor with Jest
- **Run file tests**: `<leader>tf` - Run all tests in current file
- **Run test suite**: `<leader>ts` - Execute entire test suite
- **Test with coverage**: `<leader>tc` - Run tests with coverage report
- **Test last**: `<leader>tl` - Re-run last test command
- **Watch mode**: `<leader>tw` - Watch current file for changes and auto-test

## Plugin Management

Uses **lazy.nvim** as the package manager with professional lazy loading patterns. Plugins are organized by feature:

### **LSP & Language Support** (`plugins/lsp.lua`)
- **nvim-lspconfig**: LSP client configurations
- **mason.nvim**: LSP server manager
- **ts_ls**: TypeScript/JavaScript language server with enhanced import management
- **schemastore**: JSON schema validation for configuration files

### **UI & Interface** (`plugins/ui.lua`)
- **nightfox**: Professional colorscheme
- **lualine**: Status line with git integration
- **neo-tree**: File explorer with comprehensive git status, advanced mappings, and file operations
- **bufferline**: Modern buffer tabs with advanced management
- **fidget**: LSP progress indicators
- **oil.nvim**: Modern file manager (edit filesystem like a buffer)
- **nvim-colorizer**: Live color preview in CSS/config files
- **persistence**: Session management and restoration
- **dressing**: Enhanced UI components
- **noice.nvim**: Modern UI for messages, command line, and popup menu
- **nvim-notify**: Enhanced notification system with timeout and positioning
- **indent-blankline**: Visual indentation guides

### **Editor Enhancement** (`plugins/editor.lua`)
- **telescope**: Fuzzy finder with smart exclusions
- **nvim-treesitter**: Syntax highlighting and text objects
- **nvim-cmp**: Autocompletion with LSP integration
- **flash.nvim**: Enhanced search and navigation with labels
- **harpoon**: Quick file/project navigation
- **todo-comments**: TODO/FIXME/NOTE highlighting and navigation
- **nvim-ts-autotag**: Auto close/rename HTML/JSX tags
- **neodev**: Better Lua development for Neovim configs
- **which-key**: Keybind discovery
- **nvim-surround**: Text object manipulation
- **nvim-autopairs**: Automatic bracket pairing
- **Comment.nvim**: Smart commenting

### **Git Integration** (`plugins/git.lua`)
- **gitsigns**: Git diff indicators and hunk operations
- **vim-fugitive**: Complete Git workflow integration
- **lazygit**: Terminal Git UI
- **diffview**: Enhanced diff and merge conflict resolution

### **Development Tools** (`plugins/coding.lua`)
- **vim-test**: Professional test runner with Jest integration for TypeScript projects
- **github/copilot**: AI code assistance with intelligent suggestions
- **trouble.nvim**: Better diagnostics, quickfix, and location list management
- **conform.nvim**: Modern async formatting with Prettier, stylua, and other formatters
- **nvim-ufo**: Enhanced folding with Treesitter integration
- **nvim-bqf**: Better quickfix list with preview and advanced navigation
- **nvim-spectre**: Project-wide search and replace with live preview
- **rest.nvim**: HTTP client for API testing with syntax highlighting

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
- **Reveal file**: `<leader>E` (reveal current file in Neo-tree)
- **Focus explorer**: `<leader>fe` (focus Neo-tree)
- **Git status explorer**: `<leader>ge` (Neo-tree git status view)
- **Save file**: `<leader>w`
- **Toggle buffers**: `<leader><leader>` (alternate between two buffers)
- **Vertical explorer**: `<leader>pv` (50-column file explorer)
- **Duplicate line**: `<leader>d` (copy current line below)

### Testing (vim-test)
- **Test nearest**: `<leader>tn` (run test under cursor with fast bail-out)
- **Test file**: `<leader>tf` (run all tests in current file with optimized performance)
- **Test suite**: `<leader>ts` (run entire test suite with coverage)
- **Test last**: `<leader>tl` (re-run last test quickly)
- **Watch mode**: `<leader>tw` (watch current file and re-run tests on changes)
- **Coverage**: `<leader>tc` (run tests with coverage report)
- **Visit test**: `<leader>tv` (navigate to corresponding test file)
- **Test runner**: vim-test with high-performance Jest integration, TypeScript support, and smart window sizing
- **Terminal shortcuts**: `q`, `<Esc>`, `<C-c>` to close test window, `r` to re-run last test
- **Auto-features**: Auto-scroll to bottom, auto-close on success (2s delay), responsive window sizing (85-90% height)
- **Performance**: Multi-worker Jest execution, smart caching, bail-out on first failure for individual tests

### Search and Replace
- **Project search**: `<leader>S` (toggle nvim-spectre for project-wide search/replace)
- **Search current word**: Visual select + `<leader>sw` (search selected text)
- **Replace in files**: Use spectre interface for safe bulk replacements
- **Live preview**: See changes before applying them

### Git Integration
- **Git status**: `<leader>gs`
- **LazyGit**: `<leader>z`
- **Git blame**: `<leader>gbl`
- **Git diff**: `<leader>gd`

### LSP Features
- **Go to definition**: `gd`
- **Go to references**: `gr`
- **Go to implementation**: `gI`
- **Go to declaration**: `gD`
- **Type definition**: `<leader>D`
- **Hover documentation**: `K`
- **Rename**: `<leader>rn`
- **Code actions**: `<leader>ca`
- **Format**: `<leader>f`
- **Diagnostics**: `<leader>r` (opens floating window)

### Import Management
- **Organize imports**: `<leader>io` (sort and organize imports)
- **Add missing imports**: `<leader>ai` (auto-import missing dependencies)
- **Remove unused imports**: `<leader>ri` (clean up unused imports)
- **Update imports**: `<leader>ui` (fix import paths)

### Development Utilities
- **Console log**: `<leader>l` (insert console.log for current word)
- **Duplicate line**: `<leader>d` (copy current line below)
- **Select all**: `<leader>A` (select entire file)

### Claude Code Integration
- **Open Claude Code**: `<leader>cc` (open Claude Code in vertical terminal split)
- **Copy file to Claude**: `<leader>cf` (copy current file to clipboard for Claude Code)
- **Copy selection to Claude**: `<leader>cs` (copy visual selection to clipboard for Claude Code)
- **Toggle Claude terminal**: `<leader>cT` (toggle Claude Code vertical terminal window)
- **Horizontal Claude**: `<leader>ch` (open Claude Code in horizontal terminal split)
- **Terminal navigation**: `<C-h/j/k/l>` (navigate between windows from terminal)
- **Quick paste**: `<C-v>` (paste from clipboard in Claude terminal)
- **Exit terminal**: `<Esc>` (exit terminal mode to normal mode)

### Enhanced Navigation
- **Flash jump**: `s` (enhanced search with labeled jumps)
- **Flash treesitter**: `S` (treesitter-aware navigation)
- **Harpoon add**: `<leader>ha` (add current file to harpoon)
- **Harpoon menu**: `<leader>hh` (toggle harpoon quick menu)
- **Quick access**: `<leader>1-4` (jump to harpoon file 1-4)
- **Harpoon prev/next**: `<leader>hp`/`<leader>hn`

### Diagnostics & Trouble
- **Diagnostics**: `<leader>xx` (toggle trouble diagnostics)
- **Buffer diagnostics**: `<leader>xX` (current buffer only)
- **Symbols**: `<leader>cs` (document symbols)
- **LSP info**: `<leader>cl` (LSP definitions/references)
- **TODO comments**: `<leader>xt` (all TODOs in trouble)
- **Next/prev TODO**: `]t`/`[t`

### File Management
- **Oil.nvim**: `-` (edit parent directory as buffer)
- **Oil float**: `<leader>-` (floating oil window)
- **Neo-tree**: `<leader>e` (traditional file explorer)

### Buffer Management
- **Buffer tabs**: Shift+H/L (navigate buffers)
- **Close others**: `<leader>bo` (close other buffers)
- **Pin buffer**: `<leader>bp` (pin/unpin current buffer)

### Session Management
- **Restore session**: `<leader>qs`
- **Last session**: `<leader>ql`
- **Stop saving**: `<leader>qd`

### Modern UI & Notifications (noice.nvim)
- **Command line**: `:` now opens modern floating command interface
- **Message history**: `<leader>snh` (show all message history)
- **All messages**: `<leader>sna` (show all noice messages)
- **Last message**: `<leader>snl` (show last noice message)
- **Dismiss messages**: `<leader>snd` (dismiss all messages)
- **Dismiss notifications**: `<leader>un` (dismiss all nvim-notify notifications)
- **LSP documentation scroll**: `<C-f>`/`<C-b>` (scroll in hover/signature help)
- **Enhanced notifications**: Automatic timeout, better positioning, and styling
- **Command completion**: Modern interface with icons and better visual feedback


### Folding Operations
- **Close fold**: `zc` (close fold under cursor)
- **Open fold**: `zo` (open fold under cursor)
- **Toggle fold**: `za` (toggle fold under cursor)
- **Close all folds**: `zC` (close all folds recursively)
- **Open all folds**: `zO` (open all folds recursively)
- **Toggle all folds**: `zA` (toggle all folds recursively)
- **Enhanced folding**: `zR`/`zM` (ufo.nvim enhanced fold operations)
- **Debug folding**: `<leader>fd` (show current fold settings)

## Language Server Setup

Comprehensive LSP setup in `lua/vrushabhbayas/plugins/lsp.lua` includes:
- **TypeScript/JavaScript**: ts_ls server with enhanced import management
- **ESLint**: With auto-fix on save
- **JSON**: With schema validation (schemastore integration)
- **HTML/CSS**: For web development
- **Emmet**: HTML/JSX completion and snippets (emmet_ls)
- **Markdown**: Marksman language server for documentation
- **Bash**: bashls for shell scripting
- **Lua**: lua_ls with Neovim-specific enhancements

Modern formatting is handled by **conform.nvim** with Prettier, stylua, and other formatters.

## Development Workflow

1. **Opening files**: Use `<leader>ff` for fuzzy finding or `<leader>e` for file explorer
2. **Editing**: LSP provides completion, diagnostics, and formatting with `<leader>f`
3. **Testing**: Use `<leader>tn` for nearest test, `<leader>tf` for file tests, or `<leader>tt` for test summary
4. **Search/Replace**: Use `<leader>S` for project-wide search and replace with live preview
5. **Git workflow**: Use `<leader>z` for LazyGit or individual git commands
6. **Diagnostics**: Use `<leader>r` for floating diagnostics and `K` for hover information
7. **REST API testing**: Use rest.nvim for HTTP requests with syntax highlighting
8. **Claude Code integration**: Use `<leader>cc` to open Claude Code for AI assistance and code review

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

**Complete theme collection with instant switching** - All 10 themes available in `lua/vrushabhbayas/plugins/themes.lua` with utilities in `lua/vrushabhbayas/utils/themes.lua`:

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
- **Modern UI experience**: noice.nvim provides floating command line and enhanced messages
- **Advanced search capabilities**: nvim-spectre for project-wide find and replace
- **Git workflow**: Comprehensive git operations and conflict resolution with LazyGit
- **REST API development**: Built-in HTTP client for testing APIs
- **Enhanced file management**: Oil.nvim for buffer-like directory editing

## Important Notes

### **Which-key Configuration**
- **Delay**: Set to 1000ms to prevent conflicts with rapid keystrokes
- **Expand**: Set to 0 to reduce aggressive partial matching
- **Group support**: Properly configured for noice (`<leader>sn`) and other plugin groups

### **Command Line Experience**
With noice.nvim installed, the command line experience is completely modernized:
- Commands (`:`) appear in floating windows with better styling
- Enhanced message routing and filtering
- Better integration with LSP progress and documentation
- Modern notification system with nvim-notify

## Claude Code Integration Workflow

### **Seamless AI Assistance in Neovim**

This configuration provides integrated Claude Code workflows for AI-powered coding assistance:

### **Quick Start Claude Code Integration:**
1. **Open Claude Code**: `<leader>cc` - Opens Claude Code in a vertical terminal split (80 columns)
2. **Copy current file**: `<leader>cf` - Copies entire file with filename to clipboard
3. **Copy selection**: `<leader>cs` (in visual mode) - Copies selected code with context
4. **Toggle terminal**: `<leader>cT` - Show/hide Claude Code vertical terminal
5. **Horizontal option**: `<leader>ch` - Opens Claude Code in horizontal split (15 lines)

### **Optimal Workflow:**
1. **Code Review**: Select problematic code with visual mode, use `<leader>cs` to copy to clipboard
2. **Paste to Claude**: Switch to terminal (`<leader>cc`), paste with `<C-v>` 
3. **Get suggestions**: Ask Claude Code for improvements, refactoring, or debugging help
4. **Navigate back**: Use `<C-k>` to jump back to your code from terminal
5. **Apply changes**: Copy Claude's suggestions and apply them to your code

### **Terminal Enhancements for Claude Code:**
- **Clean interface**: No line numbers, signs, or distractions in Claude terminal
- **Easy navigation**: `<C-h/j/k/l>` to move between windows without leaving terminal mode
- **Quick clipboard access**: `<C-v>` to paste clipboard content directly
- **Smart exit**: `<Esc>` to exit terminal mode cleanly

### **Best Practices:**
- Use `<leader>cf` to give Claude Code full file context for complex issues
- Use `<leader>cs` for specific code sections you want reviewed
- Keep Claude Code terminal open in split for continuous assistance
- Use `<leader>cT` to quickly show/hide when you need screen space

This integration transforms Claude Code from a separate tool into a seamless coding companion within your Neovim workflow.