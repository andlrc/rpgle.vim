" Vim syntax file
" Language:             Free RPG/ILE based on IBMi 7.1
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Aug 19, 2017
" Version:              52
" URL:                  https://github.com/andlrc/rpgle.vim

if exists("b:current_syntax")
  finish
endif

syn include @rpgleSql syntax/sqlanywhere.vim

syn case ignore
let b:current_syntax = "rpgle"
syn iskeyword @,48-57,192-255,-,%,*

" Comments {{{

syn match   rpgleComment '//.*' contains=rpgleTodo,@Spell
syn region  rpgleComment start='/\*' end='\*/' contains=rpgleTodo,@Spell
syn keyword rpgleTodo    contained TODO FIXME

" }}}
" Compiler directive {{{

syn match rpgleInclude '^/\s*\zs\%(include\|copy\)'

" }}}
" Header Specs {{{

syn keyword rpgleKeywords CTL-OPT

" }}}
" Declaration Specs {{{

" Numbers and Strings
syn match   rpgleNumber '\<[[:digit:]]\{1,}\%(\.[[:digit:]]*\)\=\>'
syn region  rpgleString start=/'/
                      \ skip=/''\|[+-]$/
                      \ end=/'\|$/
                      \ contains=@Spell

" Constants
syn keyword rpgleConstant *ON *OFF *ENTRY *ALL *BLANKS *BLANK
                        \ *ZEROS *ZERO *HIVAL *LOVAL *NULL

" *IN01 .. *IN99, *INH1 .. *INH9, *INL1 .. *INL9, *INLR, *INRT
syn match   rpgleIdentifier /\%(\*IN0[1-9]\|\*IN[1-9][0-9]\)/
syn match   rpgleIdentifier /\*INH[1-9]/
syn match   rpgleIdentifier /\*INL[1-9]/
syn match   rpgleIdentifier /\*INU[1-8]/
syn keyword rpgleIdentifier *INLR *INRT

" Operators
syn match   rpgleOperator /\*\*\|<>\|>=\|<=\|[-.*=><]/

" Standalone, Constant
syn region  rpgleDclList matchgroup=rpgleDclKeywords
                       \ start=/\<dcl-[sc]\>/
                       \ end=/$/
                       \ contains=@rpgleDclProps

" Procedure Interface
syn region  rpgleDclList       matchgroup=rpgleDclKeywords
                             \ start=/\<dcl-pi\>/
                             \ end=/\<end-pi\>/
                             \ contains=@rpgleDclPiProps
                             \ fold
syn keyword rpgleDclPiKeywords contained EXTPROC OPTIONS VALUE CONST
syn keyword rpgleDclPiConstant contained *NOPASS *OMIT *VARSIZE *STRING
                                       \ *RIGHTADJ
syn cluster rpgleDclPiProps    contains=@rpgleDclProps,rpgleDclPrKeywords,rpgleDclPrConstant

" Prototype
syn region  rpgleDclList       matchgroup=rpgleDclKeywords
                             \ start=/\<dcl-pr\>/
                             \ end=/\<end-pr\>/
                             \ contains=@rpgleDclPrProps
syn keyword rpgleDclPrKeywords contained EXTPROC OPTIONS VALUE CONST
syn keyword rpgleDclPrConstant contained *NOPASS *OMIT *VARSIZE *STRING
                                       \ *RIGHTADJ
syn cluster rpgleDclPrProps    contains=@rpgleDclProps,rpgleDclPrKeywords,rpgleDclPrConstant

" Data Structure
syn region  rpgleDclList       matchgroup=rpgleDclKeywords
                             \ start=/\<dcl-ds\>/
                             \ end=/\<\%(end-ds\|likeds\|likerec\)\>/
                             \ contains=@rpgleDclDsProps
syn keyword rpgleDclDsKeywords contained LIKEREC LEN EXTNAME BASED QUALIFIED
syn cluster rpgleDclDsProps    contains=@rpgleDclProps,rpgleDclDsKeywords

" Declaration Types
syn keyword rpgleDclTypes contained BINDEC INT UNS FLOAT DATE TIME POINTER
                                  \ OBJECT CONST DIM LIKE LIKEDS CHAR
                                  \ VARCHAR UCS2 VARUCS2 GRAPH VARGRAPH
                                  \ PACKED ZONED IND DATE TIMESTAMP TIME
                                  \ POINTER
" INZ Keyword
syn keyword rpgleDclKeywords contained INZ

syn cluster rpgleDclProps    contains=rpgleComment,rpgleDclTypes,rpgleDclKeywords,rpgleNumber,rpgleString,rpgleConstant

" }}}
" Calculation Specs {{{

