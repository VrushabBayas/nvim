-- ~/.config/nvim/lua/vrushabhbayas/utils/themes.lua
-- Professional theme management utilities

local M = {}

-- Available themes with their configurations
M.themes = {
  nightfox = {
    name = "nightfox",
    display_name = "Nightfox",
    description = "Professional dark theme with excellent plugin integration",
    cmd = "colorscheme nightfox",
    variants = {
      dawnfox = "colorscheme dawnfox",
      dayfox = "colorscheme dayfox", 
      duskfox = "colorscheme duskfox",
      nordfox = "colorscheme nordfox",
      terafox = "colorscheme terafox",
      carbonfox = "colorscheme carbonfox",
    }
  },
  catppuccin = {
    name = "catppuccin",
    display_name = "Catppuccin",
    description = "Warm, cozy theme with great readability",
    cmd = "colorscheme catppuccin",
    variants = {
      latte = "colorscheme catppuccin-latte",
      frappe = "colorscheme catppuccin-frappe", 
      macchiato = "colorscheme catppuccin-macchiato",
      mocha = "colorscheme catppuccin-mocha",
    }
  },
  gruvbox = {
    name = "gruvbox",
    display_name = "Gruvbox",
    description = "Retro groove color scheme with hard contrast",
    cmd = "colorscheme gruvbox",
    variants = {
      dark = "colorscheme gruvbox",
      light = "set background=light | colorscheme gruvbox",
    }
  },
  ["rose-pine"] = {
    name = "rose-pine",
    display_name = "Rose Pine",
    description = "Natural pine, faux fur and a bit of soho vibes",
    cmd = "colorscheme rose-pine",
    variants = {
      main = "colorscheme rose-pine-main",
      moon = "colorscheme rose-pine-moon",
      dawn = "colorscheme rose-pine-dawn",
    }
  },
  tokyonight = {
    name = "tokyonight",
    display_name = "Tokyo Night",
    description = "Clean, dark theme inspired by Tokyo's night",
    cmd = "colorscheme tokyonight",
    variants = {
      night = "colorscheme tokyonight-night",
      storm = "colorscheme tokyonight-storm",
      moon = "colorscheme tokyonight-moon",
      day = "colorscheme tokyonight-day",
    }
  },
  onedark = {
    name = "onedark",
    display_name = "OneDark",
    description = "Atom's iconic One Dark theme for Neovim",
    cmd = "colorscheme onedark",
    variants = {
      dark = "colorscheme onedark",
      darker = "colorscheme onedark-darker",
      cool = "colorscheme onedark-cool", 
      deep = "colorscheme onedark-deep",
      warm = "colorscheme onedark-warm",
      warmer = "colorscheme onedark-warmer",
      light = "colorscheme onedark-light",
    }
  },
  dracula = {
    name = "dracula",
    display_name = "Dracula",
    description = "Dark theme with vibrant colors",
    cmd = "colorscheme dracula",
  },
  everforest = {
    name = "everforest",
    display_name = "Everforest",
    description = "Green based color scheme designed to be warm and soft",
    cmd = "colorscheme everforest",
    variants = {
      hard = "let g:everforest_background = 'hard' | colorscheme everforest",
      medium = "let g:everforest_background = 'medium' | colorscheme everforest",
      soft = "let g:everforest_background = 'soft' | colorscheme everforest",
    }
  },
  oceanic = {
    name = "OceanicNext",
    display_name = "Oceanic Next",
    description = "Sublime Text's Oceanic Next theme",
    cmd = "colorscheme OceanicNext",
  },
  one = {
    name = "one",
    display_name = "Vim One",
    description = "Light theme adapted from Atom's One Light",
    cmd = "colorscheme one",
    setup = function()
      vim.opt.background = "light"
    end,
  },
  
  -- Trending Themes 2025
  kanagawa = {
    name = "kanagawa",
    display_name = "Kanagawa",
    description = "Dark theme inspired by Hokusai's famous painting",
    cmd = "colorscheme kanagawa",
    variants = {
      wave = "colorscheme kanagawa-wave",
      dragon = "colorscheme kanagawa-dragon", 
      lotus = "colorscheme kanagawa-lotus",
    }
  },
  lackluster = {
    name = "lackluster",
    display_name = "Lackluster",
    description = "Monochrome theme that's soft on the eyes",
    cmd = "colorscheme lackluster",
    variants = {
      hack = "colorscheme lackluster-hack",
      mint = "colorscheme lackluster-mint",
    }
  },
  vscode = {
    name = "vscode",
    display_name = "VSCode",
    description = "Dark+/Light+ theme from VS Code",
    cmd = "colorscheme vscode",
    variants = {
      dark = "colorscheme vscode",
      light = "set background=light | colorscheme vscode",
    }
  },
  material = {
    name = "material",
    display_name = "Material",
    description = "Google Material Design theme with full plugin support",
    cmd = "colorscheme material",
    variants = {
      darker = "colorscheme material-darker",
      lighter = "colorscheme material-lighter",
      oceanic = "colorscheme material-oceanic",
      palenight = "colorscheme material-palenight",
      deep_ocean = "colorscheme material-deep-ocean",
    }
  },
  nordic = {
    name = "nordic",
    display_name = "Nordic",
    description = "Warmer, darker variation of Nord",
    cmd = "colorscheme nordic",
  },
}

