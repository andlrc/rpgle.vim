" Vim completion script
" Language:             Free-Form ILE RPG
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Sep 01, 2017
" Version:              5
" URL:                  https://github.com/andlrc/rpgle.vim
"
" Complete via tag files, this code is experimental

let s:keywords = [
  \ ['alias',			['ds']],
  \ ['align',			['ds']],
  \ ['alt(',			['s', 'ds']],
  \ ['altseq(',			['s', 'ds', 'subf', 'pi', 'pr', 'prp']],
  \ ['ascend',			['s', 'ds', 'prp']],
  \ ['based(',			['s', 'ds', 'pr']],
  \ ['bindec(',			['s', 'subf', 'pip', 'prp']],
  \ ['ccsid(',			['s', 'subf', 'pip', 'prp']],
  \ ['char(',			['s', 'subf', 'pip', 'prp']],
  \ ['class(',			['s', 'subf', 'pip', 'prp']],
  \ ['const(',			['c']],
  \ ['ctdata',			['s', 'subf']],
  \ ['date',			['s', 'subf', 'pip', 'prp']],
  \ ['date(',			['s', 'subf', 'pip', 'prp']],
  \ ['descend',			['s', 'ds', 'prp']],
  \ ['dim(',			['s', 'ds', 'pi', 'pip', 'pr', 'prp']],
  \ ['dtaara',			['s', 'ds', 'subf']],
  \ ['dtaara(',			['s', 'ds', 'subf']],
  \ ['export',			['s', 'ds', 'proc']],
  \ ['export(',			['s', 'ds', 'proc']],
  \ ['ext',			['ds']],
  \ ['extfld',			['subf']],
  \ ['extfld(',			['subf']],
  \ ['extname(',		['ds']],
  \ ['extpgm',			['pr']],
  \ ['extpgm(',			['pr']],
  \ ['extproc',			['pr']],
  \ ['extproc(*CL : ',		['pr']],
  \ ['extproc(*CWIDEN :',	['pr']],
  \ ['extproc(*NOWIDEN : ',	['pr']],
  \ ['extproc(*JAVA : ',	['pr']],
  \ ['extproc(',		['pr']],
  \ ['float(',			['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['graph(',			['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['import',			['s', 'ds', 'proc']],
  \ ['import(',			['s', 'ds', 'proc']],
  \ ['int(',			['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['ind',			['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['inz',			['s', 'ds', 'subf']],
  \ ['inz(',			['s', 'subf']],
  \ ['len(',			['s', 'ds', 'subf', 'pr', 'prp']],
  \ ['like(',			['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['likeds(',			['ds']],
  \ ['likefile(',		['prp']],
  \ ['likerec(',		['ds', 'subf', 'pr', 'prp']],
  \ ['noopt',			['s', 'ds']],
  \ ['nullind',			['s', 'ds']],
  \ ['nullind(',		['s', 'ds']],
  \ ['object',			['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['object(',			['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['occurs(',			['ds']],
  \ ['opdesc',			['pr']],
  \ ['options(',		['pip', 'prp']],
  \ ['overlay(',		['subf']],
  \ ['packed(',			['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['packeven',		['subf']],
  \ ['perrcd(',			['s']],
  \ ['pointer',			['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['pointer(',		['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['pos(',			['subf']],
  \ ['prefix(',			['subf']],
  \ ['psds',			['ds']],
  \ ['qualified',		['ds']],
  \ ['static',			['s', 'ds']],
  \ ['static(',			['s', 'ds']],
  \ ['template',		['s', 'ds']],
  \ ['time',			['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['time(',			['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['timestamp',		['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['timestamp(',		['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['ucs2(',			['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['uns(',			['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['value',			['pip', 'prp']],
  \ ['varchar(',		['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['vargraph(',		['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['varucs2(',		['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['zoned(',			['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
\ ]

function! rpgle#omni#Complete(findstart, base)
  if a:findstart
    " Locate the start of the item
    let line = getline('.')
    let start = col('.') - 1

    if line =~? '^\s*/'
      " Compiler directive
      let s:type = 'compdir'
      while start > 0
        if line[start - 1] =~? '\S'
          let start -= 1
        else
          break
        endif
      endwhile
    elseif line =~? '^\s*ctl-opt\>'
      " Header Specs
      let s:type = 'hspec'
      while start > 0
        if line[start - 1] =~? '\k'
          let start -= 1
        else
          break
        endif
      endwhile
    elseif line =~? '^\s*dcl-'
      " Declaration Specs
      let s:type = 'dspec'
      while start > 0
        if line[start - 1] =~? '\k'
          let start -= 1
        else
          break
        endif
      endwhile
    else
      " Assume Calculation Spec
      let s:type = 'cspec'
      let lastword = -1
      while start > 0
        if line[start - 1] =~? '\w'
          let start -= 1
        elseif line[start - 1] =~? '\.'
          if lastword == -1
            let lastword = start
          endif
          let start -= 1
        else
          break
        endif
      endwhile

      if lastword != -1
        let s:struct = strpart(line, start, lastword - start - 1)
        return lastword
      endif
    endif
    let s:struct = ''
    return start
  endif

  " Return list of matches:
  if s:type == 'compdir'
    return s:Compdir(a:base)
  elseif s:type == 'hspec'
    return s:HSpec(a:base)
  elseif s:type == 'dspec'
    return s:DSpec(a:base)
  elseif s:type == 'cspec'
    return s:CSpec(s:struct, a:base)
  endif
endfunction

function! s:Compdir(base)
  let line = getline('.')
  echom a:base
  " Filename completion
  if line =~? '^\s*/\%(include\|copy\)\s\+'
    let matches = globpath(&path, '*', 0, 1)
    call filter(matches, { key, val -> val =~? '\.\%(rpgleinc\|mbr\)$' })
    call map(matches, 's:Path2Suggetion(v:val)')
    call filter(matches, { key, val -> val =~? '\%(^\|,\)' . a:base })
    return map(matches, 's:Path2Item(v:val)')
  else
    return filter(['/copy', '/define', '/eject', '/else', '/elseif',
                 \ '/end-free', '/endif', '/eof', '/free', '/if', '/include',
                 \ '/restore', '/set', '/space', '/title', '/undefine'],
                \ { key, val -> val =~? '^' . a:base })
  endif
endfunction

function s:HSpec(base)
  return filter(['actgrp(', 'alloc(', 'altseq', 'alwnull(', 'aut(',
               \ 'bnddir(', 'ccsid(', 'ccsidcvt(', 'copynest(', 'copyright(',
               \ 'cursym(', 'cvtopt(', 'datedit(', 'datfmt(', 'dclopt(',
               \ 'debug', 'decedit(', 'decprec(', 'dftactgrp(', 'dftname(',
               \ 'enbpfrcol(', 'expropts(', 'extbinint', 'fixnbr(', 'fltdiv',
               \ 'formsalign', 'ftrans', 'genlvl(', 'indent(', 'intprec(',
               \ 'langid(', 'main(', 'nomain', 'openopt(', 'optimize(',
               \ 'option(', 'pgminfo(', 'prfdta(', 'srtseq(', 'stgmdl(',
               \ 'text(', 'thread(', 'timfmt(', 'truncnbr(', 'usrprf(',
               \ 'validate('],
              \ { key, val -> val =~? '^' . a:base })
endfunction

function s:DSpec(base)
  if a:base =~? 'dcl-'
    let matches = filter(['dcl-s', 'dcl-c', 'dcl-ds', 'dcl-pr', 'dcl-proc',
                        \ 'dcl-pi'],
                       \ { key, val -> val =~? '^' . a:base })
  else
    " Keyword completion
    let line = getline('.')
    let type = substitute(line,
      \ '^\s*dcl-\(s\|c\|ds\|pr\|proc\|pi\)\s\+\w\+\s\+.*',
      \ '\1', '')
    if type != line
      let matches = []
      for kw in s:keywords
        if kw[0] =~? '^' . a:base && index(kw[1], type) > -1
          call add(matches, kw[0])
        endif
      endfor
    else
      let matches = []
    endif
  endif

  return map(matches, 's:Keyword2Item(v:val)')
endfunction

function! s:CSpec(struct, base)
  let matches  = []
  let tags     = taglist('^' . a:base)
  let curbufnr = bufnr('%')
  let struct   = a:struct

  " Member completion
  if struct != ''
    " Resolve referenced data structure (``likeds(...)'')
    let struct_tags = taglist('^' . struct . '$')
    for tag in struct_tags
      if complete_check()
        break
      endif

      if tag['kind'] ==? "s" && has_key(tag, 'typeref')
        let struct = substitute(tag['typeref'], 'struct:', '', '')
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
      if tag['struct'] !=? struct
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

function! s:Path2Suggetion(path)
  let path = substitute(a:path,
        \ '^.\{-}\<qrpglesrc.file/\(\w\+\).\%(mbr\|rpgleinc\)$', '\1', '')
  if path == a:path
    let path = substitute(a:path,
          \ '^.\{-}\<\(\w\+\).file/\(\w\+\).\%(mbr\|rpgleinc\)$',
          \ '\1,\2',
          \ '')
  endif
  if path == a:path
    let path = a:path
  endif
  return path
endfunction

function! s:Path2Item(path)
  return {
    \ 'word': a:path
  \ }
endfunction

function! s:Tag2Item(tag)
  return {
    \ 'word': a:tag['name'],
    \ 'kind': a:tag['kind']
  \ }
endfunction

function! s:Keyword2Item(kw)
  return {
    \ 'word': a:kw
  \ }
endfunction
