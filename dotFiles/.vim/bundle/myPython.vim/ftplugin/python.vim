if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

setlocal foldmethod=syntax
setlocal foldlevel=2
setlocal colorcolumn=121

if !exists("no_plugin_maps") && !exists("no_mail_maps")
    nnoremap <buffer> <leader>gc :call PythonGoToDefinition('class', '(.*)\{0,1\}\s*:')<CR>
    nnoremap <buffer> <leader>gf :call PythonGoToDefinition('def', '(')<CR>
    nnoremap <buffer> <leader>ga :exec "grep --include '*.py' -R '" . expand('<cword>') . "' ."<CR>
    nnoremap <buffer> <leader>gg :grep --include '*.py' -R  .<LEFT><LEFT>
    nnoremap <buffer> <leader>ct :call PythonPrintCallingTree()<CR>
endif

"au BufWrite * exec ":%s/\s\+$//"
