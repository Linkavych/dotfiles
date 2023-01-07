syntax on

set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set noswapfile
set nowrap
set smartcase
set nobackup
set incsearch
set relativenumber

set undodir=~/.vim/undodir
set undofile

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin()

Plug 'morhetz/gruvbox'
Plug 'luisiacc/gruvbox-baby'
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'https://github.com/vim-syntastic/syntastic.git'
Plug 'sheerun/vim-polyglot'
Plug 'jremmen/vim-ripgrep'
Plug 'ambv/black'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'romgrk/nvim-treesitter-context'

" Autopairs
Plug 'jiangmiao/auto-pairs'

" Telescope Vim
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'Pocco81/TrueZen.nvim'

call plug#end()

colorscheme gruvbox
set background=dark

" Mapping the leader key and other shortcuts

let mapleader = " "

nnoremap <silent> Q <nop>
nnoremap <leader>u :UndotreeShow<CR>

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nnoremap <leader>zz <cmd>TZAtaraxis<cr>

nnoremap <leader>gb <cmd>Git blame<cr>
nnoremap <leader>gc <cmd>Git commit<cr>
nnoremap <leader>gp <cmd>Git push<cr>
nnoremap <leader>gl <cmd>Git log<cr>
nnoremap <leader>ga <cmd>Gwrite<cr>
nnoremap <leader>gs <cmd>Git<cr>

xnoremap <leader>p "_dP
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='molokai'

" Skeleton templates
au bufnewfile *.sh 0r ~/.templates/skeleton.sh
au bufnewfile *.py 0r ~/.templates/skeleton.py
au bufnewfile *.bash 0r ~/.templates/skeleton.bash
au bufnewfile *.c 0r ~/.templates/skeleton.c
