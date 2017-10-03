set wildignore+=*.pyc

fun! PythonGoToDefinition(py_keyword, exp_after)
    let cur_word = expand('<cword>')
    split
    silent exec "grep -R --include '*.py' '" . a:py_keyword . '\s*' . cur_word . '\s*\(' . a:exp_after . "\\)' ."
    redraw!
endfun

