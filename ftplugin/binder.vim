" Vim ftplugin file
" Language:             Binder Language
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Mar 20, 2019
" Version:              1
" URL:                  https://github.com/andlrc/rpgle.vim

if exists('b:did_ftplugin')
  finish
endif

let b:did_ftplugin = 1

setlocal suffixesadd=.binder


let b:match_words = '\<STRPGMEXP\>:\<ENDPGMEXP\>'
