setlocal foldmethod=syntax
setlocal foldlevel=2
setlocal colorcolumn=120

noremap <leader>gc :call PythonGoToDefinition('class', '(.*)\{0,1\}\s*:')<CR>
noremap <leader>gf :call PythonGoToDefinition('def', '(')<CR>
