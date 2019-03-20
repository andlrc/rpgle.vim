" Vim ftdetect file
" Language:             Binder Language
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Mar 20, 2019
" Version:              1
" URL:                  https://github.com/andlrc/rpgle.vim

if exists('b:did_ftdetect')
  finish
endif

let b:did_ftdetect = 1

au BufNewFile,BufRead *.binder setlocal filetype=binder
