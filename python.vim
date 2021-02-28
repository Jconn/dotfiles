let b:ale_linters = ['pylint']
let b:ale_fixers = ['yapf', 'black']
let b:ale_warn_about_trailing_whitespace = 0
let b:ale_list_window_size = 10
nnoremap <leader>f :ALEFix<CR>
