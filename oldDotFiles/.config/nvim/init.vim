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

if $VIM_SHARED_DIR_PATH != ""
	let s:vimSharedDir=$VIM_SHARED_DIR_PATH
else
	let s:vimSharedDir=$HOME."/.local/share/nvim/"
endif

fu! s:SourceIfReadable(path)
	if filereadable(a:path)
		exec 'source '.a:path
	endif
endfu

call s:SourceIfReadable(s:vimRootDir."/before_local.vim")

exec "set rtp+=".s:vimConfigDir
let mapleader=','

"""""""""""""""""""""""""""""""""""""
" Bundle
""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
call plug#begin()

" Global plugins

" fast file access
Plug 'ctrlpvim/ctrlp.vim'

" keke tuning status bar
Plug 'bling/vim-airline'

" plugin git for vim
Plug 'tpope/vim-fugitive'

" Align code to a given char
Plug 'vim-scripts/Align', {'on': 'Align'}

" git patcher
Plug 'airblade/vim-gitgutter'

" Tag bar file resume
Plug 'majutsushi/tagbar'

" neomake generic linter
Plug 'vim-syntastic/syntastic'

" Solarized color scheme
"Plug 'altercation/vim-colors-solarized'

" Specific plugins

" switch between header and source (C++)
Plug 'derekwyatt/vim-fswitch', {'for': ['cpp', 'c']}

" help doxygen comment writing
Plug 'vim-scripts/DoxygenToolkit.vim', {'for': 'cpp'}

" plantuml syntax
Plug 'aklt/plantuml-syntax', {'for': 'plantuml'}

" rust pulgin
Plug 'rust-lang/rust.vim', {'for': 'rust'}

" flake8 python linter
Plug 'nvie/vim-flake8', {'for': 'python'}

" Python go plugin
Plug 'fatih/vim-go', {'for': 'go'}

" python import sorter isort
Plug 'stsewd/isort.nvim', {'for': 'python'}

" Linter python
Plug 'ambv/black', {'for': 'python'}

" indentation color
Plug 'nathanaelkane/vim-indent-guides'

" deep learning auto complete
Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }

" auto complete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

Plug 'zchee/deoplete-clang', {'for': ['cpp', 'c']}
Plug 'zchee/deoplete-jedi', {'for': 'python'}
Plug 'zchee/deoplete-go', {'for': 'go'}
Plug 'sebastianmarkow/deoplete-rust', {'for': 'rust'}

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

let s:pythonSharedDir = s:vimSharedDir."/python"
let g:python_host_prog = s:pythonSharedDir."/env2/bin/python"
let g:python3_host_prog = s:pythonSharedDir."/env3/bin/python"
let $PATH = s:pythonSharedDir . "/env3/bin:" . $PATH

call s:SourceIfReadable(s:vimRootDir."/.plugin_local.vim")

call plug#end()


" my plugins
let s:myBundleDir = s:vimConfigDir."/my_bundle"
exec "set runtimepath^=".s:myBundleDir."/myCpp.vim"
exec "set runtimepath^=".s:myBundleDir."/myLua.vim"
exec "set runtimepath^=".s:myBundleDir."/myPython.vim"
exec "set runtimepath^=".s:myBundleDir."/mySql.vim"
exec "set runtimepath^=".s:myBundleDir."/myMake.vim"
exec "set runtimepath^=".s:myBundleDir."/myYaml.vim"
exec "set runtimepath^=".s:myBundleDir."/myMarkdown.vim"

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

" neosnipett key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
"if has('conceal')
"  set conceallevel=2 concealcursor=niv
"endif

" lint rust
let g:rustfmt_autosave = 1

if !empty(system("setxkbmap -print|grep bepo"))
    call s:SourceIfReadable(s:vimRootDir."/bepo.vim")
endif


" lint auto python
autocmd BufWritePre *.py execute ':Black'

" NerdTree like netrw config
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" local nvim configuration
set secure
set exrc
set nomodeline
