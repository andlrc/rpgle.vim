" Vim syntax file
" Language:             Free RPG/ILE based on IBMi 7.1
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Aug 20, 2017
" Version:              57
" URL:                  https://github.com/andlrc/rpgle.vim

if exists("b:current_syntax")
  finish
endif

let b:current_syntax = "rpgle"

syntax include @rpgleSql syntax/sqlanywhere.vim

syntax case ignore
syntax iskeyword @,48-57,192-255,-,%,*

" Comments {{{

syntax match   rpgleComment '//.*' contains=rpgleTodo,@Spell
syntax region  rpgleComment start='/\*' end='\*/' contains=rpgleTodo,@Spell
syntax keyword rpgleTodo    contained TODO FIXME

" }}}
" Compiler directive {{{

syntax match rpgleInclude '^/\_s*\zs\%(INCLUDE\|COPY\)'

" }}}
" Header Specs {{{

" CTL-OPT ... ;
syntax region rpgleCtlSpec matchgroup=rpgleKeywords
                         \ start=/\<CTL-OPT\>/
                         \ end=/;/
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

syntax cluster rpgleCtlProps contains=rpgleCtlKeywords,rpgleNumber,
                                     \rpgleString,rpgleConstant

" }}}
" Declaration Specs {{{

" Numbers and Strings
syntax match   rpgleNumber '\<[[:digit:]]\{1,}\%(\.[[:digit:]]*\)\=\>'
syntax region  rpgleString start=/'/
                         \ skip=/''\|[+-]$/
                         \ end=/'\|$/
                         \ contains=@Spell

" Constants
syntax keyword rpgleConstant *ON *OFF *ENTRY *ALL *BLANKS *BLANK *ZEROS *ZERO
                           \ *HIVAL *LOVAL *NULL

" *IN01 .. *IN99, *INH1 .. *INH9, *INL1 .. *INL9, *INLR, *INRT
syntax match   rpgleIdentifier /\%(\*IN0[1-9]\|\*IN[1-9][0-9]\)/
syntax match   rpgleIdentifier /\*INH[1-9]/
syntax match   rpgleIdentifier /\*INL[1-9]/
syntax match   rpgleIdentifier /\*INU[1-8]/
syntax keyword rpgleIdentifier *INLR *INRT

" Operators
syntax match   rpgleOperator /\*\*\|<>\|>=\|<=\|[.*=><+-]/

" Standalone, Constant
syntax region  rpgleDclSpec matchgroup=rpgleDclKeywords
                          \ start=/\<DCL-[SC]\>/
                          \ end=/$/
                          \ contains=@rpgleDclProps

" Procedure Interface
syntax region  rpgleDclSpec matchgroup=rpgleDclKeywords
                          \ start=/\<DCL-PI\>/
                          \ end=/\<END-PI\>/
                          \ contains=@rpgleDclProps
                          \ fold

" Prototype
syntax region  rpgleDclSpec matchgroup=rpgleDclKeywords
                          \ start=/\<DCL-PR\>/
                          \ end=/\<END-PR\>/
                          \ contains=@rpgleDclProps

" Data Structure
syntax region  rpgleDclSpec matchgroup=rpgleDclKeywords
                          \ start=/\<DCL-DS\>/
                          \ end=/\<\%(END-DS\|LIKEDS\|LIKEREC\)\>/
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

" Declaration Constaints
syntax keyword rpgleDclConstants contained
                               \ *NOPASS *OMIT *VARSIZE *STRING *RIGHTADJ

syntax cluster rpgleDclProps contains=rpgleComment,rpgleDclTypes,
                                     \rpgleDclKeywords,rpgleDclConstants,
                                     \rpgleNumber,rpgleString,rpgleConstant

" }}}
" Calculation Specs {{{

" IF -> ELSEIF -> ELSE -> ENDIF
syntax region  rpgleIf   matchgroup=rpgleConditional
                       \ start=/\<IF\>/
                       \ end=/\<ENDIF\>/
                       \ contains=@rpgleNest,rpgleElse
                       \ fold
syntax keyword rpgleElse contained else elseif

" NOT, AND, OR
syntax keyword rpgleConditional NOT AND OR

" DOW .. ENDDO, DOU .. ENDDO
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

" ITER, LEAVE
syntax keyword rpgleRepeat contained ITER LEAVE

" MONITOR -> ON-ERROR -> ENDMON
syntax region  rpgleMonitor matchgroup=rpgleConditional
                          \ start=/\<MONITOR\>/
                          \ end=/\<ENDMON\>/
                          \ contains=@rpgleNest,rpgleOnError
                          \ fold
