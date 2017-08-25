" Vim ftplugin file
" Language:             Free RPG/ILE based on IBMi 7.1
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Aug 19, 2017
" Version:              13
" URL:                  https://github.com/andlrc/rpgle.vim

if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

setlocal iskeyword+=-,%

let b:match_words = '\<select\>:\<when\>:\<other\>:\<endsl\>,' .
                  \ '\<if\>:\<elseif\>:\<else\>:\<endif\>,' .
                  \ '\<do[uw]\>:\<iter\>:\<leave\>:\<enddo\>,' .
                  \ '\<for\>:\<iter\>:\<leave\>:\<endfor\>,' .
                  \ '\<begsr\>:\<endsr\>,' .
                  \ '\<dcl-proc\>:\<return\>:\<end-proc\>,' .
                  \ '\<dcl-pi\>:\<end-pi\>,' .
                  \ '\<dcl-pr\>:\<end-pr\>,' .
                  \ '\<monitor\>:\<on-error\>:\<endmon\>'

" Proper section jumping {{{

nnoremap <script> <buffer> <silent> gd
       \ :<C-U>execute 'keepj normal [[/\<<C-r><C-w>\>/' . "\r"<CR>
nnoremap <script> <buffer> <silent> ]]
       \ :<C-U>call rpgle#movement#NextSection('^\s*dcl-proc', '', '')<CR>
nnoremap <script> <buffer> <silent> ][
       \ :<C-U>call rpgle#movement#NextSection('^\s*end-proc', '', '')<CR>
nnoremap <script> <buffer> <silent> [[
       \ :<C-U>call rpgle#movement#NextSection('^\s*dcl-proc', 'b', '')<CR>
nnoremap <script> <buffer> <silent> []
       \ :<C-U>call rpgle#movement#NextSection('^\s*end-proc', 'b', '')<CR>
xnoremap <script> <buffer> <silent> ]]
       \ :<C-U>call rpgle#movement#NextSection('^\s*dcl-proc', '', 'x')<CR>
xnoremap <script> <buffer> <silent> ][
       \ :<C-U>call rpgle#movement#NextSection('^\s*end-proc', '', 'x')<CR>
xnoremap <script> <buffer> <silent> [[
       \ :<C-U>call rpgle#movement#NextSection('^\s*dcl-proc', 'b', 'x')<CR>
xnoremap <script> <buffer> <silent> []
       \ :<C-U>call rpgle#movement#NextSection('^\s*end-proc', 'b', 'x')<CR>

" }}}
" Proper nest jumping {{{

nnoremap <script> <buffer> <silent> [{ :call rpgle#movement#NextNest('b')<CR>
nnoremap <script> <buffer> <silent> ]} :call rpgle#movement#NextNest('')<CR>

" }}}
" Set completion with CTRL-X CTRL-O {{{

setlocal omnifunc=rpgle#omni#Complete

" }}}
" vim: fdm=marker