-- Get the config file path for storing theme preference
local function get_theme_config_path()
  return vim.fn.stdpath("config") .. "/lua/vrushabhbayas/theme_preference.lua"
end

-- Save current theme preference
function M.save_theme(theme_name)
  local config_path = get_theme_config_path()
  local content = string.format([[-- Auto-generated theme preference
return "%s"
]], theme_name)

  local file = io.open(config_path, "w")
  if file then
    file:write(content)
    file:close()
    return true
  end
  return false
end

-- Load saved theme preference
function M.load_saved_theme()
  local config_path = get_theme_config_path()
  local ok, saved_theme = pcall(dofile, config_path)
  if ok and saved_theme and M.themes[saved_theme] then
    return saved_theme
  end
  return "nightfox" -- Default fallback
end

-- Apply a theme
function M.apply_theme(theme_name)
  local theme = M.themes[theme_name]
  if not theme then
    vim.notify("Theme '" .. theme_name .. "' not found", vim.log.levels.ERROR)
    return false
  end

  -- Run setup function if exists
  if theme.setup then
    theme.setup()
  end

  -- Apply the colorscheme
  local success, err = pcall(function()
    vim.cmd(theme.cmd)
  end)

  if not success then
    vim.notify("Failed to apply theme '" .. theme_name .. "': " .. err, vim.log.levels.ERROR)
    return false
  end

  -- Save the preference
  M.save_theme(theme_name)
  vim.notify("Applied theme: " .. theme.display_name, vim.log.levels.INFO)
  return true
end

-- Get list of theme names for completion
function M.get_theme_names()
  local names = {}
  for name, _ in pairs(M.themes) do
    table.insert(names, name)
  end
  table.sort(names)
  return names
end

-- Get theme picker data for telescope
function M.get_picker_data()
  local data = {}
  for name, theme in pairs(M.themes) do
    table.insert(data, {
      name = name,
      display_name = theme.display_name,
      description = theme.description,
      preview_cmd = theme.cmd,
    })
  end

  -- Sort by display name
  table.sort(data, function(a, b)
    return a.display_name < b.display_name
  end)

  return data
end

-- Preview a theme temporarily (for telescope)
function M.preview_theme(theme_name)
  local theme = M.themes[theme_name]
  if not theme then return end

  if theme.setup then
    theme.setup()
  end

  pcall(function()
    vim.cmd(theme.cmd)
  end)
end

