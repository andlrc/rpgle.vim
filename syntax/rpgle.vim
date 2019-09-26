" Vim syntax file
" Language:             Free-Form ILE RPG
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Sep 26, 2019
" Version:              79
" URL:                  https://github.com/andlrc/rpgle.vim

if exists('b:current_syntax')
  finish
endif

let b:current_syntax = 'rpgle'

syntax include @rpgleSql syntax/sqlanywhere.vim

syntax case ignore
syntax iskeyword @,48-57,192-255,-,%,*,/,_

" Comments {{{

syntax match   rpgleLineComment      '//.*'
                                   \ contains=@rpgleCommentProps
syntax region  rpgleBracketedComment start='/\*'
                                   \ end='\*/'
                                   \ contains=@rpgleCommentProps
syntax cluster rpgleComment          contains=rpgleLineComment,rpgleBracketedComment

syntax cluster rpgleCommentProps contains=rpgleTodo,@Spell
syntax keyword rpgleTodo         contained TODO FIXME

" }}}
" Compiler directive {{{

syntax keyword rpglePreProc **FREE

syntax keyword rpglePreProc /COPY /DEFINE /EJECT /ELSE /ELSEIF /END-FREE
                          \ /ENDIF /EOF /FREE /IF /INCLUDE /RESTORE /SET
                          \ /SPACE /TITLE /UNDEFINE /SET

" }}}
" Header Specs {{{

" CTL-OPT ... ;
syntax region rpgleCtlSpec   matchgroup=rpgleKeywords
                           \ start=/\<CTL-OPT\>/
                           \ end=/;/
                           \ contains=@rpgleCtlProps
syntax cluster rpgleCtlProps contains=rpgleCtlKeywords,rpgleNumber,
                                     \@rpgleString,rpgleConstant,rpgleError,
                                     \rpgleCtlParanBalance

syntax region rpgleCtlParanBalance matchgroup=xxx
                                 \ start=/(/
                                 \ end=/)/
                                 \ contains=@rpgleCtlProps

" Header Keywords
syntax keyword rpgleCtlKeywords contained
                              \ ALLOC ACTGRP ALTSEQ ALWNULL AUT BNDDIR CCSID
                              \ CCSIDCVT COPYNEST COPYRIGHT CURSYM CVTOPT
                              \ DATEDIT DATFMT DCLOPT DEBUG DECEDIT DECPREC
                              \ DFTACTGRP DFTNAME ENBPFRCOL EXPROPTS
                              \ EXTBININT  FIXNBR FLYDIV FORMSALIGN FTRANS
                              \ GENLVL INDENT  INTPREC LANGID MAIN NOMAIN
                              \ OPENOPT OPTIMIZE  OPTION PGMINFO PRFDTA
                              \ SRTSEQ STGMDL TEXT THREAD  TIMFMT TRUNCNBR
                              \ USERPRF VALIDATE

" }}}
" Declaration Specs {{{

" Numbers and Strings

syntax match   rpgleNumber display
                         \ /\<\%(\d\+\.\d\+\|\.\d\+\|\d\+\.\|\d\+\)\>/

syntax match   rpgleError  /'\_.\{-}'/
syntax match   rpgleString /'\([+-]\n\|''\|[^']\)*'/
syntax cluster rpgleString contains=rpgleString

if get(g:, 'rpgle_spellString', 1)
  syntax cluster rpgleStringProps contains=@Spell,rpgleStringTermError
else
  syntax cluster rpgleStringProps contains=rpgleStringTermError
endif

" Constants
syntax keyword rpgleConstant *ALL *BLANK *BLANKS *ENTRY *HIVAL *LOVAL *NULL
                           \ *OFF *ON *ZERO *ZEROS

" *IN01 .. *IN99, *INH1 .. *INH9, *INL1 .. *INL9, *INLR, *INRT
syntax match   rpgleSpecialKey display /\%(\*IN0[1-9]\|\*IN[1-9][0-9]\)/
syntax match   rpgleSpecialKey display /\*INH[1-9]/
syntax match   rpgleSpecialKey display /\*INL[1-9]/
syntax match   rpgleSpecialKey display /\*INU[1-8]/
syntax keyword rpgleSpecialKey *INLR *INRT

