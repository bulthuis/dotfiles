" for loading Pathogen (http://www.vim.org/scripts/script.php?script_id=2332)
filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

" Turns of Vim's vi compatiblity
set nocompatible

" Prevents some security exploits
" http://lists.alioth.debian.org/pipermail/pkg-vim-maintainers/2007-June/004020.html
set modelines=0

" Controls tab width (http://vimcasts.org/episodes/tabs-and-spaces/)
" This will create 2 space tabs and not convert them to spaces.
set tabstop=2
set shiftwidth=2
set softtabstop=2
set noexpandtab

set encoding=utf-8

" Scroll text 3 lines before the edge of the window
set scrolloff=3

" When pressing enter, put the cursor at the same indentation level as the previous line
set autoindent

" Show when you are in insert mode
set showmode

" Show the unfinished command-mode command
set showcmd

" Allows unsaved buffers
set hidden

" Getting path autocompleting to work like bash
set wildmenu
set wildmode=list:longest

" Turn off error beeping
set visualbell

" Highlight current line
set cursorline

" Faster scrolling
set ttyfast

" Always display cursor position
set ruler

" Make sure you can backspace over everthing
set backspace=indent,eol,start

" Always show status line
set laststatus=2

" Change leader key from \ to ,
let mapleader = ","

" Taming searching and moving
" 
" Automatically adds \v to the front of a regex
nnoremap / /\v
vnoremap / /\v
" Make search deal with case intelligently
set ignorecase
set smartcase
" Substitutes all values on a line
set gdefault
" Highlight search results as you type
set incsearch
set showmatch
set hlsearch
" Allows you to easily clear search
nnoremap <leader><space> :noh<cr>
" Match bracket pairs
nnoremap <tab> %
vnoremap <tab> %

" Handling long lines
set wrap
set textwidth=79
set formatoptions=qrn1

" Show invisible characters like TextMate
set list
set listchars=tab:▸\ ,eol:¬

" Force me not to use the arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
" Move by file line, not screen line
nnoremap j gj
nnoremap k gk

" So you don't have to hit shift
nnoremap ; :

" Save on losing focus
au FocusLost * :wa

" Hide the toolbar
if has("gui_running")
    set guioptions=egmrt
endif

" Map jj to esc
inoremap jj <ESC>

" Window management
"
" Create new vertical split and switch to it
nnoremap <leader>w <C-w>v<C-w>l
" Move around splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Command for NERD tree
noremap <leader>d :NERDTreeToggle<cr>

" Font
set guifont=Menlo:12

" Colors
let moria_style='dark'
colorscheme moria
