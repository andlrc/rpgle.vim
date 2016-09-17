if exists("b:current_syntax")
	finish
endif

syn case ignore
let b:current_syntax = "rpgle"
setlocal iskeyword+=%,-

syntax match rpgleInclude "\v^\/include.*$"
syntax match rpgleInclude "\v^\/copy.*$"
 
syntax match  rpgleNumber                /\v<[0-9]+>/
syntax region rpgleString                start=/'/hs=s+1 skip=/''/ end=/'/he=e-1
syntax match  rpgleOperator              /\v[-.*/=><]|\*\*|\<\>|\>\=|\<\=|<NOT>|<AND>|<OR>/
syntax match  rpgleProcedure             /\v\a+\s*\ze\(/
syntax match  rpgleComment               /\v\/\/.*/ contains=rpgleTodo
syntax region rpgleComment               start=/\v\/\*/ end=/\v\*\// contains=rpgleTodo
syntax match  rpgleTodo        contained "\v(TODO|FIXME)"

syntax region rpgleIf                    matchgroup=rpgleConditional start=/\v<if>/           end=/\v(\ze\n\s*(<elseif>|<else>)|<endif>)/ contains=@rpgleNest extend fold
syntax region rpgleElseIf                matchgroup=rpgleConditional start=/\v<elseif>/       end=/\v(\ze\n\s*(<elseif>|<else>)|<endif>)/ contains=@rpgleNest extend fold
syntax region rpgleElse                  matchgroup=rpgleConditional start=/\v<else>/         end=/\v<endif>/                             contains=@rpgleNest extend fold

syntax region rpgleDo                    matchgroup=rpgleRepeat      start=/\v<dow>|<dou>/    end=/\v<enddo>/                             contains=@rpgleNest extend fold
syntax region rpgleFor                   matchgroup=rpgleRepeat      start=/\v<for>/          end=/\v<endfor>/                            contains=@rpgleNest extend fold

syntax region rpgleSelect                matchgroup=rpgleSwitch      start=/\v<select>/       end=/\v<endsl>/                             contains=rpgleWhen,rpgleOther extend fold
syntax region rpgleWhen        contained matchgroup=rpgleSwitch      start=/\v<when>/ end=/\v\ze\n\s*(<when>|<other>|<endsl>)/            contains=@rpgleNest extend fold
syntax region rpgleOther       contained matchgroup=rpgleSwitch      start=/\v<other>/ end=/\v\ze\n\s*<endsl>/                            contains=@rpgleNest extend fold

syntax region rpgleSub                   matchgroup=rpgleLabel       start=/\v<begsr>/        end=/\v<endsr>/                             contains=@rpgleNest extend fold

syntax region rpgleDclProc               matchgroup=rpgleLabel       start=/\v<dcl-proc>/     end=/\v<end-proc>/                          contains=@rpgleNest,rpgleDclPi extend fold
syntax region rpgleDclPi                 matchgroup=rpgleLabel       start=/\v<dcl-pi>/       end=/\v<end-pi>/                            contains=@rpgleNest extend fold

" All the groups than can be nested, eg. doesn't need to be on the outer most layer
syntax cluster rpgleNest contains=rpgleNumber,rpgleString,rpgleOperator,rpgleProcedure,rpgleComment,rpgleIf,rpgleElseIf,rpgleElse,rpgleDo,rpgleFor,rpgleSelect

hi link rpgleInclude Include

hi link rpgleNumber      Number
hi link rpgleString      String
hi link rpgleOperator    Operator
hi link rpgleProcedure   Function
hi link rpgleComment     Comment
hi link rpgleTodo        Todo

hi link rpgleConditional Conditional
hi link rpgleRepeat      Repeat
hi link rpgleSwitch      Label

hi link rpgleLabel Label
