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

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h10
  endif
endif

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

