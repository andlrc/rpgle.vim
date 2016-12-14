" Vim syntax file
" Language:             Free RPGLE based on IBMi 7.1
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Dec 14, 2016
" Version:              32
" URL:                  https://github.com/andlrc/rpgle.vim

if exists("b:current_syntax")
  finish
endif

if exists('g:rpgle_fold_enabled') " {{{

  if &fdm == 'manual'
    " Give that g:rpgle_fold_enabled is on and foldmethod is default it should be
    " safe to asume the user wants syntax folding
    set fdm=syntax
  endif

  if exists('g:rpgle_fold')
    let s:rpgle_fold = g:rpgle_fold
  else
    " Enable all folds by default
    let s:rpgle_fold = 4096 * 2 - 1
  endif

  let s:rpgle_fold_include = and(s:rpgle_fold, 1)
  let s:rpgle_fold_ctlOpt  = and(s:rpgle_fold, 2)
  let s:rpgle_fold_if      = and(s:rpgle_fold, 4)
  let s:rpgle_fold_do      = and(s:rpgle_fold, 8)
  let s:rpgle_fold_for     = and(s:rpgle_fold, 16)
  let s:rpgle_fold_monitor = and(s:rpgle_fold, 32)
  let s:rpgle_fold_select  = and(s:rpgle_fold, 64)
  let s:rpgle_fold_dclProc = and(s:rpgle_fold, 128)
  let s:rpgle_fold_begsr   = and(s:rpgle_fold, 256)
  let s:rpgle_fold_dclS    = and(s:rpgle_fold, 512)
  let s:rpgle_fold_dclPi   = and(s:rpgle_fold, 1024)
  let s:rpgle_fold_dclPr   = and(s:rpgle_fold, 2048)
  let s:rpgle_fold_dclDs   = and(s:rpgle_fold, 4096)
endif " }}}

if exists('s:rpgle_fold_include') && s:rpgle_fold_include > 0 " {{{
  com! -nargs=* RpgleFoldInclude <args> fold
else
  com! -nargs=* RpgleFoldInclude <args>
endif

if exists('s:rpgle_fold_ctlOpt') && s:rpgle_fold_ctlOpt > 0
  com! -nargs=* RpgleFoldCtlOpt <args> fold
else
  com! -nargs=* RpgleFoldCtlOpt <args>
endif

if exists('s:rpgle_fold_if') && s:rpgle_fold_if > 0
  com! -nargs=* RpgleFoldIf <args> fold
else
  com! -nargs=* RpgleFoldIf <args>
endif

if exists('s:rpgle_fold_do') && s:rpgle_fold_do > 0
  com! -nargs=* RpgleFoldDo <args> fold
else
  com! -nargs=* RpgleFoldDo <args>
endif

if exists('s:rpgle_fold_for') && s:rpgle_fold_for > 0
  com! -nargs=* RpgleFoldFor <args> fold
else
  com! -nargs=* RpgleFoldFor <args>
endif

if exists('s:rpgle_fold_monitor') && s:rpgle_fold_monitor > 0
  com! -nargs=* RpgleFoldMonitor <args> fold
else
  com! -nargs=* RpgleFoldMonitor <args>
endif

if exists('s:rpgle_fold_select') && s:rpgle_fold_select > 0
  com! -nargs=* RpgleFoldSelect <args> fold
else
  com! -nargs=* RpgleFoldSelect <args>
endif

if exists('s:rpgle_fold_dclProc') && s:rpgle_fold_dclProc > 0
  com! -nargs=* RpgleFoldDclProc <args> fold
else
  com! -nargs=* RpgleFoldDclProc <args>
endif

if exists('s:rpgle_fold_begsr') && s:rpgle_fold_begsr > 0
  com! -nargs=* RpgleFoldBegsr <args> fold
else
  com! -nargs=* RpgleFoldBegsr <args>
endif

if exists('s:rpgle_fold_dclS') && s:rpgle_fold_dclS > 0
  com! -nargs=* RpgleFoldDclS <args> fold
else
  com! -nargs=* RpgleFoldDclS <args>
endif

if exists('s:rpgle_fold_dclPi') && s:rpgle_fold_dclPi > 0
  com! -nargs=* RpgleFoldDclPi <args> fold
else
  com! -nargs=* RpgleFoldDclPi <args>
endif

if exists('s:rpgle_fold_dclPr') && s:rpgle_fold_dclPr > 0
  com! -nargs=* RpgleFoldDclPr <args> fold
else
  com! -nargs=* RpgleFoldDclPr <args>
endif

if exists('s:rpgle_fold_dclDs') && s:rpgle_fold_dclDs > 0
  com! -nargs=* RpgleFoldDclDs <args> fold
else
  com! -nargs=* RpgleFoldDclDs <args>
endif " }}}


syn include @rpgleSql syntax/sqlanywhere.vim

