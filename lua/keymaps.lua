-- ~/.config/nvim/lua/keymaps.lua

vim.g.mapleader = " "  -- Set leader key early

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- General
map("n", "<leader><CR>", ":source ~/.config/nvim/init.lua<CR>", opts)
map("n", "<leader>w", ":w<CR>", opts)
map("n", "<leader>q", ":q<CR>", opts)
map("n", "<leader><leader>", "<C-^>", opts)
map("n", "<leader>pv", ":Vex 20<CR>", opts)
map("n", "<leader>Y", 'gg"+yG', opts)
map("n", "<leader>y", '"+y', opts)
map("v", "<leader>y", '"+y', opts)
map("v", "<leader>p", '"_dP', opts)
map("n", "<leader>d", ":t.<CR>", opts)

-- Yank word under cursor into @z and print with console.log
map("n", "<leader>l", ":let @z = expand('<cword>')<CR>oconsole.log('[log]<C-r>z:', <C-r>z)<Esc>", {})

-- Move lines up/down
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
map("n", "<C-p>", "<cmd>GFiles<cr>", opts)
map("n", "<leader>pf", "<cmd>Files<cr>", opts)
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)

-- Git
map("n", "<leader>gs", "<cmd>Git<cr>", opts)
map("n", "<leader>gb", "<cmd>Git branch<cr>", opts)
map("n", "<leader>gl", "<cmd>Git log --oneline --graph --decorate --parents<cr>", opts)
map("n", "<leader>gst", "<cmd>Git stash<cr>", opts)
map("n", "<leader>gsa", "<cmd>Git stash apply<cr>", opts)
map("n", "<leader>gsp", "<cmd>Git stash pop<cr>", opts)
map("n", "<leader>gc", "<cmd>Git commit<cr>", opts)
map("n", "<leader>ga", "<cmd>Git add .<cr>", opts)

