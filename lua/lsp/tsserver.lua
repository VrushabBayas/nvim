-- ~/.config/nvim/lua/lsp/tsserver.lua
local lspconfig = require("lspconfig")

lspconfig.ts_ls.setup({
  on_attach = function(_, bufnr)
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

    -- Auto-organize imports before save
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = { "*.ts", "*.tsx", "*.js", "*.jsx", "*.sh" },
      callback = function()
        local params = {
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(0) },
          title = "",
        }
        local params = {
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(0) },
        }
        local client = vim.lsp.get_active_clients({ bufnr = 0 })[1]
        if client then
          client.request("workspace/executeCommand", params, nil, 0)
        end
      end,
    })
  end,
})

