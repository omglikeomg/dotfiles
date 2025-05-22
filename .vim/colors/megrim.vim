set background=dark
if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

set t_Co=256
let g:colors_name = "megrim"

let s:t_Co = exists('&t_Co') && !empty(&t_Co) && &t_Co > 1 ? &t_Co : 1

hi Normal ctermfg=white ctermbg=NONE cterm=NONE
hi NonText ctermfg=darkgrey ctermbg=NONE cterm=NONE
hi EndOfBuffer ctermfg=darkgrey ctermbg=NONE cterm=NONE
hi LineNr ctermfg=lightgrey ctermbg=black cterm=NONE
hi FoldColumn ctermfg=lightgrey ctermbg=black cterm=NONE
hi Folded ctermfg=grey ctermbg=black cterm=NONE
hi MatchParen ctermfg=yellow ctermbg=black cterm=NONE
hi SignColumn ctermfg=lightgrey ctermbg=black cterm=NONE
hi Pmenu ctermfg=lightgrey ctermbg=darkgrey cterm=NONE
hi PmenuSbar ctermfg=NONE ctermbg=darkgrey cterm=NONE
hi PmenuSel ctermfg=black ctermbg=darkcyan cterm=NONE
hi PmenuThumb ctermfg=darkcyan ctermbg=darkcyan cterm=NONE
hi ErrorMsg ctermfg=darkred ctermbg=black cterm=reverse
hi ModeMsg ctermfg=green ctermbg=black cterm=reverse
hi MoreMsg ctermfg=darkcyan ctermbg=NONE cterm=NONE
hi Question ctermfg=green ctermbg=NONE cterm=NONE
hi WarningMsg ctermfg=darkred ctermbg=NONE cterm=NONE
hi TabLine ctermfg=darkyellow ctermbg=darkgrey cterm=NONE
hi TabLineFill ctermfg=darkgrey ctermbg=darkgrey cterm=NONE
hi TabLineSel ctermfg=black ctermbg=darkyellow cterm=NONE
hi ToolbarLine ctermfg=NONE ctermbg=black cterm=NONE
hi ToolbarButton ctermfg=lightgrey ctermbg=darkgrey cterm=NONE
hi Cursor ctermfg=black ctermbg=lightgrey cterm=NONE
hi CursorColumn ctermfg=NONE ctermbg=darkgrey cterm=NONE
hi CursorLineNr ctermfg=cyan ctermbg=darkgrey cterm=NONE
hi CursorLine ctermfg=NONE ctermbg=NONE cterm=underline
hi StatusLine ctermfg=darkgreen ctermbg=darkgrey cterm=NONE
hi StatusLineNC ctermfg=yellow ctermbg=darkgrey cterm=NONE
hi StatusLineTerm ctermfg=black ctermbg=darkyellow cterm=NONE
hi StatusLineTermNC ctermfg=yellow ctermbg=darkgrey cterm=NONE
hi Visual ctermfg=blue ctermbg=black cterm=reverse
hi VisualNOS ctermfg=NONE ctermbg=NONE cterm=underline
hi VertSplit ctermfg=darkgrey ctermbg=darkgrey cterm=NONE
hi WildMenu ctermfg=black ctermbg=blue cterm=NONE
hi DiffAdd ctermfg=cyan ctermbg=black cterm=reverse
hi DiffChange ctermfg=lightgrey ctermbg=black cterm=reverse
hi DiffDelete ctermfg=yellow ctermbg=black cterm=reverse
hi DiffText ctermfg=darkgrey ctermbg=black cterm=reverse
hi IncSearch ctermfg=black ctermbg=darkred cterm=NONE
hi Search ctermfg=black ctermbg=yellow cterm=NONE
hi Directory ctermfg=cyan ctermbg=NONE cterm=NONE
hi debugPC ctermfg=NONE ctermbg=darkblue cterm=NONE
hi debugBreakpoint ctermfg=NONE ctermbg=darkred cterm=NONE
hi SpellBad ctermfg=darkred ctermbg=NONE cterm=undercurl
hi SpellCap ctermfg=cyan ctermbg=NONE cterm=undercurl
hi SpellLocal ctermfg=darkgreen ctermbg=NONE cterm=undercurl
hi SpellRare ctermfg=red ctermbg=NONE cterm=undercurl
hi ColorColumn ctermfg=NONE ctermbg=black cterm=NONE
hi! link Terminal Normal
hi! link CursorIM Cursor
hi! link QuickFixLine Search
hi Comment ctermfg=grey ctermbg=NONE cterm=NONE
hi Conceal ctermfg=grey ctermbg=NONE cterm=NONE
hi String ctermfg=red ctermbg=NONE cterm=NONE
hi Error ctermfg=darkred ctermbg=NONE cterm=reverse
hi Identifier ctermfg=darkblue ctermbg=NONE cterm=bold
hi Ignore ctermfg=NONE ctermbg=NONE cterm=NONE
hi PreProc ctermfg=darkcyan ctermbg=NONE cterm=NONE
hi Special ctermfg=darkblue ctermbg=NONE cterm=NONE
hi Statement ctermfg=blue ctermbg=NONE cterm=NONE
hi Exception ctermfg=darkred ctermbg=NONE cterm=NONE
hi Constant ctermfg=lightmagenta ctermbg=NONE cterm=NONE
hi Todo ctermfg=NONE ctermbg=NONE cterm=reverse
hi Type ctermfg=magenta ctermbg=NONE cterm=NONE
hi Underlined ctermfg=darkcyan ctermbg=NONE cterm=underline
hi Function ctermfg=yellow ctermbg=NONE cterm=NONE
hi SpecialKey ctermfg=darkgrey ctermbg=NONE cterm=NONE
hi Title ctermfg=NONE ctermbg=NONE cterm=NONE
hi helpLeadBlank ctermfg=NONE ctermbg=NONE cterm=NONE
hi helpNormal ctermfg=NONE ctermbg=NONE cterm=NONE
hi! link Number Constant
hi! link Boolean Constant
hi! link Character Constant
hi! link Conditional Statement
hi! link Debug Special
hi! link Define PreProc
hi! link Delimiter Special
hi! link Exception Statement
hi! link Float Number
hi! link Include PreProc
hi! link Keyword Statement
hi! link Label Statement
hi! link Macro PreProc
hi! link Operator Statement
hi! link PreCondit PreProc
hi! link Repeat Statement
hi! link SpecialChar Special
hi! link SpecialComment Special
hi! link StorageClass Type
hi! link Structure Type
hi! link Tag Special
hi! link Typedef Type
hi! link HelpCommand Statement
hi! link HelpExample Statement
hi! link htmlTagName Statement
hi! link htmlEndTag htmlTagName
hi! link htmlLink Function
hi! link htmlSpecialTagName htmlTagName
hi! link htmlTag htmlTagName
hi! link htmlBold Normal
hi! link htmlItalic Normal
hi! link htmlArg htmlTagName
hi! link xmlTag Statement
hi! link xmlTagName Statement
hi! link xmlEndTag Statement
hi! link markdownItalic Preproc
hi! link asciidocQuotedEmphasized Preproc
hi! link jsxExpressionBlock Constant
hi! link typescriptTypeBlock Type
hi! link typescriptDefaultImportName Type

if s:t_Co >= 256
	hi DiffAdd ctermfg=111 ctermbg=235 cterm=reverse
	hi DiffChange ctermfg=188 ctermbg=235 cterm=reverse
	hi DiffDelete ctermfg=222 ctermbg=235 cterm=reverse
	hi DiffText ctermfg=145 ctermbg=235 cterm=reverse
  unlet s:t_Co
  finish
endif

