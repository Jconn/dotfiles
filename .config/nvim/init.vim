set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

"source ~/.vimrc
tnoremap <Esc> <C-\><C-n>

call plug#begin('~/.vim/plugin-jwc')
" line editing and whatnot
" Plug 'neoclide/coc.nvim', {'branch': 'release'}         " LSP and more
Plug 'morhetz/gruvbox'
Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/guihua.lua', {'do': 'cd lua/fzy && make' }
Plug 'ray-x/navigator.lua'
Plug 'nvim-treesitter/nvim-treesitter'

Plug 'nvim-lua/lsp-status.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'wbthomason/packer.nvim' 
Plug 'L3MON4D3/LuaSnip'
" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Dockerfile ls
Plug 'ekalinin/Dockerfile.vim'

"buffer management
Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
" Plug 'ryanoasis/vim-devicons' Icons without colours
Plug 'akinsho/nvim-bufferline.lua'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/NERDtree', {'on': 'NERDTreeToggle' }
Plug 'https://github.com/tmhedberg/SimpylFold'
Plug 'https://github.com/Konfekt/FastFold'
Plug 'https://github.com/nvie/vim-flake8'
" Plug 'https://github.com/numirias/semshi'
Plug 'https://github.com/junegunn/fzf'
Plug 'vim-scripts/grep.vim'
Plug 'https://github.com/vimwiki/vimwiki'
call plug#end()
"""""""""""""""""
" generic section
"""""""""""""""""
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
" nnoremap <C-F> :FZF<CR>
" center what we're finding 
nnoremap n nzzzv
nnoremap N Nzzz



"let g:loaded_youcompleteme = 1
"let g:badwolf_colorterm = 0
"color badwolf 
set background=dark
"let g:gruvbox_transparent_bg = 1
colorscheme gruvbox
"set termguicolors

autocmd VimEnter * hi Normal ctermbg=none
"highlight ColorColumn ctermbg=0 guibg=grey
"hi SignColumn guibg=none
"hi CursorLineNR guibg=None
"highlight Normal guibg=none
"highlight LineNr guifg=#5eacd3
"highlight netrwDir guifg=#5eacd3
"highlight qfFileName guifg=#aed75f
"hi TelescopeBorder guifg=#5eacd

set hlsearch
set incsearch
"use system clipboard so copy and paste just works
"set clipboard=unnamed
set mouse=a

let mapleader=";"
" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy "+yy

" telescope
nnoremap <leader>ff :Telescope find_files<cr>
nnoremap <C-F> :Telescope find_files<cr>
nnoremap <leader>g :Telescope live_grep<CR>
nnoremap <leader>b :Telescope buffers<CR>
nnoremap <leader>fh :Telescope help_tags<CR>

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

nnoremap <leader>v :vsp<CR><C-w>l<CR>
nnoremap <leader>h :sp<CR><C-w>j<CR>

nnoremap <leader>t :term<CR>

" switch between buffers
set hidden
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

" folding
"set foldmethod=syntax
"syntax on
"""""""""""""""""
" load lsp config
"""""""""""""""""

"nvim_lsp.clangd.setup({ cmd = {"clangd-9"} });
lua <<EOF

local lsp_status = require'lsp-status'
local util=require'lspconfig'.util
lsp_status.register_progress()
lsp_status.config({
    kind_labels = {},
    current_function = false,
    indicator_separator = ' ',
    indicator_errors = '',
    indicator_warnings = '',
    indicator_info = '',
    indicator_hint = '!',
    indicator_ok = '',
    select_symbol = nil,
    status_symbol = '',
    spinner_frames = { '-', '\\', '|', '/' },
})
local on_attach = function(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<C-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<leader>n', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<leader>N', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

  -- Enable type inlay hints
 

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  -- autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()

  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
      augroup END
    ]], false)
  end
  lsp_status.on_attach(client)
end

require'lspconfig'.rust_analyzer.setup(
{
    cmd = {"rust-analyzer"},
    on_attach=on_attach
}
)

