-- ~/.config/nvim/lua/vrushabhbayas/plugins/ui.lua
-- Professional UI plugins configuration - modular organization

-- Import all UI modules
local interface = require("vrushabhbayas.plugins.ui.interface")
local files = require("vrushabhbayas.plugins.ui.files")
local messages = require("vrushabhbayas.plugins.ui.messages")
local enhancements = require("vrushabhbayas.plugins.ui.enhancements")

-- Combine all UI plugins into a single table
local ui_plugins = {}

-- Add all plugins from each module
vim.list_extend(ui_plugins, interface)
vim.list_extend(ui_plugins, files)
vim.list_extend(ui_plugins, messages)
vim.list_extend(ui_plugins, enhancements)

return ui_plugins