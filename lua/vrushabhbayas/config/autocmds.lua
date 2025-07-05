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

-- Remove trailing whitespace on save
local trim_group = augroup("TrimWhitespace", { clear = true })
autocmd("BufWritePre", {
  group = trim_group,
  desc = "Remove trailing whitespace on save",
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Auto-organize imports on save for TypeScript/JavaScript files
local organize_imports_group = augroup("OrganizeImports", { clear = true })
autocmd("BufWritePre", {
  group = organize_imports_group,
  desc = "Auto-organize imports on save for TypeScript/JavaScript files",
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })

    for _, client in ipairs(clients) do
      if client.name == "ts_ls" or client.name == "tsserver" then
        local params = {
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(bufnr) },
          title = ""
        }

        -- Use synchronous request for BufWritePre to ensure completion before save
        local success, result = pcall(vim.lsp.buf_request_sync, bufnr, "workspace/executeCommand", params, 1000)

        if success and result then
          -- Import organization completed successfully
          break
        end
      end
    end
  end,
})

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
