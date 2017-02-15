" Vim ftplugin file
" Language:             Free RPG/ILE based on IBMi 7.1
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Feb 16, 2017
" Version:              8
" URL:                  https://github.com/andlrc/rpgle.vim

" quit when a syntax file was already loaded {{{1
if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

let b:match_words = '\<select\>:\<when\>:\<other\>:\<endsl\>,'
      \ . '\<if\>:\<elseif\>:\<else\>:\<endif\>,'
      \ . '\<do[uw]\>:\<iter\>:\<leave\>:\<enddo\>,'
      \ . '\<begsr\>:\<endsr\>,'
      \ . '\<dcl-proc\>:\<return\>:\<end-proc\>,'
      \ . '\<dcl-pi\>:\<end-pi\>,'
      \ . '\<monitor\>:\<on-error\>:\<endmon\>'

" Proper section jumping {{{

noremap <script> <buffer> <silent> gd :execute 'keepj normal [[/\<<C-r><C-w>\>/' . "\r"<CR>

noremap <script> <buffer> <silent> ]] :call rpgle#NextSection('^\s*dcl-proc', '')<CR>
noremap <script> <buffer> <silent> ][ :call rpgle#NextSection('^\s*end-proc', '')<CR>
noremap <script> <buffer> <silent> [[ :call rpgle#NextSection('^\s*dcl-proc', 'b')<CR>
noremap <script> <buffer> <silent> [] :call rpgle#NextSection('^\s*end-proc', 'b')<CR>

" }}}

" vim: fdm=marker
