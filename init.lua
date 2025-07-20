-- ~/.config/nvim/init.lua
-- Professional Neovim configuration with lazy.nvim
-- Author: Vrushabh Bayas

-- Set leader key before any plugins load
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load configuration
require("vrushabhbayas.config.options")
require("vrushabhbayas.config.keymaps")
require("vrushabhbayas.config.autocmds")

-- Initialize theme system
require("vrushabhbayas.utils.themes").init()

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { import = "vrushabhbayas.plugins" },
  },
  defaults = {
    lazy = true,
    version = false,
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tar",
        "tarPlugin", 
        "zip",
        "zipPlugin",
        "getscript",
        "getscriptPlugin",
        "vimball",
        "vimballPlugin",
        "matchit",
        "matchparen",
        "2html_plugin",
        "logiPat",
        "rrhelper",
        "tohtml",
        "tutor",
        -- Keep netrw enabled for default file browser behavior
        -- "netrw",
        -- "netrwPlugin",
        -- "netrwSettings", 
        -- "netrwFileHandlers",
      },
    },
  },
})