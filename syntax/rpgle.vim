if exists("b:current_syntax")
	finish
endif

syn case ignore
let b:current_syntax = "rpgle"

" Fixed Format DSpec
syntax match rpgleDSpecHead "\v^D" nextgroup=rpgleDSpecName,rpgleDSpecNameLong

syntax match rpgleDSpecName "\v.{15}" nextgroup=rpgleDSpecETDS contained
syntax match rpgleDSpecETDS "\v.{4}" nextgroup=rpgleDSpecSize contained
syntax match rpgleDSpecSize "\v[ 0-9]{14}" nextgroup=rpgleDSpecType contained
syntax match rpgleDSpecType "\v." nextgroup=rpgleDSpecDecPrec contained
syntax match rpgleDSpecDecPrec "\v [ 0-9] ?" nextgroup=rpgleDSpecKeyword contained
syntax match rpgleDSpecKeyword "\v.{0,37}" nextgroup=rpgleDSpecComment contained
syntax match rpgleDSpecComment "\v.*$" contains=rpgleTodo contained

syntax match rpgleDSpecNameLong "\v *[^ ]+\.\.\." contained

hi link rpgleDSpecHead Constant
hi link rpgleDSpecName Identifier
hi link rpgleDSpecETDS Special
hi link rpgleDSpecSize Number
hi link rpgleDSpecType Type
hi link rpgleDSpecDecPrec Number
hi link rpgleDSpecKeyword Keyword
hi link rpgleDSpecComment Comment

hi link rpgleDSpecNameLong Identifier

" Fixed Format PSpec
syntax match rpglePSpecHead "\v^P" nextgroup=rpglePSpecName,rpglePSpecNameLong
syntax match rpglePSpecName "\v.{15}" nextgroup=rpglePSpecB contained
syntax match rpglePSpecB "\v[ ]{2}B" nextgroup=rpglePSpecKeyword contained
syntax match rpglePSpecKeyword "\v[ ]{19}.{0,37}" nextgroup=rpglePSpecComment contained
syntax match rpglePSpecComment "\v.*$" contains=rpgleTodo contained

syntax match rpglePSpecNameLong "\v *[^ ]+\.\.\." contained

hi link rpglePSpecHead Constant
hi link rpglePSpecName Identifier
hi link rpglePSpecB Constant
hi link rpglePSpecKeyword Keyword
hi link rpglePSpecComment Comment

hi link rpglePSpecNameLong Identifier

" Fixed Format Comments
syntax match rpgleComment "\v^[HDFICOP]\*.*$" contains=rpgleTodo

" Free Format
syntax match rpgleOperator "\v\+"
syntax match rpgleOperator "\v\."
syntax match rpgleOperator "\v\-"
syntax match rpgleOperator "\v\*"
syntax match rpgleOperator "\v\/"
syntax match rpgleOperator "\v\="
syntax match rpgleOperator "\v\>"
syntax match rpgleOperator "\v\<"
syntax match rpgleOperator "\v\*\*"
syntax match rpgleOperator "\v\<\>"
syntax match rpgleOperator "\v\>\="
syntax match rpgleOperator "\v\<\="
syntax match rpgleOperator "\v\bNOT\b"
syntax match rpgleOperator "\v\bAND\b"
syntax match rpgleOperator "\v\bOR\b"

syntax keyword rpgleConditional if else elseif endif
syntax keyword rpgleRepeat for do dow dou enddo
syntax keyword rpgleLabel select when other endsl
syntax keyword rpgleLabel begsr endsr exsr

syntax keyword rpgleKeyword not acq add adddur alloc and bitoff biton cab call callb callp cas cat chain check
	\ checkr clear close commit comp dealloc define delete div dsply dump eval evalr except exfmt exsr extrct
	\ feod force goto in iter kfld klist leave leavesr lookup mhhzo mhlzo mlhzo mllzo monitor move movea movel
	\ mult mvr next occur on open or other out parm plist post read readc reade readp readpe realloc rel reset
	\ reset return rolbk scan setgt setll setoff seton shtdn sorta sqrt sub subdur subst tag test testb testn
	\ testz time unlock update write xfoot xlate

syntax match rpgleKeyword "z-add"
syntax match rpgleKeyword "z-sub"

syntax region rpgleString start="\v'" skip="\v\\." end="\v'"
syntax match rpgleProcedure /\w\+\s*(/me=e-1

syntax match rpgleComment "\v//.*$" contains=rpgleTodo
syntax region rpgleComment start=/\v\/\*/ skip=/\v\\./ end=/\v\*\// contains=rpgleTodo

hi link rpgleOperator Operator
hi link rpgleConditional Conditional
hi link rpgleRepeat Repeat
hi link rpgleLabel Label
hi link rpgleKeyword Keyword
hi link rpgleBIF Function
hi link rpgleProcedure Function
hi link rpgleIdentifier Identifier
hi link rpgleConstants Constant
hi link rpgleString String
hi link rpgleInclude Include
hi link rpgleComment Comment
hi link rpgleTodo Todo

" Shared

setlocal iskeyword+=%
syntax keyword rpgleBIF %abs %addr %alloc %bitand %bitnot %bitor %bitxor %char %check %checkr %date %days
	\ %dec %dech %decpos %diff %div %editc %editflt %editw %elem %eof %equal %error %fields %float %found %graph
	\ %hours %int %inth %kds %len %lookup %minutes %months %mseconds %nullind %occur %open %paddr %paddr %parms
	\ %realloc %rem %replace %scan %seconds %shtdn %size %sqrt %status %str %str %str %subdt %this %time
	\ %timestamp %tlookup %trim %triml %trimr %ucs2 %uns %unsh %xfoot %xlateyears

syntax match rpgleInclude "\v^\/include.*$"
syntax match rpgleInclude "\v^\/copy.*$"

syntax match rpgleIdentifier "\v\*IN0[1-9]"
syntax match rpgleIdentifier "\v\*IN[1-9][0-9]"
syntax match rpgleIdentifier "\v\*INH[1-9]"
syntax match rpgleIdentifier "\v\*INL[1-9]"
syntax match rpgleIdentifier "\v\*INLR"
syntax match rpgleIdentifier "\v\*INU[1-8]"
syntax match rpgleIdentifier "\v\*INRT"

syntax match rpgleConstants "\v\*ON"
syntax match rpgleConstants "\v\*OFF"
syntax match rpgleConstants "\v\*ENTRY"
syntax match rpgleConstants "\v\*ALL"
syntax match rpgleConstants "\v\*BLANK"
syntax match rpgleConstants "\v\*BLANKS"
syntax match rpgleConstants "\v\*ZERO"
syntax match rpgleConstants "\v\*ZEROS"
syntax match rpgleConstants "\v\*HIVAL"
syntax match rpgleConstants "\v\*LOVAL"
syntax match rpgleConstants "\v\*NULL"

syntax match rpgleTodo "\v(TODO|FIXME)"
