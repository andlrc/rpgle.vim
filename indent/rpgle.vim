" Vim syntax file
" Language:             Free RPGLE based on IBMi 7.1
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Sep 19, 2016
" Version:              1
" URL:                  https://github.com/andlrc/rpgle.vim

if exists("b:did_indent")
  finish
endif

let b:did_indent = 1

setlocal indentexpr=GetRpgleIndent()
setlocal indentkeys+=0=if,0=elseif,0=else,0=endif
setlocal indentkeys+=0=dou,0=dow,0=enddo,0=for,0=endfor
setlocal indentkeys+=0=monitor,0=on-error,0=endmon
setlocal indentkeys+=0=when,0=other,0=endsl
setlocal indentkeys+=0=dcl-proc,0=end-proc,0=begsr,0=endsr
setlocal indentkeys+=0=dcl-pi,0=end-pi,0=dcl-pr,0=end-pr,0=dcl-ds,0=end-ds
setlocal nosmartindent

let b:undo_indent = 'setlocal indentexpr< indentkeys< smartindent<'

if exists("*GetRpgleIndent")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

function! GetRpgleIndent()
  let lnum = prevnonblank(v:lnum - 1)
  if lnum == 0
    return 0
  endif

  let pnum = prevnonblank(lnum - 1)

  let ind = indent(lnum)
  let line = getline(lnum)
  if line =~ '^\s*\%(if\|else\|elseif\|dou\|dow\|for\|monitor\|on-error\|when\|other\|dcl-proc\|dcl-pi\|dcl-pr\|dcl-ds\)\>'
    if line !~ '\<\%(endif\|enddo\|endfor\|endmon\|endsl\|end-pi\|end-pr\|end-ds\)\>\s*\%(//.*\)\=$'
      let ind += shiftwidth()
    endif
  endif

  let line = getline(v:lnum)
  if line =~ '^\s*\%(else\|elseif\|endif\|enddo\|endfor\|endmon\|when\|other\|endsl\|end-pi\|end-pr\|end-ds\)\>'
    let ind -= shiftwidth()
  endif

  return ind
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