-- Random theme selection
function M.random_theme()
  local names = M.get_theme_names()
  local current = vim.g.colors_name
  local available = {}

  -- Filter out current theme
  for _, name in ipairs(names) do
    if M.themes[name].cmd:match(name) ~= current then
      table.insert(available, name)
    end
  end

  if #available == 0 then
    vim.notify("No other themes available", vim.log.levels.WARN)
    return
  end

  math.randomseed(os.time())
  local random_theme = available[math.random(#available)]
  M.apply_theme(random_theme)
end

-- Cycle through theme variants
function M.cycle_variants()
  local current = vim.g.colors_name
  if not current then
    vim.notify("No theme currently active", vim.log.levels.WARN)
    return
  end

  -- Find which theme family the current colorscheme belongs to
  local current_theme = nil
  local current_variant = "default"
  
  for name, theme in pairs(M.themes) do
    -- Check if current matches base theme
    local base_scheme = theme.cmd:match("colorscheme (%S+)")
    if base_scheme == current then
      current_theme = theme
      current_variant = "default"
      break
    end
    
    -- Check if current matches any variant
    if theme.variants then
      for variant_name, variant_cmd in pairs(theme.variants) do
        -- Extract colorscheme name from command (handles complex commands)
        local variant_scheme = variant_cmd:match("colorscheme ([%w-_]+)")
        if variant_scheme == current then
          current_theme = theme
          current_variant = variant_name
          break
        end
      end
    end
    
    if current_theme then break end
  end

  -- If no theme found with variants, check if it's a theme without variants
  if not current_theme then
    for name, theme in pairs(M.themes) do
      local base_scheme = theme.cmd:match("colorscheme (%S+)")
      if base_scheme == current and not theme.variants then
        vim.notify(string.format("%s has no variants to cycle through", theme.display_name), vim.log.levels.INFO)
        return
      end
    end
    vim.notify("Current theme not found in configuration", vim.log.levels.WARN)
    return
  end

  -- If theme has no variants, inform user
  if not current_theme.variants or next(current_theme.variants) == nil then
    vim.notify(string.format("%s has no variants to cycle through", current_theme.display_name), vim.log.levels.INFO)
    return
  end

  -- Build variant list for current theme
  local variants = { { name = "default", cmd = current_theme.cmd } }
  for variant_name, variant_cmd in pairs(current_theme.variants) do
    table.insert(variants, { name = variant_name, cmd = variant_cmd })
  end

  -- Find current position and cycle to next
  local current_pos = 1
  for i, variant in ipairs(variants) do
    if variant.name == current_variant then
      current_pos = i
      break
    end
  end

  local next_pos = (current_pos % #variants) + 1
  local next_variant = variants[next_pos]

  -- Execute the variant command
  local success = pcall(function()
    vim.cmd(next_variant.cmd)
  end)

  if success then
    vim.notify(string.format("Switched to %s (%s)", current_theme.display_name, next_variant.name), vim.log.levels.INFO)
  else
    vim.notify(string.format("Failed to switch to %s variant", next_variant.name), vim.log.levels.ERROR)
  end
end


-- Show theme information and available variants
function M.theme_info()
  local current = vim.g.colors_name
  local output = {"🎨 Theme Information:", ""}
  
  -- Current theme info
  table.insert(output, "📍 Current: " .. (current or "none"))
  
  -- Find current theme details
  local current_theme = nil
  for name, theme in pairs(M.themes) do
    local base_scheme = theme.cmd:match("colorscheme (%S+)")
    if base_scheme == current then
      current_theme = theme
      table.insert(output, "   Theme: " .. theme.display_name)
      table.insert(output, "   Description: " .. theme.description)
      break
    elseif theme.variants then
      for variant_name, variant_cmd in pairs(theme.variants) do
        local variant_scheme = variant_cmd:match("colorscheme (%S+)")
        if variant_scheme == current then
          current_theme = theme
          table.insert(output, "   Theme: " .. theme.display_name .. " (" .. variant_name .. ")")
          table.insert(output, "   Description: " .. theme.description)
          break
        end
      end
    end
    if current_theme then break end
  end
  
  table.insert(output, "")
  
  -- Available variants for current theme
  if current_theme and current_theme.variants then
    table.insert(output, "🔄 Available variants:")
    table.insert(output, "  • default")
    for variant_name, _ in pairs(current_theme.variants) do
      table.insert(output, "  • " .. variant_name)
    end
    table.insert(output, "")
  end
  
  -- All themes with variants
  table.insert(output, "🎨 All themes with variants:")
  for name, theme in pairs(M.themes) do
    if theme.variants then
      local count = 0
      for _ in pairs(theme.variants) do count = count + 1 end
      table.insert(output, "  ▶ " .. theme.display_name .. " (" .. count .. " variants)")
    end
  end
  
  table.insert(output, "")
  table.insert(output, "📋 Usage:")
  table.insert(output, "• <leader>cv - Cycle through variants")
  table.insert(output, "• <leader>cs - Theme picker")
  
  vim.notify(table.concat(output, "\n"), vim.log.levels.INFO)
end

-- Create telescope picker for themes
function M.telescope_picker()
  local has_telescope, builtin = pcall(require, 'telescope.builtin')
  if not has_telescope then
    vim.notify("Telescope not available", vim.log.levels.ERROR)
    return
  end

  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')

  local picker_data = M.get_picker_data()
  local original_theme = vim.g.colors_name

  pickers.new({}, {
    prompt_title = "🎨 Choose Theme",
    finder = finders.new_table {
      results = picker_data,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.display_name .. " - " .. entry.description,
          ordinal = entry.display_name .. " " .. entry.description,
        }
      end,
    },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      -- Preview on selection
      local function preview_selection()
        local selection = action_state.get_selected_entry()
        if selection then
          M.preview_theme(selection.value.name)
        end
      end

      -- Apply theme and close
      local function apply_selection()
        local selection = action_state.get_selected_entry()
        if selection then
          M.apply_theme(selection.value.name)
        end
        actions.close(prompt_bufnr)
      end

      -- Restore original theme and close
      local function cancel_selection()
        if original_theme and original_theme ~= "" then
          pcall(function()
            vim.cmd("colorscheme " .. original_theme)
          end)
        end
        actions.close(prompt_bufnr)
      end

      map('i', '<CR>', apply_selection)
      map('n', '<CR>', apply_selection)
      map('i', '<C-c>', cancel_selection)
      map('n', '<Esc>', cancel_selection)

      -- Preview on cursor move
      map('i', '<C-j>', function()
        actions.move_selection_next(prompt_bufnr)
        preview_selection()
      end)
      map('i', '<C-k>', function()
        actions.move_selection_previous(prompt_bufnr)
        preview_selection()
      end)
      map('n', 'j', function()
        actions.move_selection_next(prompt_bufnr)
        preview_selection()
      end)
      map('n', 'k', function()
        actions.move_selection_previous(prompt_bufnr)
        preview_selection()
      end)

      return true
    end,
  }):find()
end

-- Initialize theme system
function M.init()
  -- Create theme command
  vim.api.nvim_create_user_command('Theme', function(opts)
    local theme_name = opts.args
    if theme_name == "" then
      -- Show available themes
      local themes = M.get_theme_names()
      print("Available themes: " .. table.concat(themes, ", "))
      print("Current theme: " .. (vim.g.colors_name or "none"))
      return
    end
    M.apply_theme(theme_name)
  end, {
    nargs = '?',
    complete = function()
      return M.get_theme_names()
    end,
    desc = "Switch theme"
  })

  -- Load saved theme on startup
  local saved_theme = M.load_saved_theme()
  if saved_theme ~= "nightfox" then
    -- Delay loading to ensure all plugins are loaded
    vim.defer_fn(function()
      M.apply_theme(saved_theme)
    end, 100)
  end
end

return M