" IF -> ELSEIF -> ELSE -> ENDIF
syn region  rpgleIf   matchgroup=rpgleConditional
                    \ start=/\<if\>/
                    \ end=/\<endif\>/
                    \ contains=@rpgleNest,rpgleElse
                    \ fold
syn keyword rpgleElse contained else elseif

" NOT, AND, OR
syn keyword rpgleConditional NOT AND OR

" DOW .. ENDDO, DOU .. ENDDO
syn region  rpgleDo matchgroup=rpgleRepeat
                  \ start=/\<do[wu]\>/
                  \ end=/\<enddo\>/
                  \ contains=@rpgleNest
                  \ fold

" FOR ... ENDFOR
syn region  rpgleFor matchgroup=rpgleRepeat
                   \ start=/\<for\>/
                   \ end=/\<endfor\>/
                   \ contains=@rpgleNest
                   \ fold

" ITER, LEAVE
syn keyword rpgleRepeat contained ITER LEAVE

" Monitor -> on-error -> endmon
syn region  rpgleMonitor matchgroup=rpgleConditional
                       \ start=/\<monitor\>/
                       \ end=/\<endmon\>/
                       \ contains=@rpgleNest,rpgleOnError
                       \ fold
syn keyword rpgleOnError contained ON-ERROR

" select -> when -> other -> endsl
syn region rpgleSelect matchgroup=rpgleSwitch
                     \ start=/\<select\>/
                     \ end=/\<endsl\>/
                     \ contains=rpgleWhen,rpgleOther
                     \ fold
syn region rpgleWhen   matchgroup=rpgleSwitch
                     \ start=/\<when\>/
                     \ end=/\ze\n\s*\<\%(when\|other\|endsl\)\>/
                     \ contains=@rpgleNest
                     \ contained
syn region rpgleOther  matchgroup=rpgleSwitch
                     \ start=/\<other\>/
                     \ end=/\ze\n\s*\<endsl\>/
                     \ contains=@rpgleNest
                     \ contained

" Build In Functions
syn keyword rpgleBIF %YEARS %XLATE %XFOOT %UNSH %UNS %UCS2 %TRIMR %TRIML %TRIM
                   \ %TLOOKUP %TIMESTAMP %TIME %THIS %SUBST %SUBDT %STR %STATUS
                   \ %SQRT %SIZE %SHTDN %ECONDS %SCANRPL %SCANR %SCAN %REPLACE
                   \ %REM %REALLOC %PARMS %PADDR %OPEN %OCCUR %NULLIND
                   \ %MSECONDS %MONTHS %MINUTES %LOOKUP %LEN %INTH %INT %HOURS
                   \ %GRAPH %FOUND %LOAT %ERROR %EQUAL %EOF %ELEM %EDITW
                   \ %EDITFLT %EDITC %DIV %DIFF %DECPOS %DECH %DEC %DAYS %DATE
                   \ %CHECKR %CHECK %CHAR %ALLOC %ADDR %ABS %ITAND %BITNOT
                   \ %BITOR %BITXOR

" Exec SQL
syn region rpgleSql matchgroup=rpgleLabel
                  \ start=/\<exec\_s\+sql\>/
                  \ end=/;/
                  \ contains=@rpgleSql

" Procedures
syn match   rpgleProcedure '%\@1<!\<\w\+\>\ze('
syn keyword rpgleKeywords  RETURN

" BEGSR .. ENDSR
syn region rpgleSub matchgroup=rpgleLabel
                  \ start=/\<begsr\>/
                  \ end=/\<endsr\>/
                  \ contains=@rpgleNest
                  \ fold

" EXSR
syn keyword rpgleKeywords EXSR

" }}}
" Prodecure Specs {{{

syn region rpgleDclProc matchgroup=rpgleLabel
                      \ start=/\<dcl-proc\>/ end=/\<end-proc\>/
                      \ contains=@rpgleNest,rpgleSub,rpgleDclList
                      \ fold

" }}}

" All nestable groups, i.e. mostly Calculation Spec keywords:
syn cluster rpgleNest contains=rpgleNumber,rpgleString,rpgleOperator,rpgleProcedure,rpgleComment,rpgleIf,rpgleDo,rpgleFor,rpgleRepeat,rpgleMonitor,rpgleSelect,rpgleKeywords,rpgleConstant,rpgleBIF,rpgleSql

syn sync fromstart

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

hi link rpgleDclPiKeywords Keyword
hi link rpgleDclPiConstant Constant

hi link rpgleDclPrKeywords Keyword
hi link rpgleDclPrConstant Constant

hi link rpgleDclDsKeywords Keyword

hi link rpgleLabel         Label
hi link rpgleBIF           Function

" vim: foldmethod=marker
