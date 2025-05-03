-- ~/.config/nvim/lua/lsp/pyright.lua
local lspconfig = require("lspconfig")

lspconfig.pyright.setup({
  on_attach = function(_, bufnr)
    local map = vim.keymap.set
    local opts = { buffer = bufnr, noremap = true, silent = true }

    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gD", vim.lsp.buf.declaration, opts)
    map("n", "gi", vim.lsp.buf.implementation, opts)
    map("n", "gr", vim.lsp.buf.references, opts)
    map("n", "<leader>rn", vim.lsp.buf.rename, opts)
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    map("n", "K", vim.lsp.buf.hover, opts)
  end,
})

