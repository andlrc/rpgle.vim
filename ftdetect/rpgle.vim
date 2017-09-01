" Vim ftdetect file
" Language:             Free-Form ILE RPG
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Sep 01, 2017
" Version:              5
" URL:                  https://github.com/andlrc/rpgle.vim

if exists("b:did_ftdetect")
  finish
endif

let b:did_ftdetect = 1

au BufNewFile,BufRead *.rpgle    setfiletype rpgle
au BufNewFile,BufRead *.sqlrpgle setfiletype rpgle
au BufNewFile,BufRead *.rpgleinc setfiletype rpgle
