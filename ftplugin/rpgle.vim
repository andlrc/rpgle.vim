" Vim syntax file
" Language:             Free RPGLE based on IBMi 7.1
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Dec 14, 2016
" Version:              3
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

" Proper section jumping {{{

function! s:NextSection(type, backwards)
  if a:type == 1
    let pattern = '\v^\s*dcl-proc'
  elseif a:type == 2
    let pattern = '\v^\s*end-proc'
  endif

  if a:backwards
    let dir = '?'
  else
    let dir = '/'
  endif

  " Todo shouldn't /pattern/W disable wrapscan?
  let ws = &wrapscan
  let pos = getpos('.')
  setlocal nowrapscan
  execute 'silent! :keepp normal! ' . dir . pattern . dir . 'e' . "\r"
  let &wrapscan = ws

  if pos == getpos('.')
    if a:backwards
      normal! gg
    else
      normal! G
    endif
  endif

endfunction

noremap <script> <buffer> <silent> gd :execute 'keepj normal [[/\<<C-r><C-w>\>/' . "\r"<CR>

noremap <script> <buffer> <silent> ]] :call <SID>NextSection(1, 0)<CR>
noremap <script> <buffer> <silent> ][ :call <SID>NextSection(2, 0)<CR>
noremap <script> <buffer> <silent> [[ :call <SID>NextSection(1, 1)<CR>
noremap <script> <buffer> <silent> [] :call <SID>NextSection(2, 1)<CR>

" }}}

" vim: fdm=marker
