" Vim ftdetect file
" Language:             Free RPG/ILE based on IBMi 7.1
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Dec 25, 2016
" Version:              3
" URL:                  https://github.com/andlrc/rpgle.vim

" quit when a syntax file was already loaded {{{1
if exists("b:did_ftdetect")
  finish
endif

let b:did_ftdetect = 1

au BufNewFile,BufRead *.rpgle,*.sqlrpgle,*.rpgleinc setlocal filetype=rpgle
