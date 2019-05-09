" Vim indent file
" Language:             Binder Language
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          May 09, 2019
" Version:              1
" URL:                  https://github.com/andlrc/rpgle.vim

if exists('b:did_indent')
  finish
endif

let b:did_indent = 1

setlocal indentexpr=GetBinderIndent()
setlocal indentkeys=o,O
setlocal indentkeys+=0*
setlocal indentkeys+=0=~strpgmexp,0=~endpgmexp
setlocal nosmartindent

let b:undo_indent = 'setlocal indentexpr< indentkeys< smartindent<'

if exists('*GetBinderIndent')
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

function! GetBinderIndent()
  let cnum = v:lnum
  let pnum = prevnonblank(cnum - 1)

  let pind = indent(pnum)

  let pline = getline(pnum)
  let cline = getline(cnum)

  " Add indent for opening keywords:
  if pline =~ '^\s*\<strpgmexp\>'
    return pind + shiftwidth()
  endif

  " Remove indent for closing keywords:
  if cline =~ '^\s*\<endpgmexp\>'
    return pind - shiftwidth()
  endif

  " If no match return the same indent as before:
  return pind
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
