if exists("b:current_syntax")
	finish
endif

syn case ignore
let b:current_syntax = "rpgle"

" Fixed Format FSpec
" FFilename++IPEASFRlen+LKlen+AIDevice+.Keywords+++++++++++++++++++++++++++++Comments++++++++++++
syntax match rpgleFSpecHead "\v^F" nextgroup=rpgleFSpecName
syntax match rpgleFSpecName "\v.{10}" nextgroup=rpgleFSpecType contained
syntax match rpgleFSpecType "\v[IOUC]" nextgroup=rpgleFSpecDesignation contained
syntax match rpgleFSpecDesignation "\v[ PSRTF]" nextgroup=rpgleFSpecEOF contained
syntax match rpgleFSpecEOF "\v[E ]" nextgroup=rpgleFSpecAddition contained
syntax match rpgleFSpecAddition "\v[ A]" nextgroup=rpgleFSpecSequence contained
syntax match rpgleFSpecSequence "\v[A D]" nextgroup=rpgleFSpecFormat contained
syntax match rpgleFSpecFormat "\v[FE]" nextgroup=rpgleFSpecRecordLength contained
syntax match rpgleFSpecRecordLength "\v[0-9 ]{5}" nextgroup=rpgleFSpecLimitProcessing contained
syntax match rpgleFSpecLimitProcessing "\v[L ]" nextgroup=rpgleFSpecKeyLength contained
syntax match rpgleFSpecKeyLength "\v[ 0-9]{5}" nextgroup=rpgleFSpecRecordAddrType contained
syntax match rpgleFSpecRecordAddrType "\v[ APGKDTZF]" nextgroup=rpgleFSpecOrganization contained
syntax match rpgleFSpecOrganization "\v[ IT]" nextgroup=rpgleFSpecDevice contained
syntax match rpgleFSpecDevice "\v.{0,7} " nextgroup=rpgleFSpecKeyword contained
syntax match rpgleFSpecKeyword "\v.{0,37}" nextgroup=rpgleFSpecComment contained
syntax match rpgleFSpecComment "\v.*$" contained

hi link rpgleFSpecHead Constant
hi link rpgleFSpecName Identifier
hi link rpgleFSpecType SpecialChar
hi link rpgleFSpecDesignation Type
hi link rpgleFSpecEOF SpecialChar
hi link rpgleFSpecAddition Type
hi link rpgleFSpecSequence SpecialChar
hi link rpgleFSpecFormat Type
hi link rpgleFSpecRecordLength Number
hi link rpgleFSpecLimitProcessing SpecialChar
hi link rpgleFSpecKeyLength Number
hi link rpgleFSpecRecordAddrType SpecialChar
hi link rpgleFSpecOrganization Type
"hi link rpgleFSpecDevice
hi link rpgleFSpecKeyword Statement
hi link rpgleFSpecComment Comment

" Fixed Format DSpec
" DName+++++++++++ETDsFrom+++To/L+++IDc.Keywords+++++++++++++++++++++++++++++Comments++++++++++++
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
" PName+++++++++++..B...................Keywords+++++++++++++++++++++++++++++Comments++++++++++++
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
syntax keyword rpgleRepeat do dow dou enddo for to endfor
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

syntax match rpgleNumber "\v<[0-9]+>"

