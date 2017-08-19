" Vim syntax file
" Language:             Free RPG/ILE based on IBMi 7.1
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Aug 19, 2017
" Version:              53
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
syn region  rpgleDclList matchgroup=rpgleDclKeywords
                       \ start=/\<dcl-pi\>/
                       \ end=/\<end-pi\>/
                       \ contains=@rpgleDclProps
                       \ fold

" Prototype
syn region  rpgleDclList matchgroup=rpgleDclKeywords
                       \ start=/\<dcl-pr\>/
                       \ end=/\<end-pr\>/
                       \ contains=@rpgleDclProps

" Data Structure
syn region  rpgleDclList matchgroup=rpgleDclKeywords
                       \ start=/\<dcl-ds\>/
                       \ end=/\<\%(end-ds\|likeds\|likerec\)\>/
                       \ contains=@rpgleDclProps

" Declaration Types
syn keyword rpgleDclTypes contained BINDEC CHAR DATE DATE FLOAT GRAPH IND INT
                                  \ OBJECT PACKED POINTER TIMESTAMP TIME UCS2
                                  \ UCS2 UNS VARCHAR VARGRAPH VARUCS2 ZONED

" Declaration Keywords
syn keyword rpgleDclKeywords contained ALIAS ALIGN ALT ALTSEQ ASCEND BASED
                                     \ CCSID CLASS CONST CTDATA DATFMT DESCEND
                                     \ DIM DTAARA EXPORT EXT EXTFLD EXTFMT
                                     \ EXTNAME EXTPGM EXTPROC FROMFILE IMPORT
                                     \ INZ LEN LIKE LIKEDS LIKEFILE LIKEREC
                                     \ NOOPT NULLIND OCCURS OPDESC OPTIONS
                                     \ OVERLAY PACKEVEN PERRCD POS PREFIX
                                     \ PSDS QUALIFIED RTNPARM STATIC TEMPLATE
                                     \ TIMFMT TOFILE VALUE

" Declaration Constaints
syn keyword rpgleDclConstants contained *NOPASS *OMIT *VARSIZE *STRING
                                      \ *RIGHTADJ

syn cluster rpgleDclProps contains=rpgleComment,rpgleDclTypes,rpgleDclKeywords,rpgleDclConstants,rpgleNumber,rpgleString,rpgleConstant

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
syn keyword rpgleBIF %ABS %ADDR %ALLOC %BITAND %BITNOT %BITOR %BITXOR %CHAR
                   \ %CHECK %CHECKR %DATE %DAYS %DEC %DECH %DECPOS %DIFF %DIV
                   \ %EDITC %EDITFLT %EDITW %ELEM %EOF %EQUAL %ERROR %FIELDS
                   \ %FLOAT %FOUND %GRAPH %HANDLER %HOURS %INT %INTH %KDS
                   \ %LEN %LOOKUPxx %MAX %MIN %MINUTES %MONTHS %MSECONDS
                   \ %NULLIND %OCCUR %OPEN %PADDR %PARMNUM %PARMS %REALLOC
                   \ %REM %REPLACE %SCAN %SCANR %SCANRPL %SECONDS %SHTDN
                   \ %SIZE %SQRT %STATUS %STR %SUBARR %SUBDT %SUBST %THIS
                   \ %TIME %TIMESTAMP %TLOOKUPxx %TRIM %TRIML %TRIMR %UCS2
                   \ %UNS %UNSH %XFOOT %XLATE %XML %YEARS

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

hi link rpgleLabel         Label
hi link rpgleBIF           Function

" vim: foldmethod=marker
