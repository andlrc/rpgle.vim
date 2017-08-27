" Vim completion script
" Language:             Free RPG/ILE based on IBMi 7.1
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Aug 27, 2017
" Version:              3
" URL:                  https://github.com/andlrc/rpgle.vim
"
" Complete via tag files, this code is experimental

function! rpgle#omni#Complete(findstart, base)
  if a:findstart
    " Locate the start of the item, including ``.''.
    let line = getline('.')
    let start = col('.') - 1
    let lastword = -1
    while start > 0
      if line[start - 1] =~ '\w'
        let start -= 1
      elseif line[start - 1] =~ '\.'
        if lastword == -1
          let lastword = start
        endif
        let start -= 1
      else
        break
      endif
    endwhile

    if lastword == -1
      let s:struct = ''
      return start
    endif
    let s:struct = strpart(line, start, lastword - start - 1)
    return lastword
  endif

  " Return list of matches:
  let matches  = []
  let tags     = taglist('^' . a:base)
  let curbufnr = bufnr('%')

  " Member completion
  if s:struct != ''
    " Resolve referenced data structure (``likeds(...)'')
    let struct_tags = taglist('^' . s:struct . '$')
    for tag in struct_tags
      if complete_check()
        break
      endif

      if tag['kind'] ==? "s" && has_key(tag, 'typeref')
        let s:struct = substitute(tag['typeref'], 'struct:', '', '')
        break
      endif
    endfor

    for tag in tags
      if complete_check()
        break
      endif

      " Remove static matches in other files.
      if tag['static'] && bufnr('%') != bufnr(tag['filename'])
        continue
      endif

      " Remove anything but members
      if tag['kind'] !=? 'm'
        continue
      endif

      " Remove members from other data structures
      if tag['struct'] !=? s:struct
        continue
      endif

      call add(matches, s:Tag2Item(tag))
    endfor
  else
    for tag in tags
      if complete_check()
        break
      endif

      " Remove static matches in other files.
      if tag['static'] && curbufnr != bufnr(tag['filename'])
        continue
      endif

      " Remove members
      if tag['kind'] ==? 'm'
        continue
      endif

      call add(matches, s:Tag2Item(tag))
    endfor
  endif

  return matches
endfunction

function s:Tag2Item(tag)
  return {
    \ 'word': a:tag['name'],
    \ 'kind': a:tag['kind']
  \ }
endfunction
