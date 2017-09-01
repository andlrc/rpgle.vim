" Vim ftplugin file
" Language:             Free-Form ILE RPG
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Sep 01, 2017
" Version:              15
" URL:                  https://github.com/andlrc/rpgle.vim

if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

setlocal iskeyword+=-,%

setlocal suffixesadd=.rpgle,.rpgleinc
setlocal include=^\\s*/\\%(include\\\|copy\\)
setlocal includeexpr=substitute(v:fname,',','.file/','')

setlocal comments=s1:/*,mb:*,ex:*/,://,:*

let b:match_words = '\<select\>:\<when\>:\<other\>:\<endsl\>,' .
                  \ '\<if\>:\<elseif\>:\<else\>:\<endif\>,' .
                  \ '\<do[uw]\>:\<iter\>:\<leave\>:\<enddo\>,' .
                  \ '\<for\>:\<iter\>:\<leave\>:\<endfor\>,' .
                  \ '\<begsr\>:\<endsr\>,' .
                  \ '\<dcl-proc\>:\<return\>:\<end-proc\>,' .
                  \ '\<dcl-pi\>:\<end-pi\>,' .
                  \ '\<dcl-pr\>:\<end-pr\>,' .
                  \ '\<monitor\>:\<on-error\>:\<endmon\>'

" POSIX man pages is nice to look through when ``bnddir('Q2ILE')'' is used.
setlocal keywordprg=man\ 3p

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
