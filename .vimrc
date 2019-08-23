call plug#begin('~/.vim/plugin-jwc')
Plug 'rust-lang/rust.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/NERDtree', {'on': 'NERDTreeToggle' }
Plug 'https://github.com/tmhedberg/SimpylFold'
Plug 'https://github.com/Konfekt/FastFold'
Plug 'https://github.com/nvie/vim-flake8'
Plug 'https://github.com/numirias/semshi'
Plug 'https://github.com/junegunn/fzf'
Plug 'vim-scripts/grep.vim'
Plug 'https://github.com/vimwiki/vimwiki'
call plug#end()

set number
set showcmd
filetype on
filetype plugin on
syntax enable
set grepprg=grep\ -nH\ $*
set autoindent
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4
set wildmenu
set wildmode=longest:full,full
set tags=./tags;/
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
set smartcase
set ignorecase
imap jk <Esc>
imap kj <Esc>
nnoremap <C-F> :FZF<CR>


"let g:loaded_youcompleteme = 1
color badwolf 
set hlsearch
set incsearch
"use system clipboard so copy and paste just works
"set clipboard=unnamedplus
set mouse=a
