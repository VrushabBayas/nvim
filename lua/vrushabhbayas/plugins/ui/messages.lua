-- ~/.config/nvim/lua/vrushabhbayas/plugins/ui/messages.lua
-- Messaging and notification components: modern command line and notifications

return {

  -- Modern UI for messages, cmdline and popupmenu
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    keys = {
      { "<leader>sn", "", desc = "+noice" },
      { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"} },
    },
    config = function()
      -- Set up custom highlight groups for centered command palette
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          -- Custom command palette background (darker with transparency)
          vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { 
            bg = "#1e1e2e", 
            fg = "#cdd6f4",
            blend = 10 
          })
          -- Custom border color (accent color)
          vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { 
            fg = "#89b4fa",
            bg = "NONE" 
          })
        end,
      })
      
      -- Apply colors immediately
      vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { 
        bg = "#1e1e2e", 
        fg = "#cdd6f4",
        blend = 10 
      })
      vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { 
        fg = "#89b4fa",
        bg = "NONE" 
      })

      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        routes = {
          {
            filter = {
              event = "msg_show",
              any = {
                { find = "%d+L, %d+B" },
                { find = "; after #%d+" },
                { find = "; before #%d+" },
              },
            },
            view = "mini",
          },
        },
        views = {
          cmdline_popup = {
            position = {
              row = "50%",
              col = "50%",
            },
            size = {
              width = 60,
              height = "auto",
            },
            border = {
              style = "rounded",
              padding = { 0, 1 },
            },
            win_options = {
              winhighlight = "Normal:NoiceCmdlinePopup,FloatBorder:NoiceCmdlinePopupBorder,IncSearch:,Search:",
              winblend = 0,
            },
          },
        },
        cmdline = {
          enabled = true,
          view = "cmdline_popup",
        },
        presets = {
          bottom_search = true,
          command_palette = false,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = false,
        },
      })
    end,
  },

  -- Enhanced notifications
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all Notifications",
      },
    },
    config = function()
      require("notify").setup({
        timeout = 3000,
        max_height = function()
          return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
          return math.floor(vim.o.columns * 0.75)
        end,
        on_open = function(win)
          vim.api.nvim_win_set_config(win, { zindex = 100 })
        end,
      })
    end,
  },

}