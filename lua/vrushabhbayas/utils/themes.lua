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
  },
  catppuccin = {
    name = "catppuccin",
    display_name = "Catppuccin Mocha",
    description = "Warm, cozy theme with great readability",
    cmd = "colorscheme catppuccin",
  },
  gruvbox = {
    name = "gruvbox",
    display_name = "Gruvbox",
    description = "Retro groove color scheme with hard contrast",
    cmd = "colorscheme gruvbox",
  },
  ["rose-pine"] = {
    name = "rose-pine",
    display_name = "Rose Pine Moon",
    description = "Natural pine, faux fur and a bit of soho vibes",
    cmd = "colorscheme rose-pine",
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
