" Vim ftplugin file
" Language:             Free-Form ILE RPG
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Dec 12, 2018
" Version:              21
" URL:                  https://github.com/andlrc/rpgle.vim

if exists('b:did_ftplugin')
  finish
endif

let b:did_ftplugin = 1

setlocal iskeyword+=-,%

setlocal suffixesadd=.rpgle,.rpgleinc
setlocal include=^\\s*/\\%(include\\\|copy\\)
setlocal includeexpr=substitute(v:fname,',','.file/','')

setlocal comments=s1:/*,mb:*,ex:*/,://,:*

" ILE RPG is in case-sensitive
setlocal tagcase=ignore nosmartcase ignorecase

let b:match_words = '\<select\>:\<when\>:\<other\>:\<endsl\>'
                \ . ',\<if\>:\<elseif\>:\<else\>:\<endif\>'
                \ . ',\<do[uw]\>:\<iter\>:\<leave\>:\<enddo\>'
                \ . ',\<for\>:\<iter\>:\<leave\>:\<endfor\>'
                \ . ',\<begsr\>:\<endsr\>'
                \ . ',\<dcl-proc\>:\<return\>:\<end-proc\>'
                \ . ',\<dcl-pi\>:\<end-pi\>'
                \ . ',\<dcl-pr\>:\<end-pr\>'
                \ . ',\<monitor\>:\<on-error\>:\<endmon\>'
                \ . ',\<dcl-ds\>:\<\%(likeds\|extname\|end-ds\)\>'

" section jumping {{{

nnoremap <script> <buffer> <silent> <Plug>RpgleGoToDeclaration
       \ :<C-U>execute 'keepj normal [[/\<<C-r><C-w>\>/' . "\r"<CR>
nnoremap <script> <buffer> <silent> <Plug>RpgleNextProcStart
       \ :<C-U>call rpgle#movement#NextSection('^\s*dcl-proc', '', '')<CR>
nnoremap <script> <buffer> <silent> <Plug>RpgleNextProcEnd
       \ :<C-U>call rpgle#movement#NextSection('^\s*end-proc', '', '')<CR>
nnoremap <script> <buffer> <silent> <Plug>RpglePrevProcStart
       \ :<C-U>call rpgle#movement#NextSection('^\s*dcl-proc', 'b', '')<CR>
nnoremap <script> <buffer> <silent> <Plug>RpglePrevProcEnd
       \ :<C-U>call rpgle#movement#NextSection('^\s*end-proc', 'b', '')<CR>
xnoremap <script> <buffer> <silent> <Plug>XRpgleNextProcStart
       \ :<C-U>call rpgle#movement#NextSection('^\s*dcl-proc', '', 'x')<CR>
xnoremap <script> <buffer> <silent> <Plug>XRpgleNextProcEnd
       \ :<C-U>call rpgle#movement#NextSection('^\s*end-proc', '', 'x')<CR>
xnoremap <script> <buffer> <silent> <Plug>XRpglePrevProcStart
       \ :<C-U>call rpgle#movement#NextSection('^\s*dcl-proc', 'b', 'x')<CR>
xnoremap <script> <buffer> <silent> <Plug>XRpglePrevProcEnd
       \ :<C-U>call rpgle#movement#NextSection('^\s*end-proc', 'b', 'x')<CR>

if get(g:, 'rpgle_skipMapping', 0) == v:false
  nmap <buffer> <silent> gd <Plug>RpgleGoToDeclaration
  nmap <buffer> <silent> ]] <Plug>RpgleNextProcStart
  nmap <buffer> <silent> ][ <Plug>RpgleNextProcEnd
  nmap <buffer> <silent> [[ <Plug>RpglePrevProcStart
  nmap <buffer> <silent> [] <Plug>RpglePrevProcEnd
  xmap <buffer> <silent> ]] <Plug>XRpgleNextProcStart
  xmap <buffer> <silent> ][ <Plug>XRpgleNextProcEnd
  xmap <buffer> <silent> [[ <Plug>XRpglePrevProcStart
  xmap <buffer> <silent> [] <Plug>XRpglePrevProcEnd
endif

" }}}
" Nest jumping {{{

nnoremap <script> <buffer> <silent> <Plug>RpglePrevBlock
       \ :call rpgle#movement#NextNest('b')<CR>
nnoremap <script> <buffer> <silent> <Plug>RpgleNextBlock
       \ :call rpgle#movement#NextNest('')<CR>

if get(g:, 'rpgle_skipMapping', 0) == v:false
  nmap <buffer> <silent> [{ <Plug>RpglePrevBlock
  nmap <buffer> <silent> ]} <Plug>RpgleNextBlock
endif

" }}}
" Operator Pending brackets {{{

onoremap <script> <buffer> <silent> <Plug>RpgleAroundBlock
       \ :<C-U>call rpgle#movement#Operator('a')<CR>
onoremap <script> <buffer> <silent> <Plug>RpgleInnerBlock
       \ :<C-U>call rpgle#movement#Operator('i')<CR>

if get(g:, 'rpgle_skipMapping', 0) == v:false
  omap <buffer> a} <Plug>RpgleAroundBlock
  omap <buffer> a{ <Plug>RpgleAroundBlock
  omap <buffer> aB <Plug>RpgleAroundBlock
  omap <buffer> i} <Plug>RpgleInnerBlock
  omap <buffer> i{ <Plug>RpgleInnerBlock
  omap <buffer> iB <Plug>RpgleInnerBlock
endif

" }}}
" Set completion with CTRL-X CTRL-O {{{

setlocal omnifunc=rpgle#omni#Complete

" }}}
" vim: fdm=marker
