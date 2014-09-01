function! CreateEmptyClassFiles(classname,namespace,path)
	:e a:path . '/' . a:classname ".h"
	:call createEmptyClassDefinition(a:classname,a:namespace)
	:new a:path . '/' . a:classname ".cpp"
	:call createEmptyClassConstrutor(a:classname)
endfunction
