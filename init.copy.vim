" === PLUGINS ===
call plug#begin('~/.vim/plugged')

" LSP & Autocompletion
Plug 'neovim/nvim-lspconfig'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Copiloet
Plug 'github/copilot.vim'

" Telescope + utils
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }

" Themes
Plug 'morhetz/gruvbox'
Plug 'navarasu/onedark.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'rakr/vim-one'
Plug 'nyoom-engineering/oxocarbon.nvim'
Plug 'ayu-theme/ayu-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'sainnhe/everforest'
Plug 'EdenEast/nightfox.nvim'
Plug 'mhartington/oceanic-next'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'olimorris/onedarkpro.nvim'

" JavaScript / JSX / TS
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }

" Linters / Formatters
Plug 'dense-analysis/ale'
Plug 'sbdchd/neoformat'

" Git integration
Plug 'tpope/vim-fugitive'

" Productivity & Fun
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ThePrimeagen/vim-be-good'

call plug#end()
" Auto import missing symbols on save (for JS/TS)
autocmd BufWritePre *.ts,*.tsx,*.js,*.jsx :call CocActionAsync('runCommand', 'tsserver.organizeImports')

" === BASIC SETTINGS ===
set number
set relativenumber
set scrolloff=8
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set smarttab
set incsearch
set hlsearch
set mouse=a
set showmatch
set linebreak
set completeopt+=menuone,noselect
set termguicolors
syntax on
filetype plugin indent on
let mapleader = " "

let ayucolor = "mirage"   " options: 'dark', 'light', 'mirage'
" === COLORSCHEME ===
" colorscheme gruvbox
" Uncomment to use a different theme:
" colorscheme onedark
" colorscheme tokyonight-night
" colorscheme oxocarbon
" colorscheme dracula
" colorscheme ayu
" colorscheme everforest
" colorscheme OceanicNext
" colorscheme catppuccin
" colorscheme nightfox
" === COC CONFIG ===
"
lua << EOF
require("onedarkpro").setup({
  colorscheme = "onedark"
})
require("onedarkpro").load()
EOF

let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-eslint'
\ ]

" === ALE CONFIG ===
let g:ale_disable_lsp = 1
let g:ale_linters = {
  \ 'javascript': ['eslint'],
  \ 'python': ['ruff'],
\}

let g:ale_python_ruff_executable = 'ruff'

" Optional: Recommended settings before applying the theme
" let g:everforest_background = 'hard'       " Options: 'hard', 'medium', 'soft'
" let g:everforest_enable_italic = 1         " Enable italic
" let g:everforest_disable_italic_comment = 0

" let g:catppuccin_flavour = "macchiato" "frappe latte mocha


" === PRETTIER CONFIG ===
let g:prettier#autoformat = 1
let g:prettier#config#use_config_from_proj = 1
let g:prettier#quickfix_enabled = 0

" autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.css,*.scss,*.json :PrettierAsync

" === LSP CONFIG (nvim-lspconfig) ===
lua << EOF
  require'lspconfig'.tsserver.setup{}
EOF

" === KEYBINDINGS ===
" Reload config
nnoremap <leader><CR> :source ~/.config/nvim/init.vim<CR>

" Open netrw in a vertical split
nnoremap <leader>pv :Vex 20<CR>

" Keep search matches in the center of the screen
nnoremap n nzzzv
nnoremap N Nzzzv

" Clear search highlight with leader + /
nnoremap <leader>/ :nohlsearch<CR>

" FZF & Telescope
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>pf :Files<CR>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Git commands
nnoremap <leader>gs <cmd>Git status<cr>
nnoremap <leader>gst <cmd>Git stash<cr>
nnoremap <leader>gsa <cmd>Git stash apply<cr>
nnoremap <leader>gsp <cmd>Git stash pop<cr>
nnoremap <leader>gc <cmd>Git commit<cr>
nnoremap <leader>gb <cmd>Git branch<cr>
nnoremap <leader>ga <cmd>Git add .<cr>
nnoremap <leader>gp <cmd>Git push <cr>
nnoremap <leader>gl <cmd>Git log --oneline --graph --decorate <cr>



" JS console.log shortcut
nnoremap <leader>l :let @z = expand('<cword>')<CR>oconsole.log('[log]<C-r>z:', <C-r>z)<Esc>

" Copy/paste helpers
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG
vnoremap <leader>p "_dP
nnoremap <leader>d :t.<CR>

" Save file quickly
nnoremap <leader>w :w<CR>

" Quit quickly
nnoremap <leader>q :q<CR>

" Toggle between last two buffers
nnoremap <leader><leader> <C-^>


" Move lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Escape insert mode
inoremap jk <Esc>

" LSP-based navigation
nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap gr <cmd>lua vim.lsp.buf.references()<CR>
