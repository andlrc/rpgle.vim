" Vim ftdetect file
" Language:             Free RPG/ILE based on IBMi 7.1
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Dec 29, 2016
" Version:              4
" URL:                  https://github.com/andlrc/rpgle.vim

if exists("b:did_ftdetect")
  finish
endif

let b:did_ftdetect = 1

au BufNewFile,BufRead *.rpgle    setlocal filetype=rpgle
au BufNewFile,BufRead *.sqlrpgle setlocal filetype=rpgle
au BufNewFile,BufRead *.rpgleinc setlocal filetype=rpgle
