" Vim autoload file
" Language:             Free RPG/ILE based on IBMi 7.1
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Jul 23, 2017
" Version:              2
" URL:                  https://github.com/andlrc/rpgle.vim

function! rpgle#NextSection(pattern, flags) range

  let cnt = v:count1

  mark '
  let pos = getpos('.')
  normal! ^

  while cnt > 0
    call search(a:pattern, a:flags . 'W')
    normal! ^

    let new_pos = getpos('.')
    if pos == new_pos
      execute 'norm! ' a:flags =~# 'b' ? 'gg' : 'G'
      break
    endif
    let pos = new_pos

    let cnt = cnt - 1
  endwhile

endfunction

function! rpgle#NextNest(flags)
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

  execute 'normal! ' . new_pos . 'G^'
endfunction

function! s:nextNestSearch(kw, flags)

  if a:kw[0] =~ 'if'
    return searchpair(a:kw[0], '\<\(else\|elseif\)\>', a:kw[-1], a:flags . 'nW')
  else
    return searchpair(a:kw[0], '', a:kw[-1], a:flags . 'nW')
  endif
endfunction