" Exec sql
syntax match rpgleExecSqlHead "\vexec[ \n\t]+sql[\n\t ]+" nextgroup=rpgleExecSqlRegion
syntax region rpgleExecSqlRegion start="" skip="\v\\." end=";" contains=rpgleExecSqlFill,rpgleExecSqlKeyword,rpgleExecSqlInfo,rpgleExecSqlUDTF,rpgleExecSqlString,rpgleExecSqlColumnName contained
syntax match rpgleExecSqlFill "\v[^ \n\t;]+[ \n\t]*" nextgroup=rpgleExecSqlFill,rpgleExecSqlKeyword,rpgleExecSqlInfo,rpgleExecSqlUDTF,rpgleExecSqlString,rpgleExecSqlColumnName contained
syntax match rpgleExecSqlKeyword "\v<(ADD|AFTER|ALL|ALLOCATE|ALLOW|ALTER|AND|ANY|AS|ASENSITIVE|ASSOCIATE|ASUTIME|AT|AUDIT|AUX|AUXILIARY|BEFORE)>" nextgroup=rpgleExecSqlFill,rpgleExecSqlKeyword,rpgleExecSqlInfo,rpgleExecSqlUDTF,rpgleExecSqlString,rpgleExecSqlColumnName contained
syntax match rpgleExecSqlKeyword "\v<(BEGIN|BETWEEN|BUFFERPOOL|BY|CALL|CAPTURE|CASCADED|CASE|CAST|CCSID|CHAR|CHARACTER|CHECK|CLONE|CLOSE|CLUSTER)>" nextgroup=rpgleExecSqlFill,rpgleExecSqlKeyword,rpgleExecSqlInfo,rpgleExecSqlUDTF,rpgleExecSqlString,rpgleExecSqlColumnName contained
syntax match rpgleExecSqlKeyword "\v<(COLLECTION|COLLID|COLUMN|COMMENT|COMMIT|CONCAT|CONDITION|CONNECT|CONNECTION|CONSTRAINT|CONTAINS|CONTENT)>" nextgroup=rpgleExecSqlFill,rpgleExecSqlKeyword,rpgleExecSqlInfo,rpgleExecSqlUDTF,rpgleExecSqlString,rpgleExecSqlColumnName contained
syntax match rpgleExecSqlKeyword "\v<(CONTINUE|CREATE|CURRENT|CURRENT_DATE|CURRENT_LC_CTYPE|CURRENT_PATH|CURRENT_SCHEMA|CURRENT_TIME)>" nextgroup=rpgleExecSqlFill,rpgleExecSqlKeyword,rpgleExecSqlInfo,rpgleExecSqlUDTF,rpgleExecSqlString,rpgleExecSqlColumnName contained
syntax match rpgleExecSqlKeyword "\v<(CURRENT_TIMESTAMP|CURSOR|DATA|DATABASE|DAY|DAYS|DBINFO|DECLARE|DEFAULT|DELETE|DESCRIPTOR|DETERMINISTIC)>" nextgroup=rpgleExecSqlFill,rpgleExecSqlKeyword,rpgleExecSqlInfo,rpgleExecSqlUDTF,rpgleExecSqlString,rpgleExecSqlColumnName contained
syntax match rpgleExecSqlKeyword "\v<(DISABLE|DISALLOW|DISTINCT|DO|DOCUMENT|DOUBLE|DROP|DSSIZE|DYNAMIC|EDITPROC|ELSE|ELSEIF|ENCODING|ENCRYPTION)>" nextgroup=rpgleExecSqlFill,rpgleExecSqlKeyword,rpgleExecSqlInfo,rpgleExecSqlUDTF,rpgleExecSqlString,rpgleExecSqlColumnName contained
syntax match rpgleExecSqlKeyword "\v<(END|ENDING|END-EXEC2|ERASE|ESCAPE|EXCEPT|EXCEPTION|EXECUTE|EXISTS|EXIT|EXPLAIN|EXTERNAL|FENCED|FETCH)>" nextgroup=rpgleExecSqlFill,rpgleExecSqlKeyword,rpgleExecSqlInfo,rpgleExecSqlUDTF,rpgleExecSqlString,rpgleExecSqlColumnName contained
syntax match rpgleExecSqlKeyword "\v<(FIELDPROC|FINAL|FOR|FREE|FROM|FULL|FUNCTION|GENERATED|GET|GLOBAL|GO|GOTO|GRANT|GROUP|HANDLER|HAVING|HOLD)>" nextgroup=rpgleExecSqlFill,rpgleExecSqlKeyword,rpgleExecSqlInfo,rpgleExecSqlUDTF,rpgleExecSqlString,rpgleExecSqlColumnName contained
syntax match rpgleExecSqlKeyword "\v<(HOUR|HOURS|IF|IMMEDIATE|IN|INCLUSIVE|INDEX|INHERIT|INNER|INOUT|INSENSITIVE|INSERT|INTERSECT|INTO|IS|ISOBID)>" nextgroup=rpgleExecSqlFill,rpgleExecSqlKeyword,rpgleExecSqlInfo,rpgleExecSqlUDTF,rpgleExecSqlString,rpgleExecSqlColumnName contained
syntax match rpgleExecSqlKeyword "\v<(ITERATE|JAR|JOIN|KEEP|KEY|LABEL|LANGUAGE|LC_CTYPE|LEAVE|LEFT|LIKE|LOCAL|LOCALE|LOCATOR|LOCATORS|LOCK)>" nextgroup=rpgleExecSqlFill,rpgleExecSqlKeyword,rpgleExecSqlInfo,rpgleExecSqlUDTF,rpgleExecSqlString,rpgleExecSqlColumnName contained
syntax match rpgleExecSqlKeyword "\v<(LOCKMAX|LOCKSIZE|LONG|LOOP|MAINTAINED|MATERIALIZED|MICROSECOND|MICROSECONDS|MINUTE|MINUTES|MODIFIES|MONTH)>" nextgroup=rpgleExecSqlFill,rpgleExecSqlKeyword,rpgleExecSqlInfo,rpgleExecSqlUDTF,rpgleExecSqlString,rpgleExecSqlColumnName contained
syntax match rpgleExecSqlKeyword "\v<(MONTHS|NEXTVAL|NO|NONE|NOT|NULL|NULLS|NUMPARTS|OBID|OF|ON|OPEN|OPTIMIZATION|OPTIMIZE|OR|ORDER|OUT|OUTER)>" nextgroup=rpgleExecSqlFill,rpgleExecSqlKeyword,rpgleExecSqlInfo,rpgleExecSqlUDTF,rpgleExecSqlString,rpgleExecSqlColumnName contained
syntax match rpgleExecSqlKeyword "\v<(PACKAGE|PARAMETER|PART|PADDED|PARTITION|PARTITIONED|PARTITIONING|PATH|PIECESIZE|PLAN|PRECISION|PREPARE)>" nextgroup=rpgleExecSqlFill,rpgleExecSqlKeyword,rpgleExecSqlInfo,rpgleExecSqlUDTF,rpgleExecSqlString,rpgleExecSqlColumnName contained
syntax match rpgleExecSqlKeyword "\v<(PREVVAL|PRIQTY|PRIVILEGES|PROCEDURE|PROGRAM|PSID|PUBLIC|QUERY|QUERYNO|READS|REFERENCES|REFRESH|RESIGNAL)>" nextgroup=rpgleExecSqlFill,rpgleExecSqlKeyword,rpgleExecSqlInfo,rpgleExecSqlUDTF,rpgleExecSqlString,rpgleExecSqlColumnName contained
syntax match rpgleExecSqlKeyword "\v<(RELEASE|RENAME|REPEAT|RESTRICT|RESULT|RESULT_SET_LOCATOR|RETURN|RETURNS|REVOKE|RIGHT|ROLE|ROLLBACK)>" nextgroup=rpgleExecSqlFill,rpgleExecSqlKeyword,rpgleExecSqlInfo,rpgleExecSqlUDTF,rpgleExecSqlString,rpgleExecSqlColumnName contained
syntax match rpgleExecSqlKeyword "\v<(ROUND_CEILING|ROUND_DOWN|ROUND_FLOOR|ROUND_HALF_DOWN|ROUND_HALF_EVEN|ROUND_HALF_UP|ROUND_UP|ROW|ROWSET)>" nextgroup=rpgleExecSqlFill,rpgleExecSqlKeyword,rpgleExecSqlInfo,rpgleExecSqlUDTF,rpgleExecSqlString,rpgleExecSqlColumnName contained
syntax match rpgleExecSqlKeyword "\v<(RUN|SAVEPOINT|SCHEMA|SCRATCHPAD|SECOND|SECONDS|SECQTY|SECURITY|SEQUENCE|SELECT|SENSITIVE|SESSION_USER|SET)>" nextgroup=rpgleExecSqlFill,rpgleExecSqlKeyword,rpgleExecSqlInfo,rpgleExecSqlUDTF,rpgleExecSqlString,rpgleExecSqlColumnName contained
syntax match rpgleExecSqlKeyword "\v<(SIGNAL|SIMPLE|SOME|SOURCE|SPECIFIC|STANDARD|STATIC|STATEMENT|STAY|STOGROUP|STORES|STYLE|SUMMARY|SYNONYM)>" nextgroup=rpgleExecSqlFill,rpgleExecSqlKeyword,rpgleExecSqlInfo,rpgleExecSqlUDTF,rpgleExecSqlString,rpgleExecSqlColumnName contained
syntax match rpgleExecSqlKeyword "\v<(TABLE|TABLESPACE|THEN|TO|TRIGGER|TRUNCATE|TYPE|UNDO|UNION|UNIQUE|UNTIL|UPDATE|USER|USING|VALIDPROC|VALUE)>" nextgroup=rpgleExecSqlFill,rpgleExecSqlKeyword,rpgleExecSqlInfo,rpgleExecSqlUDTF,rpgleExecSqlString,rpgleExecSqlColumnName contained
syntax match rpgleExecSqlKeyword "\v<(VALUES|VARIABLE|VARIANT|VCAT|VIEW|VOLATILE|VOLUMES|WHEN|WHENEVER|WHERE|WHILE|WITH|WLM|XMLEXISTS)>" nextgroup=rpgleExecSqlFill,rpgleExecSqlKeyword,rpgleExecSqlInfo,rpgleExecSqlUDTF,rpgleExecSqlString,rpgleExecSqlColumnName contained
syntax match rpgleExecSqlKeyword "\v<(XMLNAMESPACES|XMLCAST|YEAR|YEARS)>" nextgroup=rpgleExecSqlFill,rpgleExecSqlKeyword,rpgleExecSqlInfo,rpgleExecSqlUDTF,rpgleExecSqlString,rpgleExecSqlColumnName contained
syntax match rpgleExecSqlInfo "\v\:" nextgroup=rpgleExecSqlIdentifier contained
syntax match rpgleExecSqlIdentifier "\v[\n\t ]*[^ \n\t\,; ]+" nextgroup=rpgleExecSqlFill,rpgleExecSqlKeyword,rpgleExecSqlInfo,rpgleExecSqlUDTF,rpgleExecSqlString,rpgleExecSqlColumnName contained
syntax match rpgleExecSqlUDTF /\w\+\s*(/me=e-1 nextgroup=rpgleExecSqlFill,rpgleExecSqlKeyword,rpgleExecSqlInfo,rpgleExecSqlUDTF,rpgleExecSqlString,rpgleExecSqlColumnName contained
syntax region rpgleExecSqlString start="\v'" skip="\v\\." end="\v'" nextgroup=rpgleExecSqlFill,rpgleExecSqlKeyword,rpgleExecSqlInfo,rpgleExecSqlUDTF,rpgleExecSqlString,rpgleExecSqlColumnName contained
syntax region rpgleExecSqlColumnName start="\v\"" skip="\v\\." end="\v\"" nextgroup=rpgleExecSqlFill,rpgleExecSqlKeyword,rpgleExecSqlInfo,rpgleExecSqlUDTF,rpgleExecSqlString,rpgleExecSqlColumnName contained

hi link rpgleExecSqlRegion Include
hi link rpgleExecSqlHead Keyword
hi link rpgleExecSqlKeyword Keyword
hi link rpgleExecSqlInto Operator
hi link rpgleExecSqlIntoSep Operator
hi link rpgleExecSqlIdentifier Identifier
hi link rpgleExecSqlUDTF Function
hi link rpgleExecSqlString String
hi link rpgleExecSqlColumnName Constant

" String, etc...
syntax region rpgleString start="\v'" skip="\v\\." end="\v'"
syntax match rpgleProcedure /\w\+\s*(/me=e-1

syntax match rpgleComment "\v//.*$" contains=rpgleTodo
syntax region rpgleComment start=/\v\/\*/ skip=/\v\\./ end=/\v\*\// contains=rpgleTodo

hi link rpgleOperator Operator
hi link rpgleConditional Conditional
hi link rpgleRepeat Repeat
hi link rpgleLabel Label
hi link rpgleKeyword Keyword
hi link rpgleNumber Number
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

syntax match rpgleIdentifier "\v\*IN0[1-9]>"
syntax match rpgleIdentifier "\v\*IN[1-9][0-9]>"
syntax match rpgleIdentifier "\v\*INH[1-9]>"
syntax match rpgleIdentifier "\v\*INL[1-9]>"
syntax match rpgleIdentifier "\v\*INLR>"
syntax match rpgleIdentifier "\v\*INU[1-8]>"
syntax match rpgleIdentifier "\v\*INRT>"

syntax match rpgleIdentifier "\v<sqlcode>"
syntax match rpgleIdentifier "\v<SQLWARN0>"

syntax match rpgleConstants "\v\*ON>"
syntax match rpgleConstants "\v\*OFF>"
syntax match rpgleConstants "\v\*ENTRY>"
syntax match rpgleConstants "\v\*ALL>"
syntax match rpgleConstants "\v\*BLANK>"
syntax match rpgleConstants "\v\*BLANKS>"
syntax match rpgleConstants "\v\*ZERO>"
syntax match rpgleConstants "\v\*ZEROS>"
syntax match rpgleConstants "\v\*HIVAL>"
syntax match rpgleConstants "\v\*LOVAL>"
syntax match rpgleConstants "\v\*NULL>"

syntax match rpgleTodo "\v(TODO|FIXME)"
