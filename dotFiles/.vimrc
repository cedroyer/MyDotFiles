"""""""""""""""""""""""""""""""""""""
" Variable Definition
""
if $VIM_ROOT_PATH != ""
	let s:vimRootDir=$VIM_ROOT_PATH
else
	let s:vimRootDir="~"
endif

if $VIM_CONFIG_DIR_PATH != ""
	let s:vimConfigDir=$VIM_CONFIG_DIR_PATH
elseif has("gui_win32")
	let s:vimConfigDir=s:vimRootDir."\\vimfiles"
else
	let s:vimConfigDir=s:vimRootDir."/.vim"
endif

exec "set rtp+=".s:vimConfigDir

"""""""""""""""""""""""""""""""""""""
" Bundle
""
let s:bundleDir = s:vimConfigDir."/bundle"

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
exec "set rtp+=".s:bundleDir."/Vundle"
call vundle#begin(s:bundleDir)

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim', {'name': 'Vundle'}

" switch between header and source (C++)
Plugin 'derekwyatt/vim-fswitch'

" fast file access
Plugin 'kien/ctrlp.vim'

" help doxygen comment writing
Plugin 'vim-scripts/DoxygenToolkit.vim'

" keke tuning status bar
Plugin 'bling/vim-airline'

" plugin git for vim
Plugin 'tpope/vim-fugitive'

" Align code to a given char
Plugin 'vim-scripts/Align'

call vundle#end()

" myCpp
exec "set runtimepath^=".s:bundleDir."/myCpp.vim"

"""""""""""""""""""""""""""""""""""""
" Bundle Configuration
""
"CtrlP
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.d,*.o
let g:ctrlp_cmd = 'CtrlPCurWD'

"vim-airline
set laststatus=2
set t_Co=256 " color version

"""""""""""""""""""""""""""""""""""""
" Personal Configuration
""
filetype plugin indent on
let mapleader=','
set tabstop=2
set shiftwidth=2
set backspace=indent,eol,start
set hlsearch
set ruler
set showcmd
syntax on

colorscheme desert

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
	" Zoom in/Zoom out functionality
	nnoremap <C-Up> :silent! let &guifont = substitute(
				\ &guifont,
				\ ':h\zs\d\+',
				\ '\=eval(submatch(0)+1)',
				\ '')<CR>
	nnoremap <C-Down> :silent! let &guifont = substitute(
				\ &guifont,
				\ ':h\zs\d\+',
				\ '\=eval(submatch(0)-1)',
				\ '')<CR>
endif

