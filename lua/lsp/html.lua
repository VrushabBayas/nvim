-- ~/.config/nvim/lua/lsp/html.lua
local lspconfig = require("lspconfig")

lspconfig.html.setup({
  filetypes = { "html", "javascriptreact", "typescriptreact" },
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  settings = {
    html = {
      format = {
        indentInnerHtml = true,
      },
      suggest = {
        html5 = true,
      },
    },
  },
  on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, noremap = true, silent = true }
    local map = vim.keymap.set
    
    -- LSP keymaps
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gD", vim.lsp.buf.declaration, opts)
    map("n", "gi", vim.lsp.buf.implementation, opts)
    map("n", "gr", vim.lsp.buf.references, opts)
    map("n", "<leader>rn", vim.lsp.buf.rename, opts)
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    map("n", "K", vim.lsp.buf.hover, opts)
    
    -- Auto import command
    map("n", "<leader>ai", function()
      vim.lsp.buf.code_action({ context = { only = { "source.addImport" } } })
    end, opts)
    
    -- Format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
})
