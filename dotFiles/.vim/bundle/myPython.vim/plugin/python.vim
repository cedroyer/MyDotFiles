set wildignore+=*.pyc

fun! PythonGoToDefinition()
    let cur_word = expand('<cword>')
    split
    silent exec 'grep -R --include "*.py" "\(\(def\\|class\)\s*' . cur_word . '\s*(\\|\(^\\|\s\)' . cur_word . ' = \)" .'
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
        let first_ = 1
        if ! empty(args)
            for arg in args
                if arg != 'self' && arg != 'cls'
                    if first_
                        let first_ = 0
                        put = ''
                        put = doc_indent.'Args:'
                    endif
                    put = doc_indent . single_indent . split(arg, '\s*=\s*')[0] . ' ():'
                endif
            endfor
            put = ''
        endif
        put = doc_indent.'Returns:'
        put=doc_indent.'\"\"\"'
        return 1
    endif
    return 0
endfun

if !exists("no_plugin_maps") && !exists("no_mail_maps")
    nnoremap <buffer> <leader>pgg :grep --include '*.py' -R  .<LEFT><LEFT>
endif

