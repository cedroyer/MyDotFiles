function! CreateEmptyClassFiles(classname,namespace,path)
	:e a:path . '/' . a:classname ".h"
	:call createEmptyClassDefinition(a:classname,a:namespace)
	:new a:path . '/' . a:classname ".cpp"
	:call createEmptyClassConstrutor(a:classname)
endfunction
function CreateEnumStreamOperator()
    let s:enumBegin = search('enum', 'c')
    if s:enumBegin == 0
        echo "cannot found enum"
        return
    endif
    let s:enumName = matchlist(getline('.'),)[1]
    :put = ''
    let s:bracketBegin = search('{','^\s*enum\s*\(class\)\{0,1\}\s*\(w*\)\s*\(:\s*\(\w*\)\s*\)\{0,1\}\s*')
    if s:enumBegin == 0
        echo "cannot found begin bracket"
        return
    endif
    :normal %



endfunction
