" Vim syntax file
" Language:             Free RPGLE based on IBMi 7.1
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Dec 25, 2016
" Version:              3
" URL:                  https://github.com/andlrc/rpgle.vim

if exists("b:did_indent")
  finish
endif

let b:did_indent = 1

setlocal indentexpr=GetRpgleIndent()
setlocal indentkeys+=0=if,0=elseif,0=else,0=endif
setlocal indentkeys+=0=dou,0=dow,0=enddo,0=for,0=endfor
setlocal indentkeys+=0=monitor,0=on-error,0=endmon
setlocal indentkeys+=0=select,0=when,0=other,0=endsl
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
  let cnum = v:lnum
  let pnum = prevnonblank(cnum - 1)

  " There is no lines to determinate indent, so start at indent = 0
  if pnum == 0
    return 0
  endif

  let ind = indent(pnum)

  let pline = getline(pnum)
  let cline = getline(cnum)

  " There is a special case for when, as the first one following a select should
  " indent, while the rest should actually dedent:
  if pline =~ '^\s*\<select\>' && cline =~ '^\s*\<when\>'
    let ind += shiftwidth()

  " endsl have to dedent two levels:
  elseif cline =~ '^\s*\<endsl\>'
    let ind -= shiftwidth() * 2

  " A prodecure interface with no parametes should not dedent end-pi;
  elseif pline =~ '^\s*\<dcl-pi\>' &&cline =~ '^\s*\<end-pi\>'
    let ind = ind;

  " Assume that if there is a comment above, said indent can be used instead of
  " dedenting any
  elseif pline !~ '^\s*//' && cline =~ '^\s*\<\%(else\|elseif\|endif\|enddo\|endfor\|on-error\|endmon\|when\|other\|end-pi\|end-proc\|endsr\|end-pr\|end-ds\)\>'
    let ind -= shiftwidth()

  " Lastly add indent for opening keywords, but only if there isn't an end
  " keyword on the same line:
  elseif pline =~ '^\s*\%(if\|else\|elseif\|dou\|dow\|for\|monitor\|on-error\|on-error\|select\|when\|other\|dcl-proc\|begsr\|dcl-pi\|dcl-pr\|dcl-ds\)\>'
    if pline !~ '\%(\<\%(endif\|enddo\|endfor\|endmon\|end-pi\|end-pr\|end-proc\|endsr\|end-ds\)\>;\%(\s*//.*\)\=$\|\<likeds\>\)'
      let ind += shiftwidth()
    endif
  endif

  return ind
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
