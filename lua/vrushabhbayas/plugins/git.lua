-- ~/.config/nvim/lua/vrushabhbayas/plugins/git.lua
-- Professional Git integration plugins

return {
  -- Git signs in the gutter
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        on_attach = function(bufnr)
          local gitsigns = require("gitsigns")

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gitsigns.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gitsigns.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          -- Actions
          map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
          map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })
          map("v", "<leader>hs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Stage hunk" })
          map("v", "<leader>hr", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Reset hunk" })
          map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
          map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
          map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })
          map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })
          map("n", "<leader>hb", function()
            gitsigns.blame_line({ full = true })
          end, { desc = "Blame line" })
          map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle current line blame" })
          map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff this" })
          map("n", "<leader>hD", function()
            gitsigns.diffthis("~")
          end, { desc = "Diff this ~" })
          map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "Toggle deleted" })

          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "GitSigns select hunk" })
        end,
      })
    end,
  },

  -- Fugitive for Git commands
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse", "GRemove", "GRename", "Glgrep", "Gedit" },
    ft = { "fugitive" },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
      { "<leader>gbl", "<cmd>Git blame<cr>", desc = "Git blame" },
      { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
      { "<leader>gd", "<cmd>Gvdiffsplit!<cr>", desc = "Git diff split" },
      { "<leader>gB", "<cmd>Git branch<cr>", desc = "Git branch" },
      { "<leader>glg", "<cmd>Git log --oneline --graph --decorate --parents<cr>", desc = "Git log graph" },
      { "<leader>gst", "<cmd>Git stash<cr>", desc = "Git stash" },
      { "<leader>gsa", "<cmd>Git stash apply<cr>", desc = "Git stash apply" },
      { "<leader>gsp", "<cmd>Git stash pop<cr>", desc = "Git stash pop" },
      { "<leader>gaa", "<cmd>Git add .<cr>", desc = "Git add all" },
      { "<leader>gq", "<cmd>diffoff! | only<cr>", desc = "Quit diff mode" },
    },
    config = function()
      -- Create a custom command for better merge conflict resolution
      vim.cmd([[
        command! -nargs=0 Gqf call setqflist(map(systemlist("git diff --name-only --diff-filter=U"), '{"filename":v:val,"lnum":1}'))
      ]])

      -- Set up autocmds for fugitive
      local fugitive_group = vim.api.nvim_create_augroup("FugitiveCustom", { clear = true })
      vim.api.nvim_create_autocmd("BufWinEnter", {
        group = fugitive_group,
        pattern = "*",
        callback = function()
          if vim.bo.ft ~= "fugitive" then
            return
          end
          local map = vim.keymap.set
          local bufnr = vim.api.nvim_get_current_buf()
          local opts = { buffer = bufnr, remap = false }
          map("n", "<leader>p", function()
            vim.cmd.Git("push")
          end, opts)
          map("n", "<leader>P", function()
            vim.cmd.Git({ "pull", "--rebase" })
          end, opts)
          map("n", "<leader>t", ":Git push -u origin ", opts)
        end,
      })
    end,
  },

  -- LazyGit integration
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    keys = {
      { "<leader>z", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      -- Configure LazyGit to work with Neovim
      vim.g.lazygit_floating_window_winblend = 0
      vim.g.lazygit_floating_window_scaling_factor = 0.9
      vim.g.lazygit_floating_window_corner_chars = { "╭", "╮", "╰", "╯" }
      vim.g.lazygit_floating_window_use_plenary = 0
      vim.g.lazygit_use_neovim_remote = 1
      vim.g.lazygit_use_custom_config_file_path = 0
    end,
  },

  -- Enhanced git diff viewing
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    keys = {
      { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Open diffview" },
      { "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "Close diffview" },
      { "<leader>gdh", "<cmd>DiffviewFileHistory<cr>", desc = "File history" },
    },
    config = function()
      require("diffview").setup({
        diff_binaries = false,
        enhanced_diff_hl = false,
        git_cmd = { "git" },
        use_icons = true,
        watch_index = true,
        icons = {
          folder_closed = "",
          folder_open = "",
        },
        signs = {
          fold_closed = "",
          fold_open = "",
          done = "✓",
        },
        view = {
          default = {
            layout = "diff2_horizontal",
            winbar_info = false,
          },
          merge_tool = {
            layout = "diff3_horizontal",
            disable_diagnostics = true,
            winbar_info = true,
          },
          file_history = {
            layout = "diff2_horizontal",
            winbar_info = false,
          },
        },
        file_panel = {
          listing_style = "tree",
          tree_options = {
            flatten_dirs = true,
            folder_statuses = "only_folded",
          },
          win_config = {
            position = "left",
            width = 35,
            win_opts = {},
          },
        },
        file_history_panel = {
          log_options = {
            git = {
              single_file = {
                diff_merges = "combined",
              },
              multi_file = {
                diff_merges = "first-parent",
              },
            },
          },
          win_config = {
            position = "bottom",
            height = 16,
            win_opts = {},
          },
        },
        commit_log_panel = {
          win_config = {
            win_opts = {},
          },
        },
        default_args = {
          DiffviewOpen = {},
          DiffviewFileHistory = {},
        },
        hooks = {},
        keymaps = {
          disable_defaults = false,
        },
      })
    end,
  },
}