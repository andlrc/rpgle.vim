" Vim syntax file
" Language:             Free RPGLE based on IBMi 7.1
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Sep 19, 2016
" Version:              25
" URL:                  https://github.com/andlrc/rpgle.vim

" quit when a syntax file was already loaded {{{1
if exists("b:current_syntax")
  finish
endif

syn include @rpgleSql syntax/sqlanywhere.vim

syn case ignore
let b:current_syntax = "rpgle"
setlocal iskeyword+=-

sy region rpgleInclude   start=/\v^\/(include|copy)/ end=/\v\ze\n(^\/(include|copy))@!/ extend fold
sy match  rpgleNumber    /\v<[0-9]+>/
sy region rpgleString    start=/'/hs=s+1  skip=/''/  end=/'/he=e-1
sy match  rpgleOperator  /\v(\*\*|\<\>|\>\=|\<\=|<NOT>|<AND>|<OR>|[-.*=><])/
sy match  rpgleProcedure /\v(\%)@<!<\w+\s*\ze\(/
sy match  rpgleComment   /\v\/\/.*/                                                  contains=rpgleTodo
sy region rpgleComment   start=/\v\/\*/              end=/\v\*\//                    contains=rpgleTodo
sy match  rpgleTodo      /\v(TODO|FIXME)/                                            contained
sy match  rpgleConstant  /\v\*(ON|OFF|ENTRY|ALL|BLANKS|BLANK|ZEROS|ZERO|HIVAL|LOVAL|NULL)>/
sy match  rpgleKeywords  /\v<(ctl-opt|exsr|return)>/

" if -> elseif -> else -> endif
sy region rpgleIf   matchgroup=rpgleConditional start=/\v<if>/ end=/\v<endif>/ contains=@rpgleNest extend fold
sy match  rpgleElse /\v<else>|<elseif>/

" do[uw] ... endd and for ... endfor
sy region rpgleDo  matchgroup=rpgleRepeat start=/\v<do[wu]>/ end=/\v<enddo>/  contains=@rpgleNest extend fold
sy region rpgleFor matchgroup=rpgleRepeat start=/\v<for>/    end=/\v<endfor>/ contains=@rpgleNest extend fold

" Monitor -> on-error -> endmon
sy region rpgleMonitor matchgroup=rpgleConditional start=/\v<monitor>/ end=/\v<endmon>/ contains=@rpgleNest,rpgleOnError extend fold
sy match  rpgleOnError /\v<on-error>/


" select -> when -> other -> endsl
sy region rpgleSelect matchgroup=rpgleSwitch start=/\v<select>/ end=/\v<endsl>/                          contains=rpgleWhen,rpgleOther extend fold
sy region rpgleWhen   matchgroup=rpgleSwitch start=/\v<when>/   end=/\v\ze\n\s*(<when>|<other>|<endsl>)/ contains=@rpgleNest extend fold contained
sy region rpgleOther  matchgroup=rpgleSwitch start=/\v<other>/  end=/\v\ze\n\s*<endsl>/                  contains=@rpgleNest extend fold contained

" Exec SQL
sy region rpgleSql matchgroup=rpgleLabel start=/\v<exec\_s+sql>/ end=/\v;/ contains=@rpgleSql

" dlc-proc, dcl-pi, begsr
sy region rpgleDclProc matchgroup=rpgleLabel start=/\v<dcl-proc>/ end=/\v<end-proc>/ contains=@rpgleNest,rpgleSub,rpgleDclList extend fold
sy region rpgleSub     matchgroup=rpgleLabel start=/\v<begsr>/    end=/\v<endsr>/    contains=@rpgleNest extend fold

" dcl-*
sy region  rpgleDclList       matchgroup=rpgleDclKeywords start=/\v<dcl-(s|c)>/ end=/\v\ze\n(.*dcl-(s|c)>)@!/      contains=@rpgleDclProps extend fold
sy region  rpgleDclList       matchgroup=rpgleDclKeywords start=/\v<dcl-pi>/    end=/\v<end-pi>/                   contains=@rpgleDclPiProps extend fold
sy region  rpgleDclList       matchgroup=rpgleDclKeywords start=/\v<dcl-pr>/    end=/\v<end-pr>/                   contains=@rpgleDclPrProps extend fold
sy region  rpgleDclList       matchgroup=rpgleDclKeywords start=/\v<dcl-ds>/    end=/\v(<end-ds>|\ze\n(.*dcl-)@=)/ contains=@rpgleDclDsProps extend fold

sy match   rpgleDclTypes      /\v<(dim|like|likeds|char|varchar|ucs2|varucs2|graph|vargraph|packed|zoned|bindec|int|uns|float|date|time|pointer|object|const)>\s*\ze\(/ extend contained
sy match   rpgleDclTypes      /\v<(ind|date|time|timestamp|pointer)/        extend contained
sy match   rpgleDclKeywords   /\v<(dcl-(s|c|pr|ds)|end-(pr|cs)|inz)>/       extend contained
sy cluster rpgleDclProps      contains=rpgleDclTypes,rpgleDclKeywords,rpgleNumber,rpgleString,rpgleConstant

sy match   rpgleDclPiType     /\v<(extproc|options)>\s*\ze\(/               extend contained
sy match   rpgleDclPiKeywords /\v<(options)>\s*\ze\(/                       extend contained
sy match   rpgleDclPiKeywords /\v<(value|const)>/                           extend contained
sy match   rpgleDclPiConstant /\v\*<(nopass|omit|varsize|string|rightadj)>/ extend contained
sy cluster rpgleDclPiProps    contains=@rpgleDclProps,rpgleDclPrKeywords,rpgleDclPrConstant

sy match   rpgleDclPrType     /\v<(extproc)>\s*\ze\(/                       extend contained
sy match   rpgleDclPrKeywords /\v<(options)>\s*\ze\(/                       extend contained
sy match   rpgleDclPrKeywords /\v<(value|const)>/                           extend contained
sy match   rpgleDclPrConstant /\v\*<(nopass|omit|varsize|string|rightadj)>/ extend contained
sy cluster rpgleDclPrProps    contains=@rpgleDclProps,rpgleDclPrType,rpgleDclPrKeywords,rpgleDclPrConstant

sy match   rpgleDclDsType     /\v<(likerec|len|extName|based)>\s*\ze\(/     extend contained
sy match   rpgleDclDsKeywords /\v<qualified>/                               extend contained
sy cluster rpgleDclDsProps    contains=@rpgleDclProps,rpgleDclDsType,rpgleDclDsKeywords


" Build In Functions
sy match  rpgleBIF /\v\%(ABS|ADDR|ALLOC|CHAR|CHECK|CHECKR|DATE|DAYS|DEC|DECH|DECPOS|DIFF|DIV|EDITC|EDITFLT|EDITW|ELEM|EOF|EQUAL|ERROR|FLOAT|FOUND|GRAPH|HOURS|INT|INTH|LEN|LOOKUPxx|MINUTES|MONTHS|MSECONDS|NULLIND|OCCUR|OPEN|PADDR|PARMS|REALLOC|REM|REPLACE|SCAN|SECONDS|SHTDN|SIZE|SQRT|STATUS|STR|SUBDT|SUBST|THIS|TIME|TIMESTAMP|TLOOKUPxx|TRIM|TRIML|TRIMR|UCS2|UNS|UNSH|XFOOT|XLATE|YEARS)/

" All the groups than can be nested, eg. doesn't need to be on the outer most layer
sy cluster rpgleNest contains=rpgleNumber,rpgleString,rpgleOperator,rpgleProcedure,rpgleComment,rpgleIf,rpgleElseIf,rpgleElse,rpgleDo,rpgleFor,rpgleMonitor,rpgleSelect,rpgleKeywords,rpgleConstant,rpgleBIF,rpgleSql

hi link rpgleInclude       Include

hi link rpgleNumber        Number
hi link rpgleString        String
hi link rpgleOperator      Operator
hi link rpgleProcedure     Function
hi link rpgleComment       Comment
hi link rpgleTodo          Todo
hi link rpgleConstant      Constant

hi link rpgleElse          rpgleConditional
hi link rpgleConditional   Conditional

hi link rpgleRepeat        Repeat

hi link rpgleOnError       Label

hi link rpgleSwitch        Label

hi link rpgleKeywords      Keyword

hi link rpgleDclTypes      Type
hi link rpgleDclKeywords   Keyword

hi link rpgleDclPiType     Type
hi link rpgleDclPiKeywords Keyword
hi link rpgleDclPiConstant Constant

hi link rpgleDclPrType     Type
hi link rpgleDclPrKeywords Keyword
hi link rpgleDclPrConstant Constant

hi link rpgleDclDsType     Type
hi link rpgleDclDsKeywords Keyword

hi link rpgleLabel         Label
hi link rpgleBIF           Function
