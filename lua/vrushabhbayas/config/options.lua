-- ~/.config/nvim/lua/vrushabhbayas/config/options.lua
-- Professional Neovim options configuration

-- UI Settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.cmdheight = 1
vim.opt.laststatus = 3

-- Indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true

-- Search
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Completion
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")

-- Performance
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- File handling
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")

-- Misc
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.showmatch = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Enable code folding - keep all code blocks open by default
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldcolumn = '1'

-- Enable syntax and filetype detection
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

-- Disable unused built-in plugins for better performance
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
-- Keep netrw enabled for default file browser behavior
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
-- vim.g.loaded_netrwSettings = 1
-- vim.g.loaded_netrwFileHandlers = 1