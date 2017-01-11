rpgle.vim
=========

What do I get?
--------------

RPG/ILE bundle for vim, this bundle provides syntax highlighting, syntax folds,
auto indent, more match words as well as mapping a few sensible keys.

### Indent

Add `let g:rpgle_indentStart = 0` to your `~/.vimrc~ to avoid 7 leading spaces.

There is support for automatic indentation. An example is:

    dcl-proc myProc;
        _

The cursor is located at `_` and the indent was inserted automatic when pressing
enter after `dcl-proc`. When typing `end-proc;` the indentation will be
decreased.

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

`if`-`elseif`-`else`-`endif` will be indented
like this:

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

### Syntax

There is partial support for context aware syntax highlighting, and mistyped
keywords will be *not* be highlighted. The same will happen for keywords outside
it's proper context, such as `elseif` and `else` with no preceding `if`.

### Syntax Folds

The following folds is supported:

    - if       -> endif
    - dow      -> enddo
    - dou      -> enddo
    - for      -> endfor
    - select   -> endsl
    - dcl-proc -> end-proc
    - begsr    -> endsr

And it can be enabled by running: `setlocal foldmethod=syntax`.

### Match Words

The following match words is supported:

    - select   -> when     -> other   -> endsl
    - if       -> elseif   -> else    -> endif
    - dow      -> iter     -> leave   -> enddo
    - dou      -> iter     -> leave   -> enddo
    - begsr    -> endsr
    - dcl-proc -> return   -> endproc
    - dcl-pi   -> end-pi
    - monitor  -> on-error -> endmon

And it can be enabled by running: `runtime macros/matchit.vim`

### Movements

rpgle.vim takes the liberty to bind `[[`, `]]`, `[]`, `][` and `gd` and tried to
make them useful in RPG/ILE:

`[[` and `]]` will jump the previous or next `dcl-proc` while `][` and `[]` will
jump to the previous or next `end-proc`.

`gd` will search for the word under the cursor from the previous `dcl-proc`.

See `:help [[` and `:help gd` for more information.

Installation
------------

### Install with [Vundle](https://github.com/gmarik/vundle)

Add this to your `~/.vimrc`:

    Plugin 'andlrc/rpgle.vim'

And install it:

    :so $MYVIMRC
    :PluginInstall

To enable folds you need to add this to your `~/.vimrc`:

    set foldmethod=syntax

Contributing
------------

Make a [pull request](https://github.com/andlrc/rpgle.vim/pulls) or
[issue](https://github.com/andlrc/rpgle.vim/issues)

Self-Promotion
--------------

Like rpgle.vim? Then you might also like
[rpglectags](https://github.com/andlrc/rpglectags), which provides a reliable
way to create ctags compatible files from RPG/ILE.

License
-------

Distributed under the same terms as Vim itself. See `:help license`
