vim.g.mapleader = " "
-- ~/.config/nvim/lua/keymaps.lua
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<leader><CR>", ":source ~/.config/nvim/init.lua<CR>", opts)
map("n", "<leader>w", ":w<CR>", opts)
map("n", "<leader>q", ":q<CR>", opts)
map("n", "<leader>pv", ":Vex 20<CR>")
-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
map("n", "<C-p>", ":GFiles<CR>")
map("n", "<leader>pf", ":Files<CR>")
map("n", "<leader>fh", ":Telescope help_tags<CR>")

-- Git
map("n", "<leader>gs", "<cmd>Git<cr>", opts)
map("n", "<leader>gb", "<cmd>Git branch<cr>", opts)
map("n", "<leader>gl", "<cmd>Git log --oneline --graph --decorate<cr>", opts)
map("n", "<leader>gst", ":Git stash<CR>")
map("n", "<leader>gsa", ":Git stash apply<CR>")
map("n", "<leader>gsp", ":Git stash pop<CR>")
map("n", "<leader>gc", ":Git commit<CR>")
map("n", "<leader>ga", ":Git add .<CR>")


