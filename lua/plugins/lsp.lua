-- null-ls (for formatting + linting)
{
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- Python
        null_ls.builtins.formatting.black,
        null_ls.builtins.diagnostics.ruff,

        -- JavaScript/TypeScript/CSS/JSON
        null_ls.builtins.formatting.prettier.with({
          extra_filetypes = { "json", "markdown" },
        }),

        -- Optionally enable ESLint
        -- null_ls.builtins.diagnostics.eslint,
        -- null_ls.builtins.code_actions.eslint,
      },
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = "LspFormatting", buffer = bufnr })

          vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("LspFormatting", {}),
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end,
    })
  end,
},