require'lspconfig'.pylsp.setup(
{
    cmd = {"pylsp"},
    settings = {
    pylsp = {
    plugins = {
      pycodestyle = {enabled = false},
      flake8 = {
        enabled = true,
        ignore = {},
        maxLineLength = 160
      },
      pylsp_mypy =  {enabled = true, live_mode = true, dmypy=false, strict=true},
      pylsp_isort = {enabled = true},
      yapf = {enabled = false},
      pylint = {enabled = false}
    }
}
},
    on_attach=on_attach
    
}
);

require'lspconfig'.clangd.setup(
{ 
    cmd = {"clangd-11"},
    on_attach=on_attach,
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_dir = util.root_pattern("build")
});

require'lspconfig'.dockerls.setup(
{
    cmd = { "docker-langserver", "--stdio" },
    on_attach=on_attach,
    filetypes = { "Dockerfile"},
    root_dir = util.root_pattern(".git")
});

EOF
"
"require'navigator'.setup(
"{
"    lsp = {
"        clangd = {
"            cmd = { "clangd-11", "--background-index" };
"            filetypes = { "c", "cpp", "objc", "objcpp" };
"            root_dir ="/hdd/staging_ws/src/mekaworks/yaw_creator";
"            }
"        }
"}
")
"lsp = {
"    ccls = {
"        init_options = {
"            compilationDatabaseDirectory = "/hdd/staging_ws/build";
"            index = {
"                threads = 0;
"                };
"            clang = {
"                excludeArgs = { "-frounding-math"} ;
"                };
"            }
"    }
"}

"""""""""""""""""
" load coc 
"""""""""""""""""
" set hidden
" set nobackup
" set nowritebackup
" set cmdheight=1
" set updatetime=300
" set shortmess+=c
" set signcolumn=yes
" 
" " Navigate snippet placeholders using tab
" let g:coc_snippet_next = '<Tab>'
" let g:coc_snippet_prev = '<S-Tab>'
" 
" " list of the extensions to make sure are always installed
" let g:coc_global_extensions = [
"             \'coc-yank',
"             \'coc-pairs',
"             \'coc-json',
"             \'coc-css',
"             \'coc-html',
"             \'coc-tsserver',
"             \'coc-yaml',
"             \'coc-lists',
"             \'coc-snippets',
"             \'coc-pyright',
"             \'coc-clangd',
"             \'coc-prettier',
"             \'coc-xml',
"             \'coc-syntax',
"             \'coc-git',
"             \'coc-marketplace',
"             \'coc-highlight',
"             \'coc-flutter',
"             \]
" 
" " multi cursor shortcuts
" nmap <silent> <C-a> <Plug>(coc-cursors-word)
" xmap <silent> <C-a> <Plug>(coc-cursors-range)
" 
" " Use `[g` and `]g` to navigate diagnostics
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)
" 
" " other stuff
" nmap <leader>rn <Plug>(coc-rename)
" nmap <leader>o :OR <CR>
" 
" " jump stuff
" nmap <leader>jd <Plug>(coc-definition)
" nmap <leader>jy <Plug>(coc-type-definition)
" nmap <leader>ji <Plug>(coc-implementation)
" nmap <leader>jr <Plug>(coc-references)
" 
" " other coc actions
" nnoremap <silent> K :call <SID>show_documentation()<CR>
" nmap <leader>a <Plug>(coc-codeaction-line)
" xmap <leader>a <Plug>(coc-codeaction-selected)
" 
" " flutter mappings
" nnoremap <F3> :CocCommand flutter.devices<CR>
" nnoremap <F4> :CocCommand flutter.emulators<CR>
" nnoremap <F5> :CocCommand flutter.run<CR>
" 
"buffer management
"
lua << EOF
require("bufferline").setup{}
EOF

lua << EOF
local use = require('packer').use
require('packer').startup(function()
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
end)

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
EOF

