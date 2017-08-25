" Vim completion script
" Language:             Free RPG/ILE based on IBMi 7.1
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Aug 25, 2017
" Version:              1
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

  let tags = taglist('^' . a:base)

  " Remove static matches in other files.
  call filter(tags, '!has_key(v:val, "static") || !v:val["static"] || bufnr("%") == bufnr(v:val["filename"])')

  " Member completion
  if s:struct != ''
    " Resolve referenced data structure (``likeds(...)'')
    let struct_tags = taglist('^' . s:struct . '$')
    for tag in struct_tags
      if tag['kind'] ==? "s" && has_key(tag, 'typeref')
        echom tag['typeref']
        let s:struct = substitute(tag['typeref'], 'struct:', '', '')
        break
      endif
    endfor

    " Remove anything but members
    call filter(tags, 'v:val["kind"] == "m"')

    " Remove members from other data structures
    call filter(tags, 'v:val["struct"] ==? "' . s:struct . '"')

    return map(tags, 's:Tag2Item(v:val)')
  else
    " Remove members
    call filter(tags, 'v:val["kind"] != "m"')

    return map(tags, 's:Tag2Item(v:val)')
  endif

endfunction

function s:Tag2Item(tag)
  return a:tag['name']
endfunction
