-- ~/.config/nvim/lua/plugins/init.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Core
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  "nvim-treesitter/nvim-treesitter",
  "nvim-lualine/lualine.nvim",

  -- LSP & Completion
  "neovim/nvim-lspconfig",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "L3MON4D3/LuaSnip",
  "jose-elias-alvarez/null-ls.nvim",
  { "github/copilot.vim" },
-- status line 
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup()
    end,
  },
   -- JS / TS
  { "pangloss/vim-javascript" },
  { "mxw/vim-jsx" },
  { "prettier/vim-prettier", build = "npm install" },

  -- Lint / Format
  { "dense-analysis/ale" },
  { "sbdchd/neoformat" },

  -- Git
   {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gwrite" },
    config = function()
      require("config.fugitive")
    end,
  },
  require("plugins.lazygit"),
  "lewis6991/gitsigns.nvim",
  --"kdheepak/lazygit.nvim",
  -- Themes
  { "morhetz/gruvbox" },
  { "navarasu/onedark.nvim" },
  { "folke/tokyonight.nvim" },
  { "rakr/vim-one" },
  { "nyoom-engineering/oxocarbon.nvim" },
  { "ayu-theme/ayu-vim" },
  { "dracula/vim", name = "dracula" },
  { "sainnhe/everforest" },
  { "EdenEast/nightfox.nvim" },
  { "mhartington/oceanic-next" },
  { "catppuccin/nvim", name = "catppuccin" },
  { "olimorris/onedarkpro.nvim" },

  -- Productivity
  "ThePrimeagen/vim-be-good",
  { "junegunn/fzf", build = function() vim.fn["fzf#install"]() end },
  { "junegunn/fzf.vim" },
})

