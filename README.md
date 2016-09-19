rpgle.vim
=========

Screenshot
----------

![Demo view](/demo.png)

RPGLE bundle for vim, this bundle provides syntax highlighting, syntax folds and
more match words.

Installation
------------

### Install with [Vundle](https://github.com/gmarik/vundle)

Add this to your `~/.vimrc`:

    Plugin 'andlrc/rpgle.vim'

And install it:

    :so $MYVIMRC
    :PluginInstall

To enable folds you need to add this to your `~/.vimrc`:


    au BufNewFile,BufRead *.rpgle setlocal setlocal foldmethod=syntax

Contributing
------------

Make a [pull request](https://github.com/andlrc/rpgle.vim/pulls) or
[issue](https://github.com/andlrc/rpgle.vim/issues)

License
-------

Distributed under the same terms as Vim itself. See `:help license`
