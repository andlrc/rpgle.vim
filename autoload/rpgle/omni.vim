" Vim completion script
" Language:             Free-Form ILE RPG
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Jul 24, 2019
" Version:              10
" URL:                  https://github.com/andlrc/rpgle.vim
"
" Complete via tag files, this code is experimental

let s:keywords = [
  \ ['alias',		['ds']],
  \ ['align',		['ds']],
  \ ['alt(',		['s', 'ds']],
  \ ['altseq(',		['s', 'ds', 'subf', 'pi', 'pr', 'prp']],
  \ ['ascend',		['s', 'ds', 'prp']],
  \ ['based(',		['s', 'ds', 'pr']],
  \ ['bindec(',		['s', 'subf', 'pip', 'prp']],
  \ ['ccsid(',		['s', 'subf', 'pip', 'prp']],
  \ ['char(',		['s', 'subf', 'pip', 'prp']],
  \ ['class(',		['s', 'subf', 'pip', 'prp']],
  \ ['const(',		['c']],
  \ ['ctdata',		['s', 'subf']],
  \ ['date',		['s', 'subf', 'pip', 'prp']],
  \ ['date(',		['s', 'subf', 'pip', 'prp']],
  \ ['descend',		['s', 'ds', 'prp']],
  \ ['dim(',		['s', 'ds', 'pi', 'pip', 'pr', 'prp']],
  \ ['dtaara',		['s', 'ds', 'subf']],
  \ ['dtaara(',		['s', 'ds', 'subf']],
  \ ['export',		['s', 'ds', 'proc']],
  \ ['export(',		['s', 'ds', 'proc']],
  \ ['ext',		['ds']],
  \ ['extfld',		['subf']],
  \ ['extfld(',		['subf']],
  \ ['extname(',	['ds']],
  \ ['extpgm',		['pr']],
  \ ['extpgm(',		['pr']],
  \ ['extproc',		['pr']],
  \ ['extproc(',	['pr']],
  \ ['extproc(',	['pr']],
  \ ['float(',		['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['graph(',		['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['import',		['s', 'ds', 'proc']],
  \ ['import(',		['s', 'ds', 'proc']],
  \ ['int(',		['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['ind',		['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['inz',		['s', 'ds', 'subf']],
  \ ['inz(',		['s', 'subf']],
  \ ['len(',		['s', 'ds', 'subf', 'pr', 'prp']],
  \ ['like(',		['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['likeds(',		['ds']],
  \ ['likefile(',	['prp']],
  \ ['likerec(',	['ds', 'subf', 'pr', 'prp']],
  \ ['noopt',		['s', 'ds']],
  \ ['nullind',		['s', 'ds']],
  \ ['nullind(',	['s', 'ds']],
  \ ['object',		['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['object(',		['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['occurs(',		['ds']],
  \ ['opdesc',		['pr']],
  \ ['options(',	['pip', 'prp']],
  \ ['overlay(',	['subf']],
  \ ['packed(',		['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['packeven',	['subf']],
  \ ['perrcd(',		['s']],
  \ ['pointer',		['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['pointer(',	['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['pos(',		['subf']],
  \ ['prefix(',		['subf']],
  \ ['psds',		['ds']],
  \ ['qualified',	['ds']],
  \ ['static',		['s', 'ds']],
  \ ['static(',		['s', 'ds']],
  \ ['template',	['s', 'ds']],
  \ ['time',		['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['time(',		['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['timestamp',	['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['timestamp(',	['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['ucs2(',		['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['uns(',		['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['value',		['pip', 'prp']],
  \ ['varchar(',	['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['vargraph(',	['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['varucs2(',	['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
  \ ['zoned(',		['s', 'subf', 'pi', 'pip', 'pr', 'prp']],
\ ]

let s:bifs = [
  \ ['%abs', 'Absolute Value of Expression'],
  \ ['%addr', 'Get Address of Variable'],
  \ ['%alloc', 'Allocate Storage'],
  \ ['%bitand', 'Bitwise AND Operation'],
  \ ['%bitnot', 'Invert Bits'],
  \ ['%bitor', 'Bitwise OR Operation'],
  \ ['%bitxor', 'Bitwise Exclusive-OR Operation'],
  \ ['%char', 'Convert to Character Data'],
  \ ['%check', 'Check Characters'],
  \ ['%checkr', 'Check Reverse'],
  \ ['%data', 'document {:options}'],
  \ ['%date', 'Convert to Date'],
  \ ['%days', 'Number of Days'],
  \ ['%dec', 'Convert to Packed Decimal Format'],
  \ ['%dech', 'Convert to Packed Decimal Format with Half Adjust'],
  \ ['%decpos', 'Get Number of Decimal Positions'],
  \ ['%diff', 'Difference Between Two Date, Time, or Timestamp Values'],
  \ ['%div', 'Return Integer Portion of Quotient'],
  \ ['%editc', 'Edit Value Using an Editcode'],
  \ ['%editflt', 'Convert to Float External Representation'],
  \ ['%editw', 'Edit Value Using an Editword'],
  \ ['%elem', 'Get Number of Elements'],
  \ ['%eof', 'Return End or Beginning of File Condition'],
  \ ['%equal', 'Return Exact Match Condition'],
  \ ['%error', 'Return Error Condition'],
  \ ['%fields', 'Fields to update'],
  \ ['%float', 'Convert to Floating Format'],
  \ ['%found', 'Return Found Condition'],
  \ ['%graph', 'Convert to Graphic Value'],
  \ ['%handler', 'handlingProcedure : communicationArea '],
  \ ['%hours', 'Number of Hours'],
  \ ['%int', 'Convert to Integer Format'],
  \ ['%inth', 'Convert to Integer Format with Half Adjust'],
  \ ['%kds', 'Search Arguments in Data Structure'],
  \ ['%len', 'Get or Set Length'],
  \ ['%lookupxx', 'Look Up an Array Element'],
  \ ['%max', 'Maximum Value'],
  \ ['%min', 'Minimum Value'],
  \ ['%minutes', 'Number of Minutes'],
  \ ['%months', 'Number of Months'],
  \ ['%mseconds', 'Number of Microseconds'],
  \ ['%nullind', 'Query or Set Null Indicator'],
  \ ['%occur', 'Set/Get Occurrence of a Data Structure'],
  \ ['%open', 'Return File Open Condition'],
  \ ['%paddr', 'Get Procedure Address'],
  \ ['%parms', 'Return Number of Parameters'],
  \ ['%parmnum', 'Return Parameter Number'],
  \ ['%parser', 'parser {: options}'],
  \ ['%proc', 'Return Name of Current Procedure'],
  \ ['%realloc', 'Reallocate Storage'],
  \ ['%rem', 'Return Integer Remainder'],
  \ ['%replace', 'Replace Character String'],
  \ ['%scan', 'Scan for Characters'],
  \ ['%scanr', 'Scan Reverse for Characters'],
  \ ['%scanrpl', 'Scan and Replace Characters'],
  \ ['%seconds', 'Number of Seconds'],
  \ ['%shtdn', 'Shut Down'],
  \ ['%size', 'Get Size in Bytes'],
  \ ['%sqrt', 'Square Root of Expression'],
  \ ['%status', 'Return File or Program Status'],
  \ ['%str', 'Get or Store Null-Terminated String'],
  \ ['%subarr', 'Set/Get Portion of an Array'],
  \ ['%subdt', 'Extract a Portion of a Date, Time, or Timestamp'],
  \ ['%subst', 'Get Substring'],
  \ ['%this', 'Return Class Instance for Native Method'],
  \ ['%time', 'Convert to Time'],
  \ ['%timestamp', 'Convert to Timestamp'],
  \ ['%tlookupxx', 'Look Up a Table Element'],
  \ ['%trim', 'Trim Characters at Edges'],
  \ ['%triml', 'Trim Leading Characters'],
  \ ['%trimr', 'Trim Trailing Characters'],
  \ ['%ucs2', 'Convert to UCS-2 Value'],
  \ ['%uns', 'Convert to Unsigned Format'],
  \ ['%unsh', 'Convert to Unsigned Format with Half Adjust'],
  \ ['%xfoot', 'Sum Array Expression Elements'],
  \ ['%xlate', 'Translate'],
  \ ['%xml', 'xmlDocument {:options}'],
  \ ['%years', 'Number of Years']
\]

function! rpgle#omni#Complete(findstart, base) abort
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
        if line[start - 1] =~# '\w'
          let start -= 1
        elseif line[start - 1] ==# '.'
          let s:type = 'cspec_struct'
          let member_start = start
          let start -= 1
        elseif line[start - 1] ==# '%'
          let s:type = 'cspec_bif'
          let start -= 1
        else
          break
        endif
      endwhile

      if s:type ==# 'cspec_struct'
        let s:struct = strpart(line, start, member_start - start - 1)
        return member_start
      endif
    endif
    let s:struct = ''
    return start
  endif

  " Return list of matches:
  if s:type ==# 'compdir'
    return s:Compdir(a:base)
  elseif s:type ==# 'hspec'
    return s:HSpec(a:base)
  elseif s:type ==# 'dspec'
    return s:DSpec(a:base)
  elseif s:type ==# 'cspec_struct'
    return s:CSpecStruct(a:base, s:struct)
  elseif s:type ==# 'cspec_bif'
    return s:CSpecBIF(a:base)
  elseif s:type ==# 'cspec'
    return s:CSpec(a:base)
  endif
endfunction

function! s:Compdir(base) abort
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

function! s:HSpec(base) abort
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

function! s:DSpec(base) abort
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

" Member completion via tags
function! s:CSpecStruct(base, struct) abort
  let matches  = []
  let tags     = taglist('^' . a:base)
  let curbufnr = bufnr('%')
  let struct   = a:struct

  " Resolve referenced data structure (``likeds(...)'')
  let struct_tags = taglist('^' . struct . '$')
  for tag in struct_tags
    if complete_check()
      break
    endif

    if tag['kind'] ==? 's' && has_key(tag, 'typeref')
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

  return matches
endfunction

function! s:CSpecBIF(base) abort
  let matches = []
  for bif in s:bifs
    if bif[0] =~? '^' . a:base
      call add(matches, s:BIF2Item(bif))
    endif
  endfor
  return matches
endfunction

" Keyword completion via tags
function! s:CSpec(base) abort
  let matches  = []
  let tags     = taglist('^' . a:base)
  let curbufnr = bufnr('%')

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

return matches
endfunction

function! s:Path2Suggetion(path) abort
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

function! s:Path2Item(path) abort
  return {
    \ 'word': a:path
  \ }
endfunction

function! s:Tag2Item(tag) abort
  return {
    \ 'word': a:tag['name'],
    \ 'kind': a:tag['kind']
  \ }
endfunction

function! s:Keyword2Item(kw) abort
  return {
    \ 'word': a:kw
  \ }
endfunction

function! s:BIF2Item(bif) abort
  return {
    \ 'word': a:bif[0],
    \ 'abbr': printf('%-10s - %s', a:bif[0], a:bif[1])
  \ }
endfunction
