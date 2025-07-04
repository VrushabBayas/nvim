-- ~/.config/nvim/lua/vrushabhbayas/plugins/themes.lua
-- Complete theme collection with custom switching capabilities

return {
  -- Nightfox (default/current theme)
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require('nightfox').setup({
        options = {
          compile_path = vim.fn.stdpath("cache") .. "/nightfox",
          compile_file_suffix = "_compiled",
          transparent = false,
          terminal_colors = true,
          dim_inactive = true,
          module_default = true,
          styles = {
            comments = "italic",
            conditionals = "bold",
            constants = "NONE",
            functions = "bold",
            keywords = "bold",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "italic,bold",
            variables = "NONE",
          },
          inverse = {
            match_paren = false,
            visual = false,
            search = false,
          },
          modules = {
            diagnostic = true,
            gitsigns = true,
            ["nvim-tree"] = true,
            ["neo-tree"] = true,
            lualine = true,
            telescope = true,
            cmp = true,
            treesitter = true,
            ["which-key"] = true,
            notify = true,
            lazy = true,
            barbar = true,
            fern = true,
            lightline = true,
            hop = true,
            lightspeed = true,
            ["nvim-cmp"] = true,
            ["ts-rainbow"] = true,
            ["ts-rainbow2"] = true,
            ["rainbow-delimiters"] = true,
            ["nvim-dap-ui"] = true,
            neotest = true,
            dashboard = true,
            alpha = true,
            aerial = true,
            illuminate = true,
            ["indent-blankline"] = true,
            mini = true,
          },
        },
      })

      -- Only set as default if no other theme is set
      if not vim.g.colors_name then
        vim.cmd("colorscheme nightfox")
        if vim.fn.has("termguicolors") == 1 then
          vim.opt.termguicolors = true
        end
        pcall(require('nightfox').compile)
      end
    end,
  },

  -- Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        background = {
          light = "latte",
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
          lsp_trouble = true,
          barbecue = {
            dim_dirname = true,
            bold_basename = true,
            dim_context = false,
            alt_background = false,
          },
        },
      })
    end,
  },

  -- Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    config = function()
      require("gruvbox").setup({
        terminal_colors = true,
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true,
        contrast = "hard",
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
      })
    end,
  },

  -- Rose Pine
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    config = function()
      require("rose-pine").setup({
        variant = "moon",
        dark_variant = "main",
        bold_vert_split = false,
        dim_nc_background = false,
        disable_background = false,
        disable_float_background = false,
        disable_italics = false,
        groups = {
          background = "base",
          background_nc = "_experimental_nc",
          panel = "surface",
          panel_nc = "base",
          border = "highlight_med",
          comment = "muted",
          link = "iris",
          punctuation = "subtle",
          error = "love",
          hint = "iris",
          info = "foam",
          warn = "gold",
          headings = {
            h1 = "iris",
            h2 = "foam",
            h3 = "rose",
            h4 = "gold",
            h5 = "pine",
            h6 = "foam",
          },
        },
        highlight_groups = {
          ColorColumn = { bg = "rose" },
          CursorLine = { bg = "foam", blend = 10 },
          StatusLine = { fg = "love", bg = "love", blend = 10 },
        }
      })
    end,
  },

  -- Tokyo Night
  {
    "folke/tokyonight.nvim",
    lazy = true,
    config = function()
      require("tokyonight").setup({
        style = "night", -- storm, moon, night, day
        light_style = "day",
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          sidebars = "dark",
          floats = "dark",
        },
        sidebars = { "qf", "help", "terminal", "packer" },
        day_brightness = 0.3,
        hide_inactive_statusline = false,
        dim_inactive = false,
        lualine_bold = false,
      })
    end,
  },

  -- OneDark
  {
    "navarasu/onedark.nvim",
    lazy = true,
    config = function()
      require('onedark').setup({
        style = 'dark', -- dark, darker, cool, deep, warm, warmer, light
        transparent = false,
        term_colors = true,
        ending_tildes = false,
        cmp_itemkind_reverse = false,
        toggle_style_key = nil,
        toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'},
        code_style = {
          comments = 'italic',
          keywords = 'none',
          functions = 'none',
          strings = 'none',
          variables = 'none'
        },
        lualine = {
          transparent = false,
        },
        colors = {},
        highlights = {},
        diagnostics = {
          darker = true,
          undercurl = true,
          background = true,
        },
      })
    end,
  },

  -- Dracula
  {
    "Mofiqul/dracula.nvim",
    lazy = true,
    config = function()
      local dracula = require("dracula")
      dracula.setup({
        colors = {},
        show_end_of_buffer = true,
        transparent_bg = false,
        lualine_bg_color = "#44475a",
        italic_comment = true,
        overrides = {},
      })
    end,
  },

  -- Everforest
  {
    "sainnhe/everforest",
    lazy = true,
    config = function()
      vim.g.everforest_style = 'medium'
      vim.g.everforest_better_performance = 1
      vim.g.everforest_background = 'medium'
      vim.g.everforest_transparent_background = 0
      vim.g.everforest_dim_inactive_windows = 0
      vim.g.everforest_disable_italic_comment = 0
    end,
  },

  -- Oceanic Next
  {
    "mhartington/oceanic-next",
    lazy = true,
    config = function()
      vim.g.oceanic_next_terminal_bold = 1
      vim.g.oceanic_next_terminal_italic = 1
    end,
  },

  -- Vim One (Light theme)
  {
    "rakr/vim-one",
    lazy = true,
    config = function()
      vim.g.one_allow_italics = 1
    end,
  },
}