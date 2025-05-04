require("lsp.tsserver")
-- require("lsp.pyright")
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "bash" },
  highlight = {
    enable = true,
  },
}

