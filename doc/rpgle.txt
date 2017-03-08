*rpgle.txt* RPG/ILE bundle for vim

Author:  Andreas Louv <andreas@louv.dk>
License: Same terms as Vim itself (see |license|)

INTRODUCTION                                    *rpgle*

This bundle provides syntax highlighting, syntax folds, auto indent, more
match words as well as mapping a few sensible keys.


VARIABLES                                       *rpgle-variables*
`g:rpgle_indentStart`     Set the number of leading spaces that should be used
                        when no previous line is to be accounted for.

INDENT                                          *rpgle-indent*

Enable by adding the following to your |vimrc|

`filetype indent on`

SYNTAX                                          *rpgle-syntax*

Enable by adding the following to your |vimrc|

`filetype syntax on`

SYNTAX FOLDS                                    *rpgle-syntax-folds*

Settings |foldmethod| to 'syntax' to enable the following folds:

    `if`       -> `endif`
    `dow`      -> `enddo`
    `dou`      -> `enddo`
    `for`      -> `endfor`
    `select`   -> `endsl`
    `dcl-proc` -> `end-proc`
    `begsr`    -> `endsr`

MATCH WORDS                                     *rpgle-match-words*

Enable by adding the following to your |vimrc|

`runtime macros/matchit.vim`

The following match words is supported:

    `select`   -> `when`     -> `other`   -> `endsl`
    `if`       -> `elseif`   -> `else`    -> `endif`
    `dow`      -> `iter`     -> `leave`   -> `enddo`
    `dou`      -> `iter`     -> `leave`   -> `enddo`
    `begsr`    -> `endsr`
    `dcl-proc` -> `return`   -> `endproc`
    `dcl-pi`   -> `end-pi`
    `monitor`  -> `on-error` -> `endmon`

MOVEMENTS                                       *rpgle-match-words*

Enable by adding the following to your |vimrc|

`filetype on`

                                                *[[*

[[                      Jump to previous `dcl-proc`
]]                      Jump to next `dcl-proc`
[]                      Jump to previous `end-proc`
][                      Jump to next `end-proc`
gd                      Goto local Declaration.  When the cursor is on a local
                        variable, this command will jump to its declaration.
                        Use |gD| to goto global declaration.

 vim:tw=78:ts=8:ft=help:norl:
