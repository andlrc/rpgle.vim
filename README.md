rpgle.vim
=========

Screenshot
----------

![Demo view](/demo.png)

RPG/ILE bundle for vim, this bundle provides syntax highlighting, syntax folds,
auto indent and more match words.

Installation
------------

### Install with [Vundle](https://github.com/gmarik/vundle)

Add this to your `~/.vimrc`:

    Plugin 'andlrc/rpgle.vim'

And install it:

    :so $MYVIMRC
    :PluginInstall

To enable folds you need to add this to your `~/.vimrc`:

    let g:rpgle_fold_enabled = 1

Customization
-------------

You can specify which folds you want to enable by changing the `g:rpgle_fold`
variable. This variable works as an and gate and `let g:rpgle_fold = 3` will
enable setting 1 and 2:

    let g:rpgle_fold = 1 + 2 + 4 + 8 + 16 + 32 + 64 + 128 + 256 + 512 + 1024 + 2048 + 4096
    "                  ^   ^   ^   ^   ^    ^    ^    ^     ^     ^     ^      ^      ^
    "                  |   |   |   |   |    |    |    |     |     |     |      |      dcl-ds ... end-ds
    "                  |   |   |   |   |    |    |    |     |     |     |      dcl-pr ... end-pr
    "                  |   |   |   |   |    |    |    |     |     |     dcl-pi ... end-pi
    "                  |   |   |   |   |    |    |    |     |     dcl-s ...  dcl-c
    "                  |   |   |   |   |    |    |    |     |     dcl-s ...  dcl-c
    "                  |   |   |   |   |    |    |    |     begsr ... endsr
    "                  |   |   |   |   |    |    |    dcl-proc ... end-proc
    "                  |   |   |   |   |    |    select ... when ... other ...  endsl
    "                  |   |   |   |   |    monitor ... end-mon
    "                  |   |   |   |   for ... endfor
    "                  |   |   |   dou ... enddo / dow ... enddo
    "                  |   |   if ... endif
    "                  |   ctl-opt ... ctl-opt
    "                  /include ... /copy

Contributing
------------

Make a [pull request](https://github.com/andlrc/rpgle.vim/pulls) or
[issue](https://github.com/andlrc/rpgle.vim/issues)

License
-------

Distributed under the same terms as Vim itself. See `:help license`
