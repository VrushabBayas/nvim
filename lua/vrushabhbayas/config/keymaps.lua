-- ~/.config/nvim/lua/vrushabhbayas/config/keymaps.lua
-- Professional Neovim keymaps configuration

-- Ensure leader key is set (backup in case init.lua timing issues)
vim.g.mapleader = " "

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- General keymaps
map("n", "<leader><CR>", function()
  -- Clear loaded modules to force reload
  for name, _ in pairs(package.loaded) do
    if name:match("^vrushabhbayas") then
      package.loaded[name] = nil
    end
  end
  -- Reload the config
  vim.cmd("source ~/.config/nvim/init.lua")
  vim.notify("Config reloaded!", vim.log.levels.INFO)
end, { desc = "Reload config" })
map("n", "<leader>w", ":w<CR>", opts)
map("n", "<leader>/", ":nohlsearch<CR>", opts)
map("n", "<leader>q", ":q<CR>", opts)

-- Better scrolling with centered cursor
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- Buffer navigation
map("n", "<leader><leader>", "<C-^>", opts)

-- System clipboard integration
map("n", "<leader>Y", 'gg"+yG', opts)
map("n", "<leader>y", '"+y', opts)
map("v", "<leader>y", '"+y', opts)
map("v", "<leader>p", '"_dP', opts)

-- Text manipulation
map("n", "<leader>d", ":t.<CR>", opts)
map("n", "<leader>A", "ggVG", opts)
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Window navigation
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Diagnostics
map("n", "<leader>r", vim.diagnostic.open_float, opts)
map("n", "[d", vim.diagnostic.goto_prev, opts)
map("n", "]d", vim.diagnostic.goto_next, opts)
map("n", "<leader>dl", vim.diagnostic.setloclist, opts)

-- Development utilities
map("n", "<leader>l", ":let @z = expand('<cword>')<CR>oconsole.log('[log]<C-r>z:', <C-r>z)<Esc>", {})

-- Auto-imports and import management
map("n", "<leader>io", function()
  vim.lsp.buf.code_action({
    filter = function(code_action)
      return code_action.title:match("Organize Imports") or code_action.title:match("Sort Imports")
    end,
    apply = true,
  })
end, { desc = "Organize imports" })

map("n", "<leader>ai", function()
  vim.lsp.buf.code_action({
    filter = function(code_action)
      return code_action.title:match("Add missing import") or code_action.title:match("Import") or code_action.title:match("Update import")
    end,
    apply = true,
  })
end, { desc = "Add missing imports" })

map("n", "<leader>ri", function()
  vim.lsp.buf.code_action({
    filter = function(code_action)
      return code_action.title:match("Remove unused") or code_action.title:match("unused import")
    end,
    apply = true,
  })
end, { desc = "Remove unused imports" })

map("n", "<leader>ui", function()
  vim.lsp.buf.code_action({
    filter = function(code_action)
      return code_action.title:match("Update import") or code_action.title:match("Fix import")
    end,
    apply = true,
  })
end, { desc = "Update imports" })

-- Better indenting
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Neo-tree keybindings handled by plugin configuration

-- Telescope keybindings (restored with custom configurations)
map("n", "<leader>ff", function()
  require("telescope.builtin").find_files({
    find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "--exclude", "node_modules", "--exclude", ".git" }
  })
end, { desc = "Find files" })

map("n", "<leader>fg", function()
  require("telescope.builtin").live_grep({
    additional_args = function()
      return {
        "--glob", "!node_modules/**",
        "--glob", "!.git/**",
        "--glob", "!package-lock.json"
      }
    end,
  })
end, { desc = "Live grep" })

map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
map("n", "<C-p>", "<cmd>Telescope git_files<cr>", { desc = "Git files" })
map("n", "<leader>pf", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })

