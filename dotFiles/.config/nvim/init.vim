"""""""""""""""""""""""""""""""""""""
" Variable Definition
""
if $VIM_ROOT_PATH != ""
	let s:vimRootDir=$VIM_ROOT_PATH
else
	let s:vimRootDir=$HOME."/.config/nvim"
endif

if $VIM_CONFIG_DIR_PATH != ""
	let s:vimConfigDir=$VIM_CONFIG_DIR_PATH
else
	let s:vimConfigDir=s:vimRootDir
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
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
call plug#begin()

" switch between header and source (C++)
Plug 'derekwyatt/vim-fswitch'

" fast file access
Plug 'ctrlpvim/ctrlp.vim'

" help doxygen comment writing
Plug 'vim-scripts/DoxygenToolkit.vim'

" keke tuning status bar
Plug 'bling/vim-airline'

" plugin git for vim
Plug 'tpope/vim-fugitive'

" Align code to a given char
Plug 'vim-scripts/Align'

" Solarized color scheme
Plug 'altercation/vim-colors-solarized'

" plantuml syntax
Plug 'aklt/plantuml-syntax'

" rust syntax
Plug 'rust-lang/rust.vim'

" flake8 python linter
Plug 'nvie/vim-flake8'

" Python go plugin
Plug 'fatih/vim-go'

" python import sorter isort
Plug 'stsewd/isort.nvim'

" neomake generic linter
Plug 'neomake/neomake'

" Linter python
Plug 'ambv/black'

" python auto-complete
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'

" autocomplete
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANTE: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-vim'

" git patcher
Plug 'airblade/vim-gitgutter'

call s:SourceIfReadable(s:vimRootDir."/.plugin_local.vim")

call plug#end()


" my plugins
let s:myBundleDir = s:vimConfigDir."/my_bundle"
exec "set runtimepath^=".s:myBundleDir."/myCpp.vim"
exec "set runtimepath^=".s:myBundleDir."/myLua.vim"
exec "set runtimepath^=".s:myBundleDir."/myPython.vim"
exec "set runtimepath^=".s:myBundleDir."/mySql.vim"
exec "set runtimepath^=".s:myBundleDir."/myMake.vim"

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

call s:SourceIfReadable(s:vimRootDir."/init_local.vim")

"colorscheme desert

" lint auto python
autocmd BufWritePre *.py execute ':Black'
