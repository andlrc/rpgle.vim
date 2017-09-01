rpgle.vim
=========

What does it contain?
---------------------

Free-Form ILE RPG bundle for vim, which contains syntax highlighting, syntax
folds, auto indent, more match words and a few sensible keys is remapped.

### Indent

One should modify `g:rpgle_indentStart` to adjust initial indentation level,
see `:help g:rpgle_indentStart` for more information.

There is support for automatic indentation. An example is:

    dcl-proc myProc;
        _

The cursor is located at `_` and the indent was inserted automatic when
pressing enter after `dcl-proc`. When typing `end-proc;` the indentation will
be decreased.

With procedure interfaces indentation will only happen if the procedure takes
an argument:

    dcl-pi myProc;
        _

If one type `end-pi;` the result will automatic become:

    dcl-pi myProc;
    end-pi;

`select`-`when`-`other`-`endsl` will be indented like this:

    select;
        when;
            a();
        when;
            b();
        other;
            c();
            _

As soon as `endsl` is typed it will be aligned with the initial `select;`.

`if`-`elseif`-`else`-`endif` will be indented like this:

    if a = 1;
        a();
    elseif b = 1;
        b();
    else;
        c();
        _

When typing `endif` the indentation will be decreased.

Currently proper SQL indentation is missing:

    exec sql
    select *
    from a
    order by 1 desc;

See `:help ft-rpgle-indent`

### Syntax

Keywords, procedures and built-in functions will all be highlighted.

See `:help ft-rpgle-syntax`

### Syntax Folds

The following folds are supported:

    - if       -> endif
    - dow      -> enddo
    - dou      -> enddo
    - for      -> endfor
    - select   -> endsl
    - dcl-proc -> end-proc
    - begsr    -> endsr

See `:help ft-rpgle-fold`

### Match Words

The following match words are supported:

    - select   -> when     -> other   -> endsl
    - if       -> elseif   -> else    -> endif
    - dow      -> iter     -> leave   -> enddo
    - dou      -> iter     -> leave   -> enddo
    - begsr    -> endsr
    - dcl-proc -> return   -> endproc
    - dcl-pi   -> end-pi
    - monitor  -> on-error -> endmon

See `:help ft-rpgle-match-words`

### Movements

rpgle.vim takes the liberty to bind `[[`, `]]`, `[]`, `][`, `gd`, `[{` and `]}`
and tried to make them useful for ILE RPG programming.

`[[` and `]]` will jump to the previous or next `dcl-proc` while `][` and `[]`
will jump to the previous or next `end-proc`.

`gd` will search for the word under the cursor from the previous `dcl-proc`.

`[{` and `]}` will jump to the associated block opener, i.e. standing inside an
`if` statement and pressing `[{` will bring you to the `if`, pressing `]}` will
bring you to the `endif`.

See `:help ft-rpgle-movements`

### Omni Completion

rpgle.vim provides a naive omni completion that will attempt to suggest
completion for compiler directives and header, declaration, calculation and
procedure specifications.

Calculation specification completion requires generated generated tags.

See `:h ft-rpgle-omni`

Contributing
------------

Make a [pull request](https://github.com/andlrc/rpgle.vim/pulls) or
[issue](https://github.com/andlrc/rpgle.vim/issues)

Self-Promotion
--------------

Like rpgle.vim? Then you might also like
[rpglectags](https://github.com/andlrc/rpglectags), creates tags files from ILE
RPG. And [rpgleman](https://github.com/andlrc/rpgleman) which provides man
pages for built-in functions keywords and more.

License
-------

Distributed under the same terms as Vim itself. See `:help license`
