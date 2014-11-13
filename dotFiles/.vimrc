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

let s:vimConfigDir="~/.vim"

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h10
		let s:vimConfigDir="~\\vimfiles"
  endif
endif

"""""""""""""""""""""""""""""""""""""
" Bundle
""

let s:bundleDir = s:vimConfigDir."/bundle"

"CtrlP
exec "set runtimepath^=".s:bundleDir."/ctrlp.vim"
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.d,*.o
let g:ctrlp_cmd = 'CtrlPCurWD'

"fswitch
exec "set runtimepath^=".s:bundleDir."/vim-fswitch"

"myCpp
exec "set runtimepath^=".s:bundleDir."/myCpp.vim"

"myCpp
exec "set runtimepath^=".s:bundleDir."/DoxygenToolkit.vim"
