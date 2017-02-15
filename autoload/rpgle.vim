" Vim autoload file
" Language:             Free RPG/ILE based on IBMi 7.1
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Feb 16, 2017
" Version:              1
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