" Operators
syntax match   rpgleOperator display /<>/
syntax match   rpgleOperator display />=/
syntax match   rpgleOperator display /<=/
syntax match   rpgleOperator display /[*=><+-]/

" Standalone, Constant
syntax region  rpgleDclSpec display matchgroup=rpgleDclKeywords
                          \ start=/\<DCL-[SC]\>/
                          \ end=/$/
                          \ contains=@rpgleDclProps

" Procedure Interface
syntax keyword rpgleError END-PI
syntax region  rpgleDclSpec   matchgroup=rpgleDclKeywords
                            \ start=/\<DCL-PI\>/
                            \ end=/\<END-PI\>/
                            \ contains=@rpgleDclProps,rpgleDclPiName
                            \ fold

" Special PI Name
syntax keyword rpgleDclPiName *N

" Prototype
syntax keyword rpgleError END-PR
syntax region  rpgleDclSpec matchgroup=rpgleDclKeywords
                          \ start=/\<DCL-PR\>/
                          \ end=/\<END-PR\>/
                          \ contains=@rpgleDclProps

" Data Structure
syntax keyword rpgleError LIKEDS LIKEREC END-DS
syntax region  rpgleDclSpec matchgroup=rpgleDclKeywords
                          \ start=/\<DCL-DS\>/
                          \ end=/\<\%(END-DS\|\%(DCL-DS.*\)\@<=LIKEDS\|\%(DCL-DS.*\)\@<=LIKEREC\)\>/
                          \ contains=@rpgleDclProps

" Declaration Types
syntax keyword rpgleDclTypes contained
                           \ BINDEC CHAR DATE DATE FLOAT GRAPH IND INT OBJECT
                           \ PACKED POINTER TIME TIMESTAMP UCS2 UCS2 UNS
                           \ VARCHAR VARGRAPH VARUCS2 ZONED

" Declaration Keywords
syntax keyword rpgleDclKeywords contained
                              \ ALIAS ALIGN ALT ALTSEQ ASCEND BASED CCSID
                              \ CLASS CONST CTDATA DATFMT DESCEND DIM DTAARA
                              \ EXPORT EXT EXTFLD EXTFMT EXTNAME EXTPGM
                              \ EXTPROC FROMFILE IMPORT INZ LEN LIKE LIKEDS
                              \ LIKEFILE LIKEREC NOOPT NULLIND OCCURS OPDESC
                              \ OPTIONS OVERLAY PACKEVEN PERRCD POS PREFIX
                              \ PSDS QUALIFIED RTNPARM STATIC TEMPLATE TIMFMT
                              \ TOFILE VALUE

" Declaration Constants
syntax keyword rpgleDclSpecialKeys contained
                               \ *NOPASS *OMIT *VARSIZE *STRING *RIGHTADJ

syntax region rpgleDclParenBalance matchgroup=xxx
                                 \ start=/(/
                                 \ end=/)/
                                 \ contains=@rpgleDclProps

syntax cluster rpgleDclProps contains=@rpgleComment,rpgleDclTypes,
                                     \rpgleDclKeywords,rpgleDclSpecialKeys,
                                     \rpgleNumber,@rpgleString,rpgleConstant,
                                     \rpgleError,rpgleDclParenBalance,rpgleBIF

" }}}
" Calculation Specs {{{

" IF ... ENDIF
syntax keyword rpgleError ENDIF
syntax region  rpgleIf   matchgroup=rpgleConditional
                       \ start=/\<IF\>/
                       \ end=/\<ENDIF\>/
                       \ contains=@rpgleNest,rpgleElse
                       \ fold

" ELSE ELSEIF
syntax keyword rpgleError ELSE ELSEIF
syntax keyword rpgleElse contained ELSE ELSEIF

" NOT, AND, OR
syntax keyword rpgleConditional NOT AND OR