syn case ignore
let b:current_syntax = "rpgle"
setlocal iskeyword+=-

sy match  rpgleNumber     "\<[[:digit:]]\{1,}\%(\.[[:digit:]]*\)\=\>"
sy match  rpgleString     /'\(.\{-}\([+-]\_$\n*\)\{0,1}\)*'/
sy match  rpgleOperator   /\v(\*\*|\<\>|\>\=|\<\=|<NOT>|<AND>|<OR>|[-.*=><])/
sy match  rpgleProcedure  /\v(\%)@<!<\w+\s*\ze\(/
sy match  rpgleComment    /\v\/\/.*/                                                  contains=rpgleTodo
sy region rpgleComment    start=/\v\/\*/              end=/\v\*\//                    contains=rpgleTodo
sy match  rpgleTodo       /\v(TODO|FIXME)/                                            contained
sy match  rpgleConstant   /\v\*(ON|OFF|ENTRY|ALL|BLANKS|BLANK|ZEROS|ZERO|HIVAL|LOVAL|NULL)>/
sy match  rpgleIdentifier /\v\*(IN0[1-9]|IN[1-9][0-9]|INH[1-9]|INL[1-9]|INLR|INU[1-8]|INRT)>/
sy match  rpgleKeywords   /\v<(ctl-opt|exsr|return)>/
RpgleFoldInclude sy region rpgleInclude    start="^/\%(include\|copy\)" end="\ze\n\%(^/\%(include\|copy\)\)\@!" extend
RpgleFoldCtlOpt  sy region rpgleHSpec      matchgroup=rpgleKeywords start="^\s*\<ctl-opt\>" end="\ze\n\%(^\s*\<ctl-opt\>\)\@!" extend contains=@rpgleNest

" if -> elseif -> else -> endif
RpgleFoldIf sy region rpgleIf   matchgroup=rpgleConditional start=/\v<if>/ end=/\v<endif>/ contains=@rpgleNest extend
            sy match  rpgleElse /\v<else>|<elseif>/

" do[uw] ... endd and for ... endfor
RpgleFoldDo  sy region rpgleDo  matchgroup=rpgleRepeat start=/\v<do[wu]>/ end=/\v<enddo>/  contains=@rpgleNest extend
RpgleFoldFor sy region rpgleFor matchgroup=rpgleRepeat start=/\v<for>/    end=/\v<endfor>/ contains=@rpgleNest extend

" Monitor -> on-error -> endmon
RpgleFoldMonitor sy region rpgleMonitor matchgroup=rpgleConditional start=/\v<monitor>/ end=/\v<endmon>/ contains=@rpgleNest,rpgleOnError extend
                 sy match  rpgleOnError /\v<on-error>/


" select -> when -> other -> endsl
RpgleFoldSelect sy region rpgleSelect matchgroup=rpgleSwitch start=/\v<select>/ end=/\v<endsl>/                          contains=rpgleWhen,rpgleOther extend
RpgleFoldSelect sy region rpgleWhen   matchgroup=rpgleSwitch start=/\v<when>/   end=/\v\ze\n\s*(<when>|<other>|<endsl>)/ contains=@rpgleNest extend contained
RpgleFoldSelect sy region rpgleOther  matchgroup=rpgleSwitch start=/\v<other>/  end=/\v\ze\n\s*<endsl>/                  contains=@rpgleNest extend contained

" Exec SQL
sy region rpgleSql matchgroup=rpgleLabel start=/\v<exec\_s+sql>/ end=/\v;/ contains=@rpgleSql

" dlc-proc, begsr
RpgleFoldDclProc sy region rpgleDclProc matchgroup=rpgleLabel start=/\v<dcl-proc>/ end=/\v<end-proc>/ contains=@rpgleNest,rpgleSub,rpgleDclList extend
RpgleFoldBegsr   sy region rpgleSub     matchgroup=rpgleLabel start=/\v<begsr>/    end=/\v<endsr>/    contains=@rpgleNest extend

" dcl-*
RpgleFoldDclS  sy region  rpgleDclList       matchgroup=rpgleDclKeywords start=/\v<dcl-(s|c)>/ end=/\v\ze\n(.*dcl-(s|c)>)@!/      contains=@rpgleDclProps extend
RpgleFoldDclPi sy region  rpgleDclList       matchgroup=rpgleDclKeywords start=/\v<dcl-pi>/    end=/\v<end-pi>/                   contains=@rpgleDclPiProps extend
RpgleFoldDclPr sy region  rpgleDclList       matchgroup=rpgleDclKeywords start=/\v<dcl-pr>/    end=/\v<end-pr>/                   contains=@rpgleDclPrProps extend
RpgleFoldDclDs sy region  rpgleDclList       matchgroup=rpgleDclKeywords start=/\v<dcl-ds>/    end=/\v(<end-ds>|<likeds>|\ze\n(.*dcl-)@=)/ contains=@rpgleDclDsProps extend

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
