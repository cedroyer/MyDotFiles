set wildignore+=*.pyc

fun! PythonGoToDefinition(py_keyword, exp_after)
    let cur_word = expand('<cword>')
    split
    silent exec "grep -R --include '*.py' '" . a:py_keyword . '\s*' . cur_word . '\s*\(' . a:exp_after . "\\)' ."
    redraw!
endfun

fun! PythonGetCallingTree()
    let current_line = '.'
    let last_line = ''
    let result = []
    while 1
        let t = matchstrpos(getline(current_line),'^\s*')
        let indent_char = t[0][0]
        let cur_indent = t[2]
        if cur_indent <= 0
            break
        endif
        let last_line = current_line
        let prev_indent_regex = '^'.indent_char.'\{0,'.(cur_indent-1).'\}[^'.indent_char.']'
        let current_line = search(prev_indent_regex,'bn')
        if current_line == 0
            break
        endif
        call insert(result, current_line)
    endwhile
    return result
endfun

fun! PythonPrintCallingTree()
    for l in PythonGetCallingTree()
        echo printf('%4d: %s', l, getline(l))
    endfor
endfun

let s:python_def_regex = '^\s*def \([^(]\+\)(\([^)]*\)):'

fun! PythonGenerateDocString(def_line)
    let m = matchlist(getline(a:def_line), s:python_def_regex)
    if ! empty(m)
        let fun_name = m[1]
        let args = split(m[2], '\s*,\s*')
        let def_indent = indent(a:def_line)
        let single_indent = repeat(' ', &tabstop)
        let doc_indent = repeat(' ', (def_indent + &tabstop))
        exec ':' . a:def_line
        put = doc_indent.'\"\"\"'
        if ! empty(args)
            put = ''
            put = doc_indent.'Args:'
            for arg in args
                put = doc_indent . single_indent . arg . ':'
            endfor
        endif
        put=doc_indent.'\"\"\"'
        return 1
    endif
    return 0
endfun

