-- ~/.config/nvim/lua/vrushabhbayas/config/autocmds.lua
-- Professional Neovim autocmds configuration

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight when yanking text
local highlight_group = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = highlight_group,
  desc = "Highlight when yanking (copying) text",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Whitespace trimming is handled by conform.nvim formatters

-- Import organization is handled by conform.nvim in coding.lua

-- Set specific options for different file types
local filetype_group = augroup("FileTypeSettings", { clear = true })
autocmd("FileType", {
  group = filetype_group,
  desc = "Set specific options for different file types",
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- Close certain filetypes with q
local close_group = augroup("CloseWithQ", { clear = true })
autocmd("FileType", {
  group = close_group,
  desc = "Close certain filetypes with q",
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
  callback = function()
    local map = vim.keymap.set
    map("n", "q", "<cmd>close<cr>", { buffer = true })
  end,
})

-- Resize splits if window got resized
local resize_group = augroup("ResizeSplits", { clear = true })
autocmd("VimResized", {
  group = resize_group,
  desc = "Resize splits if window got resized",
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Go to last location when opening a buffer
local last_loc_group = augroup("LastLocation", { clear = true })
autocmd("BufReadPost", {
  group = last_loc_group,
  desc = "Go to last location when opening a buffer",
  callback = function()
    local exclude = { "gitcommit" }
    local buf = vim.api.nvim_get_current_buf()
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Check if we need to reload the file when it changed
local checktime_group = augroup("CheckTime", { clear = true })
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = checktime_group,
  desc = "Check if we need to reload the file when it changed",
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- Enhanced terminal settings for Claude Code integration
local claude_terminal_group = augroup("ClaudeTerminal", { clear = true })
autocmd("TermOpen", {
  group = claude_terminal_group,
  desc = "Enhanced terminal settings for Claude Code",
  callback = function()
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname:match("claude") then
      -- Optimize for Claude Code terminal
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.signcolumn = "no"
      vim.opt_local.foldcolumn = "0"
      vim.opt_local.scrolloff = 0
      
      -- Easy navigation keymaps for Claude Code terminal
      vim.keymap.set("n", "<Esc>", "<C-\\><C-n>", { buffer = true, desc = "Exit terminal mode" })
      vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { buffer = true, desc = "Move to left window" })
      vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { buffer = true, desc = "Move to lower window" })
      vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { buffer = true, desc = "Move to upper window" })
      vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { buffer = true, desc = "Move to right window" })
      
      -- Quick paste from clipboard
      vim.keymap.set("t", "<C-v>", "<C-\\><C-n>\"+pi", { buffer = true, desc = "Paste from clipboard" })
    end
  end,
})
