-- ~/.config/nvim/lua/keymaps.lua

vim.g.mapleader = " "  -- Set leader key early

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- General
-- Reload the Neovim config file (~/.config/nvim/init.lua)
map("n", "<leader><CR>", ":source ~/.config/nvim/init.lua<CR>", opts)

-- Save the current buffer
map("n", "<leader>w", ":w<CR>", opts)

-- Clear search highlight
map("n", "<leader>/", ":nohlsearch<CR>", opts)

-- Quit the current window
map("n", "<leader>q", ":q<CR>", opts)

-- Scroll down and center the cursor 
map("n", "<C-d>", "<C-d>zz", opts)

-- Scroll down and center the cursor 
map("n", "<C-u>", "<C-u>zz", opts)  

-- Search next and center the cursor
map("n", "n", "nzzzv", opts)  

-- Search next and center the cursor
map("n", "N", "Nzzzv", opts)  

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
map("n", "<leader>r", vim.diagnostic.open_float, opts)

-- Select the entire buffer (similar to Ctrl+A in other editors)
map("n", "<leader>A", "ggVG", opts)

-- Yank word under cursor into @z and print with console.log
map("n", "<leader>l", ":let @z = expand('<cword>')<CR>oconsole.log('[log]<C-r>z:', <C-r>z)<Esc>", {})

-- Move lines up/down
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- vim-test keymaps
vim.keymap.set("n", "<leader>tn", ":TestNearest<CR>", { desc = "Test nearest" })
vim.keymap.set("n", "<leader>tf", ":TestFile<CR>", { desc = "Test file" })
vim.keymap.set("n", "<leader>ts", ":TestSuite<CR>", { desc = "Test suite" })
vim.keymap.set("n", "<leader>tl", ":TestLast<CR>", { desc = "Test last" })
vim.keymap.set("n", "<leader>tv", ":TestVisit<CR>", { desc = "Test visit" })

-- JS/TS specific - watch mode
vim.keymap.set("n", "<leader>tw", ":TestFile --watch<CR>", { desc = "Test file watch mode" })
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
-- Setup merge conflict resolution helpers
map("n", "<leader>gq", "<cmd>diffoff! | only<cr>", vim.tbl_extend("force", opts, { desc = "Git: Quit diff mode" }))

-- Neo-tree
map("n", "<leader>e", "<cmd>Neotree toggle<CR>", vim.tbl_extend("force", opts, { desc = "Toggle Neo-tree" }))
map("n", "<leader>fe", "<cmd>Neotree focus<CR>", vim.tbl_extend("force", opts, { desc = "Focus Neo-tree" }))

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
