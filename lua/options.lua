-- ~/.config/nvim/lua/options.lua
vim.opt.scrolloff = 8
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.mouse = "a"
vim.opt.showmatch = true
vim.opt.linebreak = true
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.termguicolors = true
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

-- Theme setup
--require("onedark").setup({
--  colorscheme = "onedark"
--})
--require("onedarkpro").load()

--vim.cmd([[colorscheme gruvbox]])
--vim.cmd([[colorscheme one]])          -- for vim-one
--vim.cmd([[colorscheme dracula]])
--vim.cmd([[colorscheme everforest]])
vim.cmd([[colorscheme nightfox]])
--vim.cmd([[colorscheme OceanicNext]])
--vim.cmd([[colorscheme catppuccin]])

--require("catppuccin").setup({
--  colorscheme = "catppuccin"
--})
--vim.cmd([[colorscheme catppuccin]])

-- ALE configuration
vim.g.ale_disable_lsp = 1
vim.g.ale_linters = {
  javascript = { "eslint" },
  python = { "ruff" },
}
vim.g.ale_python_ruff_executable = "ruff"

-- Prettier configuration
vim.g["prettier#autoformat"] = 1
vim.g["prettier#config#use_config_from_proj"] = 1
vim.g["prettier#quickfix_enabled"] = 0

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx", ".sh" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
require('lspconfig').ts_ls.setup({
  on_attach = function(client, bufnr)
    -- Make sure formatting is disabled if using null-ls or prettier
    client.server_capabilities.documentFormattingProvider = false
  end,
})
