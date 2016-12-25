" Vim syntax file
" Language:             Free RPGLE based on IBMi 7.1
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Dec 25, 2016
" Version:              37
" URL:                  https://github.com/andlrc/rpgle.vim

if exists("b:current_syntax")
  finish
endif

syn include @rpgleSql syntax/sqlanywhere.vim

syn case ignore
let b:current_syntax = "rpgle"
setlocal iskeyword+=-

sy match  rpgleNumber     '\<[[:digit:]]\{1,}\%(\.[[:digit:]]*\)\=\>'
sy region rpgleString     start=/'/ skip=/''/ end=/'/
sy match  rpgleOperator   /\%(\*\*\|<>\|>=\|<=\|<NOT>\|<AND>\|<OR>\|[-.*=><]\)/
sy match  rpgleComment    '//.*' contains=rpgleTodo
sy region rpgleComment    start='/\*' end='*\/' contains=rpgleTodo
sy match  rpgleTodo       /\%(TODO\|FIXME\)/ contained
sy match  rpgleConstant   /\*\%(ON\|OFF\|ENTRY\|ALL\|BLANKS\|BLANK\|ZEROS\|ZERO\|HIVAL\|LOVAL\|NULL\)\>/
sy match  rpgleIdentifier /\*\%(IN0[1-9]\|IN[1-9][0-9]\|INH[1-9]\|INL[1-9]\|INLR\|INU[1-8]\|INRT\)\>/
sy match  rpgleKeywords   /^\s*\zs\%(ctl-opt\|exsr\|return\)\>/
sy match  rpgleInclude    '^/\%(include\|copy\)'
sy match  rpgleProcedure  '\%([^%]\|^\)\zs\<\w\+\>\ze('

" if -> elseif -> else -> endif
sy region rpgleIf   matchgroup=rpgleConditional start=/\<if\>/ end=/\<endif\>/ contains=@rpgleNest extend fold
sy match  rpgleElse /\<else\>\|\<elseif\>/

" do[uw] ... endd and for ... endfor
sy region rpgleDo  matchgroup=rpgleRepeat start=/\<do[wu]\>/ end=/\<enddo\>/  contains=@rpgleNest extend fold
sy region rpgleFor matchgroup=rpgleRepeat start=/\<for\>/    end=/\<endfor\>/ contains=@rpgleNest extend fold

" Monitor -> on-error -> endmon
sy region rpgleMonitor matchgroup=rpgleConditional start=/\<monitor\>/ end=/\<endmon\>/ contains=@rpgleNest,rpgleOnError extend fold
sy match  rpgleOnError /\<on-error\>/


" select -> when -> other -> endsl
sy region rpgleSelect matchgroup=rpgleSwitch start=/\<select\>/ end=/\<endsl\>/                           contains=rpgleWhen,rpgleOther extend fold
sy region rpgleWhen   matchgroup=rpgleSwitch start=/\<when\>/   end=/\ze\n\s*\<\%(when\|other\|endsl\)\>/ contains=@rpgleNest extend contained
sy region rpgleOther  matchgroup=rpgleSwitch start=/\<other\>/  end=/\ze\n\s*\<endsl\>/                   contains=@rpgleNest extend contained

" Exec SQL
sy region rpgleSql matchgroup=rpgleLabel start=/\<exec\_s\+sql\>/ end=/;/ contains=@rpgleSql

" dlc-proc, begsr
sy region rpgleDclProc matchgroup=rpgleLabel start=/\<dcl-proc\>/ end=/\<end-proc\>/ contains=@rpgleNest,rpgleSub,rpgleDclList extend fold
sy region rpgleSub     matchgroup=rpgleLabel start=/\<begsr\>/    end=/\<endsr\>/    contains=@rpgleNest extend fold

" dcl-*
sy region  rpgleDclList matchgroup=rpgleDclKeywords start=/\<dcl-[sc]\>/  end=/$/                       contains=@rpgleDclProps extend
sy region  rpgleDclList matchgroup=rpgleDclKeywords start=/\<dcl-pi\>/    end=/\<end-pi\>/              contains=@rpgleDclPiProps extend
sy region  rpgleDclList matchgroup=rpgleDclKeywords start=/\<dcl-pr\>/    end=/\<end-pr\>/              contains=@rpgleDclPrProps extend
sy region  rpgleDclList matchgroup=rpgleDclKeywords start=/\<dcl-ds\>/    end=/\<\%(end-ds\|likeds\)\>/ contains=@rpgleDclDsProps extend

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
sy match  rpgleBIF /%\%(YEARS\|XLATE\|XFOOT\|UNSH\|UNS\|UCS2\|TRIMR\|TRIML\|TRIM\|TLOOKUP\|TIMESTAMP\|TIME\|THIS\|SUBST\|SUBDT\|STR\|STATUS\|SQRT\|SIZE\|SHTDN\)/
sy match  rpgleBIF /%\%(SECONDS\|SCAN\|REPLACE\|REM\|REALLOC\|PARMS\|PADDR\|OPEN\|OCCUR\|NULLIND\|MSECONDS\|MONTHS\|MINUTES\|LOOKUP\|LEN\|INTH\|INT\|HOURS\|GRAPH FOUND\)/
sy match  rpgleBIF /%\%(FLOAT\|ERROR\|EQUAL\|EOF\|ELEM\|EDITW\|EDITFLT\|EDITC\|DIV\|DIFF\|DECPOS\|DECH\|DEC\|DAYS\|DATE\|CHECKR\|CHECK\|CHAR\|ALLOC\|ADDR\|ABS\)/

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
hi link rpgleIdentifier    Identifier

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
