set foldmethod=syntax
set foldlevel=2
set colorcolumn=121

nnoremap <leader>gc :call PythonGoToDefinition('class', '(.*)\{0,1\}\s*:')<CR>
nnoremap <leader>gf :call PythonGoToDefinition('def', '(')<CR>
nnoremap <leader>ga :exec "grep --include '*.py' -R '" . expand('<cword>') . "' ."<CR>
nnoremap <leader>gg :grep --include '*.py' -R  .<LEFT><LEFT>
