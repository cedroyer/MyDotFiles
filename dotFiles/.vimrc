"""""""""""""""""""""""""""""""""""""
" Variable Definition
""
if $VIM_ROOT_PATH != ""
	let s:vimRootDir=$VIM_ROOT_PATH
else
	let s:vimRootDir=$HOME
endif

if $VIM_CONFIG_DIR_PATH != ""
	let s:vimConfigDir=$VIM_CONFIG_DIR_PATH
elseif has("gui_win32")
	let s:vimConfigDir=s:vimRootDir."\\vimfiles"
else
	let s:vimConfigDir=s:vimRootDir."/.vim"
endif

fu! s:SourceIfReadable(path)
	if filereadable(a:path)
		exec 'source '.a:path
	endif
endfu

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
Plugin 'ctrlpvim/ctrlp.vim'

" help doxygen comment writing
Plugin 'vim-scripts/DoxygenToolkit.vim'

" keke tuning status bar
Plugin 'bling/vim-airline'

" plugin git for vim
Plugin 'tpope/vim-fugitive'

" Align code to a given char
Plugin 'vim-scripts/Align'

" Solarized color scheme
Plugin 'altercation/vim-colors-solarized'

" plantuml syntax
Plugin 'aklt/plantuml-syntax'

" rust syntax
Plugin 'rust-lang/rust.vim'

" flake8 python linter
Plugin 'nvie/vim-flake8'

" Python go plugin
Plugin 'fatih/vim-go'

" python import sorter isort
Plugin 'stsewd/isort.nvim'

" neomake generic linter
Plugin 'neomake/neomake'

" Linter python
Plugin 'ambv/black'

" python auto-complete
Plugin 'roxma/nvim-yarp'
Plugin 'ncm2/ncm2'

" autocomplete
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANTE: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
Plugin 'ncm2/ncm2-bufword'
Plugin 'ncm2/ncm2-path'
Plugin 'ncm2/ncm2-jedi'
Plugin 'ncm2/ncm2-vim'

" git patcher
Plugin 'airblade/vim-gitgutter'

call s:SourceIfReadable(s:vimRootDir."/.vimrc_local_plugin")

call vundle#end()

" my plugins
exec "set runtimepath^=".s:bundleDir."/myCpp.vim"
exec "set runtimepath^=".s:bundleDir."/myLua.vim"
exec "set runtimepath^=".s:bundleDir."/myPython.vim"
exec "set runtimepath^=".s:bundleDir."/mySql.vim"
exec "set runtimepath^=".s:bundleDir."/myMake.vim"

"""""""""""""""""""""""""""""""""""""
" Bundle Configuration
""
"vim-airline
set laststatus=2
set t_Co=256 " color version

"""""""""""""""""""""""""""""""""""""
" Personal Configuration
""
filetype plugin indent on
let mapleader=','
set tabstop=4
set shiftwidth=4
set softtabstop=0
set expandtab
set smarttab
set backspace=indent,eol,start
set hlsearch
set ruler
set showcmd
set updatetime=250
syntax enable

set wildignore+=*/tmp/*,*.swp

set wildmenu
set wildmode=longest:full

fun! ToggleMouse()
    if &mouse == "a"
        set mouse=
    else
        set mouse=a
    endif
endfun

" Shortcuts
nnoremap <Tab> :tabnext<CR>
nnoremap <s-Tab> :tabprev<CR>
nnoremap <leader>m :call ToggleMouse()<CR>

if has("gui_running")
    "set background=light
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
                \ '\d\+$',
                \ '\=eval(submatch(0)+1)',
                \ '')<CR>
    nnoremap <C-Down> :silent! let &guifont = substitute(
                \ &guifont,
                \ '\d\+$',
                \ '\=eval(submatch(0)-1)',
                \ '')<CR>
else
    set background=dark
endif

call s:SourceIfReadable(s:vimRootDir."/.vimrc_local")

"colorscheme desert

" lint auto python
autocmd BufWritePre *.py execute ':Black'
