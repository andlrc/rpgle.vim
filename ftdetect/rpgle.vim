" Vim ftdetect file
" Language:             Free-Form ILE RPG
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Mar 20, 2019
" Version:              8
" URL:                  https://github.com/andlrc/rpgle.vim

au BufNewFile,BufRead *.rpgle    setlocal filetype=rpgle
au BufNewFile,BufRead *.sqlrpgle setlocal filetype=rpgle
au BufNewFile,BufRead *.rpgleinc setlocal filetype=rpgle
