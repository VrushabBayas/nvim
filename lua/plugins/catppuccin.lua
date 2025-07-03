-- Create a new file: lua/plugins/catppuccin.lua
-- This follows your existing plugin structure

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- latte (light theme)
      background = {
        light = "mocha",
        dark = "mocha",
      },
      transparent_background = false,
      show_end_of_buffer = false,
      term_colors = true,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      no_italic = false,
      no_bold = false,
      no_underline = false,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        telescope = true,
        harpoon = true,
        mason = true,
        neotest = true,
        which_key = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = false,
        },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        },
        -- Additional integrations you might want to enable
        lsp_trouble = true,
        which_key = true,
        barbecue = {
          dim_dirname = true,
          bold_basename = true,
          dim_context = false,
          alt_background = false,
        },
      },
    })

    -- Set colorscheme
    vim.cmd.colorscheme("catppuccin")
    
    -- Optional: Set background explicitly for light theme
    vim.opt.background = "light"
    
    -- Optional: Custom highlight overrides
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" }) -- For transparent background
    
    -- Optional: Set up autocmd for dynamic theme switching
    vim.api.nvim_create_autocmd("OptionSet", {
      pattern = "background",
      callback = function()
        vim.cmd("colorscheme catppuccin")
      end,
    })
  end,
}
