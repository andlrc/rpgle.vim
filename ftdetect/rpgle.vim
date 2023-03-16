" Vim ftdetect file
" Language:             Free-Form ILE RPG
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Mar 16, 2023
" Version:              1
" URL:                  https://github.com/andlrc/rpgle.vim

au BufNewFile,BufRead *.rpgle    setlocal filetype=rpgle
au BufNewFile,BufRead *.sqlrpgle setlocal filetype=rpgle
au BufNewFile,BufRead *.rpgleinc setlocal filetype=rpgle