-- Testing keybindings (vim-test integration)
map("n", "<leader>tn", "<cmd>TestNearest<CR>", { desc = "Test nearest" })
map("n", "<leader>tf", "<cmd>TestFile<CR>", { desc = "Test file" })
map("n", "<leader>ts", "<cmd>TestSuite<CR>", { desc = "Test suite" })
map("n", "<leader>tl", "<cmd>TestLast<CR>", { desc = "Test last" })
map("n", "<leader>tv", "<cmd>TestVisit<CR>", { desc = "Test visit" })
map("n", "<leader>tw", "<cmd>TestFile --watch<CR>", { desc = "Test file watch mode" })

-- Git workflow keybindings (Fugitive + LazyGit)
map("n", "<leader>gs", "<cmd>Git<cr>", { desc = "Git status" })
map("n", "<leader>gbl", "<cmd>Git blame<cr>", { desc = "Git blame" })
map("n", "<leader>gc", "<cmd>Git commit<cr>", { desc = "Git commit" })
map("n", "<leader>gd", "<cmd>Gvdiffsplit!<cr>", { desc = "Git diff split" })
map("n", "<leader>gb", "<cmd>Git branch<cr>", { desc = "Git branch" })
map("n", "<leader>glg", "<cmd>Git log --oneline --graph --decorate --parents<cr>", { desc = "Git log graph" })
map("n", "<leader>gst", "<cmd>Git stash<cr>", { desc = "Git stash" })
map("n", "<leader>gsa", "<cmd>Git stash apply<cr>", { desc = "Git stash apply" })
map("n", "<leader>gsp", "<cmd>Git stash pop<cr>", { desc = "Git stash pop" })
map("n", "<leader>gaa", "<cmd>Git add .<cr>", { desc = "Git add all" })
map("n", "<leader>gq", "<cmd>diffoff! | only<cr>", { desc = "Quit diff mode" })
map("n", "<leader>z", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

-- File explorer keybinding
map("n", "<leader>pv", ":Vex 50<CR>", { desc = "Vertical explorer" })

-- Additional workflow keybindings for completeness
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
map("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Commands" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
map("n", "<leader>fs", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor" })
map("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })

-- Theme switching keybindings (new feature)
map("n", "<leader>cs", function()
  require("vrushabhbayas.utils.themes").telescope_picker()
end, { desc = "Choose theme" })

map("n", "<leader>cp", function()
  -- Preview current theme info
  local current = vim.g.colors_name or "none"
  local themes = require("vrushabhbayas.utils.themes").themes
  for name, theme in pairs(themes) do
    if theme.cmd:match(current) then
      vim.notify("Current theme: " .. theme.display_name .. " - " .. theme.description, vim.log.levels.INFO)
      return
    end
  end
  vim.notify("Current theme: " .. current, vim.log.levels.INFO)
end, { desc = "Preview current theme" })

map("n", "<leader>cr", function()
  require("vrushabhbayas.utils.themes").random_theme()
end, { desc = "Random theme" })

-- Additional fold keybindings for debugging and usability
map("n", "zc", "zc", { desc = "Close fold under cursor" })
map("n", "zo", "zo", { desc = "Open fold under cursor" })
map("n", "za", "za", { desc = "Toggle fold under cursor" })
map("n", "zC", "zC", { desc = "Close all folds under cursor recursively" })
map("n", "zO", "zO", { desc = "Open all folds under cursor recursively" })
map("n", "zA", "zA", { desc = "Toggle all folds under cursor recursively" })

-- Debug folding status
map("n", "<leader>fd", function()
  local foldenable = vim.opt.foldenable:get()
  local foldmethod = vim.opt.foldmethod:get()
  local foldlevel = vim.opt.foldlevel:get()
  local foldcolumn = vim.opt.foldcolumn:get()
  vim.notify(string.format("Folding: %s, Method: %s, Level: %d, Column: %s", 
    foldenable and "enabled" or "disabled", foldmethod, foldlevel, foldcolumn), vim.log.levels.INFO)
end, { desc = "Debug fold settings" })