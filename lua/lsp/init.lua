require("lsp.tsserver")
-- require("lsp.pyright")
require("lsp.html")
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "bash", "html", "javascript", "typescript", "tsx" },  -- Add these
    highlight = { enable = true, },
}