syntax keyword rpgleOnError contained ON-ERROR

" SELECT -> WHEN -> OTHER -> ENDSL
syntax region rpgleSelect matchgroup=rpgleKeywords
                        \ start=/\<SELECT\>/
                        \ end=/\<ENDSL\>/
                        \ contains=rpgleWhen,rpgleOther
                        \ fold
syntax region rpgleWhen   matchgroup=rpgleKeywords
                        \ start=/\<WHEN\>/
                        \ end=/\ze\n\_s*\<\%(WHEN\|OTHER\|ENDSL\)\>/
                        \ contains=@rpgleNest
                        \ contained
syntax region rpgleOther  matchgroup=rpgleKeywords
                        \ start=/\<OTHER\>/
                        \ end=/\ze\n\_s*\<ENDSL\>/
                        \ contains=@rpgleNest
                        \ contained

" Build In Functions
syntax keyword rpgleBIF %ABS %ADDR %ALLOC %BITAND %BITNOT %BITOR %BITXOR
                      \ %CHAR %CHECK %CHECKR %DATE %DAYS %DEC %DECH %DECPOS
                      \ %DIFF %DIV %EDITC %EDITFLT %EDITW %ELEM %EOF %EQUAL
                      \ %ERROR %FIELDS %FLOAT %FOUND %GRAPH %HANDLER %HOURS
                      \ %INT %INTH %KDS %LEN %LOOKUP %LOOKUPGE %LOOKUPGT
                      \ %LOOKUPLE %LOOKUPLT %MAX %MIN %MINUTES %MONTHS
                      \ %MSECONDS %NULLIND %OCCUR %OPEN %PADDR %PARMNUM
                      \ %PARMS %REALLOC %REM %REPLACE %SCAN %SCANR %SCANRPL
                      \ %SECONDS %SHTDN %SIZE %SQRT %STATUS %STR %SUBARR
                      \ %SUBDT %SUBST %THIS %TIME %TIMESTAMP %TLOOKUP
                      \ %TLOOKUPGE %TLOOKUPGT %TLOOKUPLE %TLOOKUPLT %TRIM
                      \ %TRIML %TRIMR %UCS2 %UNS %UNSH %XFOOT %XLATE %XML
                      \ %YEARS

" Exec SQL
syntax region rpgleSql matchgroup=rpgleKeywords
                     \ start=/\<EXEC\_s\+SQL\>/
                     \ end=/;/
                     \ contains=@rpgleSql

" Procedures
syntax match   rpgleProcedure '%\@1<!\<\w\+\>\ze('
syntax keyword rpgleKeywords  RETURN

" BEGSR .. ENDSR
syntax region rpgleSub matchgroup=rpgleKeywords
                     \ start=/\<BEGSR\>/
                     \ end=/\<ENDSR\>/
                     \ contains=@rpgleNest
                     \ fold

" EXSR
syntax keyword rpgleKeywords EXSR

" }}}
" Prodecure Specs {{{

syntax region rpgleDclProc matchgroup=rpgleKeywords
                         \ start=/\<DCL-PROC\>/
                         \ end=/\<END-PROC\>/
                         \ contains=@rpgleNest,rpgleSub,rpgleDclSpec
                         \ fold

" }}}

" All nestable groups, i.e. mostly Calculation Spec keywords:
syntax cluster rpgleNest contains=rpgleNumber,rpgleString,rpgleOperator,
                              \rpgleProcedure,rpgleComment,rpgleIf,rpgleDo,
                              \rpgleFor,rpgleRepeat,rpgleMonitor,rpgleSelect,
                              \rpgleKeywords,rpgleConstant,rpgleBIF,rpgleSql

syntax sync fromstart

highlight link rpgleInclude     Include
highlight link rpgleNumber      Number
highlight link rpgleString      String
highlight link rpgleOperator    Operator
highlight link rpgleProcedure   Function
highlight link rpgleComment     Comment
highlight link rpgleTodo        Todo
highlight link rpgleConstant    Constant
highlight link rpgleIdentifier  Identifier
highlight link rpgleCtlKeywords rpgleKeywords
highlight link rpgleDclTypes    Type
highlight link rpgleDclKeywords rpgleKeywords
highlight link rpgleElse        rpgleConditional
highlight link rpgleOnError     rpgleKeywords
highlight link rpgleConditional Conditional
highlight link rpgleRepeat      Repeat
highlight link rpgleKeywords    Keyword
highlight link rpgleBIF         Function

" vim: foldmethod=marker
