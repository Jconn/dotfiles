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
let g:badwolf_colorterm = 0
color badwolf 
set hlsearch
set incsearch
"use system clipboard so copy and paste just works
"set clipboard=unnamed
set mouse=a
