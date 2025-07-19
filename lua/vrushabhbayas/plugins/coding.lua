-- ~/.config/nvim/lua/vrushabhbayas/plugins/coding.lua
-- Professional coding and development plugins

return {

  -- Python virtual environment selector
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
    branch = "regexp",
    ft = "python",
    keys = {
      { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select Python venv" },
      { "<leader>vc", "<cmd>VenvSelectCached<cr>", desc = "Select cached venv" },
    },
    config = function()
      require("venv-selector").setup({
        -- Auto select venv when opening Python files
        auto_refresh = true,
        search_venv_managers = true,
        search_workspace = true,
        -- Support for various venv managers
        anaconda_base_path = vim.fn.expand("~/anaconda3"),
        anaconda_envs_path = vim.fn.expand("~/anaconda3/envs"),
        poetry_path = vim.fn.expand("~/.cache/pypoetry/virtualenvs"),
        pipenv_path = vim.fn.expand("~/.local/share/virtualenvs"),
        pyenv_path = vim.fn.expand("~/.pyenv/versions"),
      })
    end,
  },

  -- vim-test integration
  {
    "vim-test/vim-test",
    keys = {
      { "<leader>tn", ":TestNearest<CR>", desc = "Run nearest test" },
      { "<leader>tf", ":TestFile<CR>", desc = "Run current file tests" },
      { "<leader>ts", ":TestSuite<CR>", desc = "Run test suite" },
      { "<leader>tl", ":TestLast<CR>", desc = "Run last test" },
      { "<leader>tw", ":TestFile --watch<CR>", desc = "Watch current file tests" },
      { "<leader>tc", ":TestSuite --coverage<CR>", desc = "Run tests with coverage" },
    },
    config = function()
      -- Dynamic window sizing function (working version)
      local function get_test_window_size()
        local total_lines = vim.o.lines
        local status_line = 1
        local cmd_line = 1
        local available = total_lines - status_line - cmd_line
        -- Use 90% of available space, with minimum 20 lines and maximum 50 lines
        local height = math.min(50, math.max(20, math.floor(available * 0.9)))
        return height
      end
      
      -- Set test strategy to use Neovim terminal with optimized positioning
      vim.g["test#strategy"] = "neovim"
      vim.g["test#neovim#term_position"] = "belowright " .. get_test_window_size()
      vim.g["test#neovim#preserve_screen"] = 1
      vim.g["test#neovim#start_normal"] = 1
      
      -- Configure Jest for TypeScript projects (working command)
      vim.g["test#javascript#runner"] = "jest"
      vim.g["test#typescript#runner"] = "jest"
      
      -- Working Jest command
      local jest_cmd = "npx jest --preset=ts-jest --testEnvironment=jsdom --no-cache"
      
      vim.g["test#javascript#jest#executable"] = jest_cmd
      vim.g["test#typescript#jest#executable"] = jest_cmd
      
      -- Optimized options for different test types
      vim.g["test#javascript#jest#options"] = {
        nearest = "--verbose --no-coverage",
        file = "--verbose --no-coverage", 
        suite = "--passWithNoTests"
      }
      vim.g["test#typescript#jest#options"] = {
        nearest = "--verbose --no-coverage",
        file = "--verbose --no-coverage",
        suite = "--passWithNoTests"
      }
      
      -- Better file pattern matching
      vim.g["test#javascript#jest#file_pattern"] = "\\v\\.(test|spec)\\.(js|jsx|ts|tsx)$"
      vim.g["test#typescript#jest#file_pattern"] = "\\v\\.(test|spec)\\.(js|jsx|ts|tsx)$"
      
      -- Python testing configuration
      vim.g["test#python#runner"] = "pytest"
      vim.g["test#python#pytest#executable"] = "python -m pytest"
      vim.g["test#python#pytest#options"] = {
        nearest = "--verbose -s",
        file = "--verbose",
        suite = "--verbose --tb=short"
      }
      vim.g["test#python#pytest#file_pattern"] = "\\v(test_.*|.*_test)\\.py$"
      
      -- Enhanced terminal configuration
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "*",
        callback = function()
          if vim.bo.filetype == "terminal" then
            -- Easy exit from test terminal
            vim.keymap.set("n", "q", ":q<CR>", { buffer = true, silent = true })
            vim.keymap.set("n", "<Esc>", ":q<CR>", { buffer = true, silent = true })
            -- Enable line numbers in terminal for better navigation
            vim.wo.number = true
            vim.wo.relativenumber = true
          end
        end,
      })
    end,
  },

  -- GitHub Copilot
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      -- Copilot settings (enable default Tab behavior)
      vim.g.copilot_assume_mapped = true
      
      -- Copilot navigation keymaps
      vim.keymap.set("i", "<C-H>", "<Plug>(copilot-dismiss)", { desc = "Copilot Dismiss" })
      vim.keymap.set("i", "<C-L>", "<Plug>(copilot-next)", { desc = "Copilot Next" })
      vim.keymap.set("i", "<C-K>", "<Plug>(copilot-previous)", { desc = "Copilot Previous" })
      vim.keymap.set("i", "<C-\\>", "<Plug>(copilot-suggest)", { desc = "Copilot Suggest" })
    end,
  },


  -- Better quickfix list
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require("bqf").setup({
        auto_enable = true,
        auto_resize_height = true,
        preview = {
          win_height = 12,
          win_vheight = 12,
          delay_syntax = 80,
          border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
          should_preview_cb = function(bufnr, qwinid)
            local ret = true
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            local fsize = vim.fn.getfsize(bufname)
            if fsize > 100 * 1024 then
              ret = false
            elseif bufname:match("^fugitive://") then
              ret = false
            end
            return ret
          end,
        },
        func_map = {
          drop = "o",
          openc = "O",
          split = "<C-s>",
          tabdrop = "<C-t>",
          tabc = "",
          ptogglemode = "z,",
        },
        filter = {
          fzf = {
            action_for = { ["ctrl-s"] = "split", ["ctrl-t"] = "tab drop" },
            extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
          },
        },
      })
    end,
  },

  -- Better folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufReadPost",
    keys = {
      { "zR", function() require("ufo").openAllFolds() end, desc = "Open all folds" },
      { "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
      { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Fold less" },
      { "zm", function() require("ufo").closeFoldsWith() end, desc = "Fold more" },
      { "zp", function() require("ufo").peekFoldedLinesUnderCursor() end, desc = "Peek fold" },
    },
    config = function()
      -- Set fold method and expression before ufo setup
      vim.o.foldmethod = 'expr'
      vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
      
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
        open_fold_hl_timeout = 150,
        close_fold_kinds = {},
        preview = {
          win_config = {
            border = { "", "─", "", "", "", "─", "", "" },
            winhighlight = "Normal:Folded",
            winblend = 0,
          },
          mappings = {
            scrollU = "<C-u>",
            scrollD = "<C-d>",
            jumpTop = "[",
            jumpBot = "]",
          },
        },
      })
    end,
  },

  -- REST client
  {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>rr", "<cmd>Rest run<cr>", desc = "Run request under cursor" },
      { "<leader>rl", "<cmd>Rest run last<cr>", desc = "Re-run last request" },
    },
    config = function()
      require("rest-nvim").setup({
        result_split_horizontal = false,
        result_split_in_place = false,
        stay_in_current_window_after_split = false,
        skip_ssl_verification = false,
        encode_url = true,
        highlight = {
          enabled = true,
          timeout = 150,
        },
        result = {
          show_url = true,
          show_curl_command = false,
          show_http_info = true,
          show_headers = true,
          show_statistics = false,
          formatters = {
            json = "jq",
            html = function(body)
              return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
            end,
          },
        },
        jump_to_request = false,
        env_file = ".env",
        custom_dynamic_variables = {},
        yank_dry_run = true,
      })
    end,
  },

  -- Better diagnostics management
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>x", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    },
    config = function()
      require("trouble").setup({
        modes = {
          preview_float = {
            mode = "diagnostics",
            preview = {
              type = "float",
              relative = "editor",
              border = "rounded",
              title = "Preview",
              title_pos = "center",
              position = { 0, -2 },
              size = { width = 0.3, height = 0.3 },
              zindex = 200,
            },
          },
        },
      })
    end,
  },

  -- Modern formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>lf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          json = { "prettier" },
          jsonc = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          scss = { "prettier" },
          markdown = { "prettier" },
          yaml = { "prettier" },
          sh = { "shfmt" },
          python = { "ruff_format", "ruff_organize_imports" },
          -- Alternative: python = { "black", "isort" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
        formatters = {
          prettier = {
            prepend_args = { "--single-quote", "--jsx-single-quote" },
          },
        },
      })
    end,
  },

  -- Enhanced search and replace
  {
    "nvim-pack/nvim-spectre",
    keys = {
      { "<leader>S", function() require("spectre").toggle() end, desc = "Toggle Spectre" },
      { "<leader>sw", function() require("spectre").open_visual({ select_word = true }) end, desc = "Search current word" },
      { "<leader>sw", function() require("spectre").open_visual() end, mode = "v", desc = "Search current word" },
      { "<leader>sp", function() require("spectre").open_file_search({ select_word = true }) end, desc = "Search on current file" },
    },
    config = function()
      require("spectre").setup({
        color_devicons = true,
        highlight = {
          ui = "String",
          search = "DiffChange",
          replace = "DiffDelete",
        },
        mapping = {
          ["toggle_line"] = {
            map = "dd",
            cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
            desc = "toggle current item",
          },
          ["enter_file"] = {
            map = "<cr>",
            cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
            desc = "goto current file",
          },
          ["send_to_qf"] = {
            map = "<leader>q",
            cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
            desc = "send all item to quickfix",
          },
          ["replace_cmd"] = {
            map = "<leader>c",
            cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
            desc = "input replace vim command",
          },
          ["show_option_menu"] = {
            map = "<leader>o",
            cmd = "<cmd>lua require('spectre').show_options()<CR>",
            desc = "show option",
          },
          ["run_current_replace"] = {
            map = "<leader>rc",
            cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
            desc = "replace current line",
          },
          ["run_replace"] = {
            map = "<leader>R",
            cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
            desc = "replace all",
          },
          ["change_view_mode"] = {
            map = "<leader>v",
            cmd = "<cmd>lua require('spectre').change_view()<CR>",
            desc = "change result view mode",
          },
          ["change_replace_sed"] = {
            map = "trs",
            cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
            desc = "use sed to replace",
          },
          ["change_replace_oxi"] = {
            map = "tro",
            cmd = "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>",
            desc = "use oxi to replace",
          },
          ["toggle_live_update"] = {
            map = "tu",
            cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
            desc = "update change when vim write file.",
          },
          ["toggle_ignore_case"] = {
            map = "ti",
            cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
            desc = "toggle ignore case",
          },
          ["toggle_ignore_hidden"] = {
            map = "th",
            cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
            desc = "toggle search hidden",
          },
          ["resume_last_search"] = {
            map = "<leader>l",
            cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
            desc = "resume last search before close",
          },
        },
        find_engine = {
          ["rg"] = {
            cmd = "rg",
            args = {
              "--color=never",
              "--no-heading",
              "--with-filename",
              "--line-number",
              "--column",
            },
            options = {
              ["ignore-case"] = {
                value = "--ignore-case",
                icon = "[I]",
                desc = "ignore case",
              },
              ["hidden"] = {
                value = "--hidden",
                desc = "hidden file",
                icon = "[H]",
              },
            },
          },
        },
        replace_engine = {
          ["sed"] = {
            cmd = "sed",
            args = nil,
            options = {
              ["ignore-case"] = {
                value = "--ignore-case",
                icon = "[I]",
                desc = "ignore case",
              },
            },
          },
        },
        default = {
          find = {
            cmd = "rg",
            options = { "ignore-case" },
          },
          replace = {
            cmd = "sed",
          },
        },
        replace_vim_cmd = "cdo",
        is_open_target_win = true,
        is_insert_mode = false,
      })
    end,
  },

  -- Debug Adapter Protocol
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- UI for nvim-dap
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        config = function()
          local dap, dapui = require("dap"), require("dapui")
          
          dapui.setup({
            controls = {
              element = "repl",
              enabled = true,
              icons = {
                disconnect = "",
                pause = "",
                play = "",
                run_last = "",
                step_back = "",
                step_into = "",
                step_out = "",
                step_over = "",
                terminate = ""
              }
            },
            layouts = {
              {
                elements = {
                  { id = "scopes", size = 0.25 },
                  { id = "breakpoints", size = 0.25 },
                  { id = "stacks", size = 0.25 },
                  { id = "watches", size = 0.25 }
                },
                position = "left",
                size = 40
              },
              {
                elements = {
                  { id = "repl", size = 0.5 },
                  { id = "console", size = 0.5 }
                },
                position = "bottom",
                size = 10
              }
            }
          })
          
          -- Auto-open/close dapui
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
          end
        end,
      },
      
      -- Python DAP extension
      {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        config = function()
          -- Setup debugpy (installed via Mason)
          local mason_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
          if vim.fn.filereadable(mason_path) == 1 then
            require("dap-python").setup(mason_path)
          else
            -- Fallback to system python with debugpy
            require("dap-python").setup("python")
          end
        end,
      },
    },
    keys = {
      -- Debug keymaps
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue debugging" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step over" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Step out" },
      { "<leader>dr", function() require("dap").repl.open() end, desc = "Open REPL" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run last" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Evaluate expression", mode = {"n", "v"} },
      
      -- Python-specific debug keymaps
      { "<leader>dn", function() require("dap-python").test_method() end, desc = "Debug nearest test", ft = "python" },
      { "<leader>df", function() require("dap-python").test_class() end, desc = "Debug test class", ft = "python" },
      { "<leader>ds", function() require("dap-python").debug_selection() end, desc = "Debug selection", mode = "v", ft = "python" },
    },
    config = function()
      local dap = require("dap")
      
      -- Configure signs
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DiagnosticSignInfo" })
      vim.fn.sign_define("DapStopped", { text = "→", texthl = "DiagnosticSignWarn", linehl = "Visual" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DiagnosticSignHint" })
    end,
  },
}