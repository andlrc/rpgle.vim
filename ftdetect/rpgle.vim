" Vim ftdetect file
" Language:             Free-Form ILE RPG
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Sep 13, 2017
" Version:              7
" URL:                  https://github.com/andlrc/rpgle.vim

if exists('b:did_ftdetect')
  finish
endif

let b:did_ftdetect = 1

au BufNewFile,BufRead *.rpgle    setlocal filetype=rpgle
au BufNewFile,BufRead *.sqlrpgle setlocal filetype=rpgle
au BufNewFile,BufRead *.rpgleinc setlocal filetype=rpgle
