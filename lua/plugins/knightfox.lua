-- lua/plugins/nightfox.lua
return {
  "EdenEast/nightfox.nvim",
  lazy = false,    -- Load immediately since it's a colorscheme
  priority = 9500, -- High priority to load before other plugins
  config = function()
    require('nightfox').setup({
      options = {
        -- Compilation settings for better performance
        compile_path = vim.fn.stdpath("cache") .. "/nightfox",
        compile_file_suffix = "_compiled",
        
        -- Visual preferences for professional use
        transparent = false,        -- Solid background for better readability
        terminal_colors = true,     -- Consistent colors in terminal
        dim_inactive = true,        -- Helps focus on active pane
        module_default = true,      -- Enable plugin support by default
        
        -- Syntax styling for better code readability
        styles = {
          comments = "italic",      -- Italicize comments for distinction
          conditionals = "bold",    -- Bold conditionals for flow clarity
          constants = "NONE",       -- Keep constants normal
          functions = "bold",       -- Bold functions for importance
          keywords = "bold",        -- Bold keywords for structure
          numbers = "NONE",         -- Keep numbers normal
          operators = "NONE",       -- Keep operators subtle
          strings = "NONE",         -- Keep strings normal
          types = "italic,bold",    -- Emphasize type definitions
          variables = "NONE",       -- Keep variables normal
        },

        -- Inverse highlighting preferences
        inverse = {
          match_paren = false,      -- Don't inverse matching parentheses
          visual = false,           -- Don't inverse visual selection
          search = false,           -- Don't inverse search highlights
        },

        -- Module configurations for plugins
        modules = {
          -- Core modules
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
          
          -- Additional useful modules
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

    -- Apply the colorscheme
    vim.cmd("colorscheme nightfox")
    
    -- Optional: Enable true color support
    if vim.fn.has("termguicolors") == 1 then
      vim.opt.termguicolors = true
    end
    
    -- Compile for better performance (with error handling)
    local success, err = pcall(function()
      require('nightfox').compile()
    end)
    
    if not success then
      vim.notify("Nightfox compilation failed: " .. err, vim.log.levels.WARN)
    end
  end,
}
