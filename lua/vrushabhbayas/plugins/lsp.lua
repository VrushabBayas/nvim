-- ~/.config/nvim/lua/vrushabhbayas/plugins/lsp.lua
-- Simple LSP configuration following kickstart.nvim pattern

return {
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "b0o/schemastore.nvim",
    },
    config = function()
      -- Common on_attach function for all LSP servers
      local on_attach = function(client, bufnr)
        local map = vim.keymap.set
        local opts = { buffer = bufnr, noremap = true, silent = true }

        -- LSP keymaps - ensure they override default vim behaviors
        map("n", "gI", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to implementation" })
        map("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Go to references" })
        map("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
        map("n", "<leader>D", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Type definition" })
        map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
        map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })
        map("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover" })
        map("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
        
        -- Python-specific LSP keymaps
        if client.name == "pyright" then
          map("n", "<leader>io", function()
            vim.lsp.buf.code_action({
              filter = function(action)
                return action.title:match("Organize Imports") or action.title:match("Sort imports")
              end,
              apply = true,
            })
          end, { buffer = bufnr, desc = "Organize imports" })
          
          map("n", "<leader>ai", function()
            vim.lsp.buf.code_action({
              filter = function(action)
                return action.title:match("Add import") or action.title:match("Import")
              end,
              apply = true,
            })
          end, { buffer = bufnr, desc = "Add missing import" })
        end
        
        -- Note: Formatting is now handled by conform.nvim
        -- The <leader>f keybinding is defined in the conform.nvim configuration
      end

      -- Enhanced capabilities with nvim-cmp
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      -- Define servers (kickstart.nvim style)
      local servers = {
        ts_ls = {
          settings = {
            typescript = {
              preferences = {
                includeCompletionsForModuleExports = true,
                includeCompletionsForImportStatements = true,
                includePackageJsonAutoImports = "on",
                importModuleSpecifier = "shortest",
                updateImportsOnFileMove = "always",
              },
              suggest = {
                autoImports = true,
              },
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              preferences = {
                includeCompletionsForModuleExports = true,
                includeCompletionsForImportStatements = true,
                includePackageJsonAutoImports = "on",
                importModuleSpecifier = "shortest",
                updateImportsOnFileMove = "always",
              },
              suggest = {
                autoImports = true,
              },
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        emmet_ls = {
          filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
        },
        marksman = {},
        bashls = {},
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                autoImportCompletions = true,
                diagnosticMode = "workspace",
                stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs",
              },
              -- Use virtual environment if available, otherwise use system python
              pythonPath = vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV .. "/bin/python" or vim.fn.exepath("python3"),
              venvPath = vim.env.VIRTUAL_ENV and vim.fn.fnamemodify(vim.env.VIRTUAL_ENV, ":h") or nil,
              venv = vim.env.VIRTUAL_ENV and vim.fn.fnamemodify(vim.env.VIRTUAL_ENV, ":t") or nil,
            },
          },
        },
        jsonls = {
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        },
        html = {},
        cssls = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              diagnostics = { globals = { "vim" } },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
            },
          },
        },
      }

      -- Setup mason to ensure servers are installed
      require("mason").setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            server.on_attach = on_attach
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })

      -- Configure diagnostics for inline errors/warnings
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          source = "if_many",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })
    end,
  },

  -- Mason for LSP server management
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
  },

  -- Mason-lspconfig bridge
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
  },
}
