if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

setlocal foldmethod=indent
setlocal foldlevel=88
setlocal colorcolumn=121

if !exists("no_plugin_maps") && !exists("no_mail_maps")
    nnoremap <buffer> <leader>gd :call PythonGoToDefinition()<CR>
    nnoremap <buffer> <leader>ga :exec "grep --include '*.py' -R '" . expand('<cword>') . "' ."<CR>
    nnoremap <buffer> <leader>gg :grep --include '*.py' -R  .<LEFT><LEFT>
    nnoremap <buffer> <leader>ct :call PythonPrintCallingTree()<CR>
    nnoremap <buffer> <leader>ds :call PythonGenerateDocString('.')<CR>
    nnoremap <buffer> <leader>st :put = 'import pdb;pdb.set_trace()'<CR>
    nnoremap <space> za " Enable folding with the spacebar
    noremap <buffer> <leader>tp :s/"\(\w*\)": /\1=/<CR>
    noremap <buffer> <leader>td :s/\(\w*\)=/"\1": /<CR>
endif

"au BufWrite * exec ":%s/\s\+$//"