" DOW .. ENDDO, DOU .. ENDDO
syntax keyword rpgleError ENDDO
syntax region  rpgleDo matchgroup=rpgleRepeat
                     \ start=/\<DO[WU]\>/
                     \ end=/\<ENDDO\>/
                     \ contains=@rpgleNest
                     \ fold

" FOR ... ENDFOR
syntax region  rpgleFor matchgroup=rpgleRepeat
                      \ start=/\<FOR\>/
                      \ end=/\<ENDFOR\>/
                      \ contains=@rpgleNest
                      \ fold
syntax keyword rpgleError ENDFOR

" ITER, LEAVE
syntax keyword rpgleRepeat contained ITER LEAVE

" MONITOR ... ENDMON
syntax keyword rpgleError ENDMON
syntax region  rpgleMonitor matchgroup=rpgleConditional
                          \ start=/\<MONITOR\>/
                          \ end=/\<ENDMON\>/
                          \ contains=@rpgleNest,rpgleOnError
                          \ fold

" ON-ERROR
syntax keyword rpgleError ON-ERROR
syntax keyword rpgleOnError contained ON-ERROR

" SELECT ... ENDSL
syntax keyword rpgleError ENDSL
syntax region  rpgleSelect    matchgroup=rpgleKeywords
                            \ start=/\<SELECT\>/
                            \ end=/\<ENDSL\>/
                            \ contains=@rpgleNest,rpgleWhenOther
                            \ fold

" WHEN, OTHER
syntax keyword rpgleError WHEN OTHER
syntax keyword rpgleWhenOther contained WHEN OTHER

" Exec SQL
syntax region rpgleSql matchgroup=rpgleKeywords
                     \ start=/\<EXEC\_s\+SQL\>/
                     \ end=/;/
                     \ contains=@rpgleSql

" Build In Functions
syntax match rpgleError /%\w\+/

syntax keyword rpgleBIF %ABS
                      \ %ADDR
                      \ %ALLOC
                      \ %BITAND
                      \ %BITNOT
                      \ %BITOR
                      \ %BITXOR
                      \ %CHAR
                      \ %CHECK
                      \ %CHECKR
                      \ %DATA
                      \ %DATE
                      \ %DAYS
                      \ %DEC
                      \ %DECH
                      \ %DECPOS
                      \ %DIFF
                      \ %DIV
                      \ %EDITC
                      \ %EDITFLT
                      \ %EDITW
                      \ %ELEM
                      \ %EOF
                      \ %EQUAL
                      \ %ERROR
                      \ %FIELDS
                      \ %FLOAT
                      \ %FOUND
                      \ %GRAPH
                      \ %HANDLER
                      \ %HOURS
                      \ %INT
                      \ %INTH
                      \ %KDS
                      \ %LEN
                      \ %LOOKUPxx
                      \ %MAX
                      \ %MIN
                      \ %MINUTES
                      \ %MONTHS
                      \ %MSECONDS
                      \ %NULLIND
                      \ %OCCUR
                      \ %OPEN
                      \ %PADDR
                      \ %PARMS
                      \ %PARMNUM
                      \ %PARSER
                      \ %PROC
                      \ %REALLOC
                      \ %REM
                      \ %REPLACE
                      \ %SCAN
                      \ %SCANR
                      \ %SCANRPL
                      \ %SECONDS
                      \ %SHTDN
                      \ %SIZE
                      \ %SQRT
                      \ %STATUS
                      \ %STR
                      \ %SUBARR
                      \ %SUBDT
                      \ %SUBST
                      \ %THIS
                      \ %TIME
                      \ %TIMESTAMP
                      \ %TLOOKUPxx
                      \ %TRIM
                      \ %TRIML
                      \ %TRIMR
                      \ %UCS2
                      \ %UNS
                      \ %UNSH
                      \ %XFOOT
                      \ %XLATE
                      \ %XML
                      \ %YEARS

