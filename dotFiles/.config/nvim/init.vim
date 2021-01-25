call plug#begin('~/.local/share/nvim/plugged')

" common
" auto formatter
Plug 'sbdchd/neoformat'
" auto completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
" smart comment
Plug 'scrooloose/nerdcommenter'
" smart marker
Plug 'neomake/neomake'
" editing multiple part of file
Plug 'mg979/vim-visual-multi'

" python specific
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'zchee/deoplete-jedi', { 'for': 'python' }

call plug#end()


" close auto complete window automatically
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" disable autocompletion, because we use deoplete for completion
let g:jedi#completions_enabled = 0
let g:deoplete#enable_at_startup = 1
let g:omni_sql_no_default_maps = 1

" open the go-to function in split, not another buffer
" let g:jedi#use_splits_not_buffers = "right"
let g:neomake_python_enabled_makers = ['pylint', 'mypy']

let g:neoformat_run_all_formatters = 1
let g:neoformat_enabled_python = ['isort', 'black']

augroup fmt
    autocmd!
    autocmd BufWritePre * undojoin | Neoformat
augroup END

call neomake#configure#automake('nw', 750)
