" Vim syntax file
" Language:             Binder Language
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Mar 20, 2019
" Version:              1
" URL:                  https://github.com/andlrc/rpgle.vim

if exists('b:current_syntax')
  finish
endif

let b:current_syntax = 'binder'
syntax iskeyword @,48-57,192-255,-,*,/,_

syntax keyword binderKeywords STRPGMEXP ENDPGMEXP EXPORT SYMBOL PGMLVL LVLCHK SIGNATURE

syntax match binderSpecial    /'[^']\+'/
syntax match binderString     /"[^"]\+"/
syntax match binderIdentifier /\w\+/
syntax keyword binderConstant *CURRENT *PRV

syntax sync fromstart

highlight link binderKeywords Keyword
highlight link binderSpecial  Special
highlight link binderString   String
highlight link binderIdentifier  Identifier
highlight link binderConstant Constant
