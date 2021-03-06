" C++ 11: support brace in parenthesis
let c_no_curly_error=1
set cino=g0,:0,l1,N-s,+0


"function! MyAdditionalCppIndent()
"	echo v:lnum .':'. cindent(v:lnum)
"	if match(getline(v:lnum), 'template <.*>') != 1
"		ret 0
"	else
"		ret cindent(v:lnum)
"	endif
"endfunction
"setlocal indentexpr=MyAdditionalCppIndent()

set foldmethod=syntax
set foldlevel=2

" make options
set autowriteall
function! MakeGetterSetter() range
	:$
	:mark B
	:exe a:firstline.','.a:lastline.'copy .'
	:'B,$s/\s*\(\w\w*\(\s*const\)\{0,1\}\(\s*\(&\|\*\)\)\{0,1\}\)\s*\(\w\w*\)_;$/
				\\t\1 get\u\5() const;
				\\r\tvoid set\u\5(\1);
				\\rinline \1 ::get\u\5() const {return \5_;}
				\\rinline void ::set\u\5(\1 val) {\5_ = val;}/
	:delmark B
endfunction

function! CreateEmptyClassDefinition(...)
    if a:0 == 0
        let opts={}
    elseif a:0 == 1
        let opts=a:1
    else
        echo 'error bad number of agument must be 0 or 1(a dict with option)'
        return
    endif
    if has_key(opts, 'classname')
        let classname=opts['classname']
    else
        let classname=expand('%:t:r')
    endif
	:0
	put='#pragma once'
	put=''
	if has_key(opts, 'namespace')
		put='namespace ' . opts['namespace'] . ' {'
		put=''
	endif
	put='class ' . classname . ' {'
	put='   ' . classname . '() {}'
	put='   virtual ~' . classname . '() {}'
	put='};'
	if has_key(opts, 'namespace')
		put=''
		put='} // end namespace ' . opts['namespace']
	endif
endfunction

fun! ShowFuncName()
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
	echo getline(search("^\\( \\{4}\\|\\t\\)\\?\\a\\S\\{-}\\( \\a\\S\\{-}\\)\\+\\s\\?(.*[^;]\\s\\{-}$", 'bW'))
  echohl None
  call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun

"command! -range SetGet <line1>,<line2>call MakeGetterSetter()

noremap <leader>gs _w :call MakeGetterSetter()<CR>
"""""""""""""""""""""""""""""""""""""
" Bundle
""
"fswitch
noremap <leader>he :FSHere<CR>
noremap <leader>hv :FSSplitLeft<CR>
noremap <leader>hs :FSSplitBelow<CR>
noremap <leader>f  :call ShowFuncName() <CR>
