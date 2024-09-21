" Vim syntax file
" Language:	Spice circuit simulator input netlist
" Maintainer:	Noam Halevy <Noam.Halevy.motorola.com>
" Last Change:	2012 Jun 01
" 		(Dominique Pelle added @Spell)
"
" This is based on sh.vim by Lennart Schultz
" but greatly simplified

" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" spice syntax is case INsensitive
syn case ignore
set iskeyword+=.,:

syn keyword	spiceTodo	contained TODO

syn match spiceComment  "^ \=\*.*$" contains=@Spell
syn match spiceComment  "\$.*$" contains=@Spell

" Numbers, all with engineering suffixes and optional units
"==========================================================
" integer number with optional exponent
" syn match spiceNumber  "\<[0-9]\+\(e[-+]\=[0-9]\+\)\=\(meg\=\|[afpnumkg]\)\="
" floating point number, with dot, optional exponent
" syn match spiceNumber  "\<[0-9]\.[0-9]\+\(e[-+]\=[0-9]\+\)\=\(meg\=\|[afpnumkg]\)\="
" floating point number, starting with a dot, optional exponent
" syn match spiceNumber  "\<\.[0-9]\+\(e[-+]\=[0-9]\+\)\=\(meg\=\|[afpnumkg]\)\="

" Ultimate single representation for all numbers
syn match spiceNumber  "\<\([0-9]*\.[0-9]\+\|[0-9]\+\(\.[0-9]\+\)\=\)\(e[-+]\=[0-9]\+\)\=\(meg\=\|[afpnumkg]\)\="

" Misc
"=====
syn match   spiceWrapLineOperator       "\\$"
syn match   spiceWrapLineOperator       "^+"

syn match   spiceStatement      "^ \=\.\I\+"
syn match   spiceCommand "^\.\w\+"

" Matching pairs of parentheses
"==========================================
syn region  spiceParen transparent matchgroup=spiceOperator start="(" end=")" contains=ALLBUT,spiceParenError,spicePinName,spicePinNameCont,spiceCellName
syn region  spiceSinglequote matchgroup=spiceOperator start=+'+ end=+'+
syn region  spiceCell transparent start="^\.subckt" end="^\.ends" fold keepend

" syn match   spiceCellName "\S\+" contained nextgroup=spicePinName skipwhite containedin=spiceCell
" syn match   spicePinName "[^ \t+\/]\+" contained skipwhite nextgroup=spicePinName,spicePinNameCont containedin=spiceCell

syn region  spiceCellDeclare transparent start="^\.subckt" skip="^ \=\*.*$" end="^\([^+].*\|\)$"me=s-1 contained containedin=spiceCell contains=spiceCellName,spicePinName,spicePinNameCont,spiceComment
syn match   spiceCellName "[^ \t+\/]\+" contained nextgroup=spicePinName skipwhite containedin=spiceCellDeclare
syn match   spicePinName "[^ \t+\/]\+" contained skipwhite nextgroup=spicePinName,spicePinNameCont containedin=spiceCellDeclare
syn match   spicePinNameCont "\n+\s*[^ \t+\/]\+" transparent display contained skipwhite nextgroup=spicePinName contains=spiceWrapLineOperator,spicePinName containedin=spiceCellDeclare
syn match   spiceSubckt "^\.subckt" nextgroup=spiceCellName skipwhite containedin=spiceCellDeclare,spiceCommand contained
syn match   spiceSubckt "^\.ends" containedin=spiceCell,spiceCommand contained
syn match   spiceParam "[^ \t$+]\+\ze\s*="
syn match   spiceDevice "^[RCXM]\S\+"

syn match spiceComment  "^ \=\*.*$" contains=@Spell
syn match spiceComment  "\$.*$" contains=@Spell

syn region spfRCRegion transparent start="^\*|NET" end="^\([^*RC].*\|\)$"me=s-1 contains=spiceDevice,spiceNumber,spiceComment fold keepend

syn iskeyword @,48-57,192-255,$,_,.

" Errors
"=======
syn match spiceParenError ")"

" Syncs
" =====
syn sync minlines=50

" Define the default highlighting.
" Only when an item doesn't have highlighting yet

hi def link spiceTodo		Todo
hi def link spiceWrapLineOperator	spiceOperator
hi def link spiceSinglequote	spiceExpr
hi def link spiceExpr		Function
hi def link spiceParenError	Error
hi def link spiceStatement		Statement
hi def link spiceNumber		Number
hi def link spiceComment		Comment
hi def link spiceOperator		Operator

hi spiceCellName cterm=BOLD            ctermfg=white ctermbg=18 guifg=white guibg=#000087
hi spicePinName  cterm=UNDERLINE       
hi spiceCommand   cterm=BOLD            ctermfg=11  guifg=#ffff00
hi spiceParam    cterm=BOLD            ctermfg=37  guifg=#00afaf
hi spiceDevice   cterm=BOLD            ctermfg=105 guifg=#8787ff
hi def link spiceSubckt spiceCommand

set fdm=syntax

let b:current_syntax = "spice"

" insert the following to $VIM/syntax/scripts.vim
" to autodetect HSpice netlists and text listing output:
"
" " Spice netlists and text listings
" elseif getline(1) =~ 'spice\>' || getline("$") =~ '^\.end'
"   so <sfile>:p:h/spice.vim

" vim: ts=8
