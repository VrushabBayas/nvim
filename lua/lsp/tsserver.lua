-- ~/.config/nvim/lua/lsp/tsserver.lua
local lspconfig = require("lspconfig")

-- Use the correct server name as documented in nvim-lspconfig
lspconfig.ts_ls.setup({
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
  commands = {
    OrganizeImports = {
      function()
        local params = {
          command = "_typescript.organizeImports",
          arguments = {vim.api.nvim_buf_get_name(0)},
          title = ""
        }
        vim.lsp.buf.execute_command(params)
      end,
      description = "Organize Imports"
    }
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
    
    -- Auto-organize imports on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        -- Only run for JS/TS files
        local ft = vim.bo[bufnr].filetype
        if ft == "typescript" or ft == "javascript" or ft == "typescriptreact" or ft == "javascriptreact" then
          vim.lsp.buf.execute_command({
            command = "_typescript.organizeImports",
            arguments = {vim.api.nvim_buf_get_name(0)},
            title = ""
          })
        end
      end,
    })
  end,
})
