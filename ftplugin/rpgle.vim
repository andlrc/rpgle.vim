" Vim syntax file
" Language:             Free RPGLE based on IBMi 7.1
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Sep 19, 2016
" Version:              1
" URL:                  https://github.com/andlrc/rpgle.vim

" quit when a syntax file was already loaded {{{1
if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

let b:match_words = '\<select\>:\<when\>:\<endsl\>,'
      \ . '\<if\>:\<elseif\>:\<else\>:\<endif\>,'
      \ . '\<do[uw]\>:\<iter\>:\<leave\>:\<enddo\>,'
      \ . '\<begsr\>:\<endsr\>,'
      \ . '\<dcl-proc\>:\<return\>:\<end-proc\>,'
      \ . '\<dcl-pi\>:\<end-pi\>,'
      \ . '\<monitor\>:\<on-error\>:\<endmon\>'

