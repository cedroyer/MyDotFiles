set nocompatible

filetype plugin indent on
let mapleader=','
set tabstop=2
set shiftwidth=2
set backspace=indent,eol,start
set hlsearch
set ruler
set showcmd
syntax on

set wildmenu
set wildmode=longest:full

"""""""""""""""""""""""""""""""""""""
" Bundle
""

"CtrlP
set runtimepath^=~/.vim/bundle/ctrlp.vim
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.d,*.o
let g:ctrlp_cmd = 'CtrlPCurWD'

"fswitch
set runtimepath^=~/.vim/bundle/vim-fswitch

"myCpp
set runtimepath^=~/.vim/bundle/myCpp.vim

