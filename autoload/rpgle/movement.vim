" Vim autoload file
" Language:             Free-Form ILE RPG
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Sep 01, 2017
" Version:              7
" URL:                  https://github.com/andlrc/rpgle.vim

function! rpgle#movement#NextSection(motion, flags, mode) range

  let cnt = v:count1
  let old_pos = getpos('.')

  if a:mode == 'x'
    normal! gv
  endif

  normal! 0

  mark '
  while cnt > 0
    call search(a:motion, a:flags . 'W')
    if old_pos == getpos('.')
      execute 'norm!' a:flags =~# 'b' ? 'gg' : 'G'
    endif
    let old_pos = getpos('.')
    let cnt = cnt - 1
  endwhile

  normal! ^
endfunction

function! rpgle#movement#NextNest(flags)
  let flags = a:flags
  let pos = getpos('.')
  let fn  = a:flags == 'b' ? 'max' : 'min'

  " We can get the list from ``b:match_words'' and just use first and last of
  " each group
  let poss = filter(map(split(b:match_words, ','),
                      \ { key, val ->
                        \ s:nextNestSearch(split(val, ':'), flags) }),
                  \ { key, val -> val > 0 })

  let new_pos = call(fn, [poss])

  if new_pos > 0
    execute 'normal! ' . new_pos . 'G^'
  endif
endfunction

function! s:nextNestSearch(kw, flags)
  if a:kw[0] =~ 'if'
    let middle = '\<\(else\|elseif\)\>'
  else
    let middle = ''
  endif

  " Find a pair which isn't inside a string nor comment
  return searchpair(a:kw[0], middle, a:kw[-1], a:flags . 'nW',
  \ 'synIDattr(synID(line("."), col("."), 1), "name") =~? "string\\|comment"')
endfunction