" Procedures, the match group is to avoid infinite recursion as a
" ``rpgleProcCall'' can be within another ``rpgleProcCall''
syntax match rpgleError /)/
syntax region  rpgleProcCall matchgroup=xxx
                           \ start=/%\@1<!\<\w\+(/
                           \ end=/)/
                           \ contains=@rpgleProcArgs

syntax cluster rpgleProcArgs contains=rpgleBIF,@rpgleComment,rpgleConstant,
                                     \rpgleNumber,rpglePreProc,rpgleProcCall,
                                     \rpgleProcOmit,rpgleSpecialKey,
                                     \@rpgleString,rpgleError,rpgleParenBalance
syntax keyword rpgleProcOmit contained *OMIT
syntax keyword rpgleKeywords RETURN

" BEGSR .. ENDSR
syntax keyword rpgleError ENDSR
syntax region rpgleSub matchgroup=rpgleKeywords
                     \ start=/\<BEGSR\>/
                     \ end=/\<ENDSR\>/
                     \ contains=@rpgleNest
                     \ fold

" EXSR
syntax keyword rpgleKeywords EXSR

" }}}
" Procedure Specs {{{

syntax region  rpgleDclProcBody   matchgroup=rpgleDclProc
                                \ start=/\<DCL-PROC\>/
                                \ end=/\<END-PROC\>/
                                \ contains=@rpgleDclProcNest
                                \ fold
syntax cluster rpgleDclProcNest   contains=@rpgleNest,rpgleSub,rpgleDclSpec,
                                         \rpgleDclProcName,rpgleError
syntax keyword rpgleError END-PROC

" Procedure Name
syntax match   rpgleDclProcName   display contained skipwhite
                                \ /\%(DCL-PROC\s\+\)\@10<=\w\+/
                                \ nextgroup=rpgleDclProcExport

" Export
syntax keyword rpgleDclProcExport contained EXPORT

" }}}

syntax region rpgleParenBalance matchgroup=xxx
                              \ start=/(/
                              \ end=/)/
                              \ contains=@rpgleNest

" All nestable groups, i.e. mostly Calculation Spec keywords:
syntax cluster rpgleNest contains=rpgleBIF,@rpgleComment,rpgleConditional,
                                 \rpgleConstant,rpgleDo,rpgleFor,rpgleIf,
                                 \rpgleKeywords,rpgleMonitor,rpgleNumber,
                                 \rpgleOperator,rpglePreProc,rpgleProcCall,
                                 \rpgleRepeat,rpgleSelect,rpgleSpecialKey,
                                 \rpgleSql,@rpgleString,rpgleError,
                                 \rpgleParenBalance

syntax sync fromstart

highlight link rpgleError            Error
highlight link rpglePreProc          PreProc
highlight link rpgleProc             Function
highlight link rpgleSpecialKey       SpecialKey
highlight link rpgleNumber           Number
highlight link rpgleString           String
highlight link rpgleOperator         Operator
highlight link rpgleComment          Comment
highlight link rpgleTodo             Todo
highlight link rpgleConstant         Constant
highlight link rpgleConditional      Conditional
highlight link rpgleRepeat           Repeat
highlight link rpgleKeywords         Keyword
highlight link rpgleSpecial          Special
highlight link rpgleTypes            Type

highlight link rpgleLineComment      rpgleComment
highlight link rpgleBracketedComment rpgleComment

highlight link rpgleProcOmit         rpgleSpecialKey
highlight link rpgleCtlKeywords      rpgleKeywords
highlight link rpgleDclTypes         rpgleTypes
highlight link rpgleDclKeywords      rpgleKeywords
highlight link rpgleDclProc          rpgleKeywords
highlight link rpgleDclProcExport    rpgleKeywords
highlight link rpgleDclProcName      rpgleProc
highlight link rpgleDclPiName        rpgleSpecial
highlight link rpgleDclSpecialKeys   rpgleSpecialKey
highlight link rpgleElse             rpgleConditional
highlight link rpgleOnError          rpgleKeywords
highlight link rpgleWhenOther        rpgleKeywords
highlight link rpgleBIF              rpgleSpecial

" vim: foldmethod=marker
