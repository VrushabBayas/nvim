-- ~/.config/nvim/lua/keymaps.lua

vim.g.mapleader = " "  -- Set leader key early

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- General
-- Reload the Neovim config file (~/.config/nvim/init.lua)
map("n", "<leader><CR>", ":source ~/.config/nvim/init.lua<CR>", opts)

-- Save the current buffer
map("n", "<leader>w", ":w<CR>", opts)

-- Quit the current window
map("n", "<leader>q", ":q<CR>", opts)

-- Switch to the alternate file (toggle between two buffers)
map("n", "<leader><leader>", "<C-^>", opts)

-- Open a vertical split file explorer (20 columns wide)
map("n", "<leader>pv", ":Vex 50<CR>", opts)

-- Yank (copy) the entire file into the system clipboard
map("n", "<leader>Y", 'gg"+yG', opts)

-- Yank (copy) the selected text into the system clipboard (normal mode)
map("n", "<leader>y", '"+y', opts)

-- Paste over selection without overwriting the clipboard (visual mode)
map("v", "<leader>p", '"_dP', opts)

-- Duplicate the current line by copying it below
map("n", "<leader>d", ":t.<CR>", opts)

-- Show diagnostics in a floating window at cursor position
--map("n", "<leader>r", vim.diagnostic.open_float, opts)

-- Select the entire buffer (similar to Ctrl+A in other editors)
map("n", "<leader>A", "ggVG", opts)

-- Yank word under cursor into @z and print with console.log
map("n", "<leader>l", ":let @z = expand('<cword>')<CR>oconsole.log('[log]<C-r>z:', <C-r>z)<Esc>", {})

-- Move lines up/down
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)
-- Telescope
map("n", "<leader>ff", function()
  require("telescope.builtin").find_files({
    find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "--exclude", "node_modules", "--exclude", ".git" }
  })
end, opts)
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
end, opts)

--map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
--map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
map("n", "<C-p>", "<cmd>GFiles<cr>", opts)
map("n", "<leader>pf", "<cmd>Files<cr>", opts)
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)

-- Git
map("n", "<leader>gb", "<cmd>Git branch<cr>", opts)
map("n", "<leader>glg", "<cmd>Git log --oneline --graph --decorate --parents<cr>", opts)
map("n", "<leader>gst", "<cmd>Git stash<cr>", opts)
map("n", "<leader>gsa", "<cmd>Git stash apply<cr>", opts)
map("n", "<leader>gsp", "<cmd>Git stash pop<cr>", opts)
map("n", "<leader>gaa", "<cmd>Git add .<cr>", opts)

map("n", "<leader>z", "<cmd>LazyGit<cr>",  vim.tbl_extend("force", opts, { desc = "LazyGit: Open Lazy git" }))

map("n", "<leader>gs", "<cmd>Git<cr>", vim.tbl_extend("force", opts, { desc = "Git: Status" }))
map("n", "<leader>gbl", "<cmd>Git blame<cr>", vim.tbl_extend("force", opts, { desc = "Git: Blame" }))
map("n", "<leader>gc", "<cmd>Git commit<cr>", vim.tbl_extend("force", opts, { desc = "Git: Commit" }))
map("n", "<leader>gd", "<cmd>Gvdiffsplit!<cr>", vim.tbl_extend("force", opts, { desc = "Git: Diff split" }))
map("n", "<leader>gC", "<cmd>GitConflict<cr>", vim.tbl_extend("force", opts, { desc = "Git: Resolve conflict" }))
-- Setup merge conflict resolution helpers
map("n", "<leader>gh", "<cmd>diffget //2<cr>", vim.tbl_extend("force", opts, { desc = "Git: Take LEFT (ours)" }))
map("n", "<leader>gl", "<cmd>diffget //3<cr>", vim.tbl_extend("force", opts, { desc = "Git: Take RIGHT (theirs)" }))
map("n", "<leader>gq", "<cmd>diffoff! | only<cr>", vim.tbl_extend("force", opts, { desc = "Git: Quit diff mode" }))

map("n", "<leader>e", "<cmd>Neotree toggle<CR>", vim.tbl_extend("force", opts, { desc = "Toggle Neo-tree" }))
map("n", "<leader>fe", "<cmd>Neotree focus<CR>", vim.tbl_extend("force", opts, { desc = "Focus Neo-tree" }))
