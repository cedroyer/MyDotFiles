if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

if exists("g:markdown_spelllang")
    exec "set spell spelllang=" . g:markdown_spelllang
endif
