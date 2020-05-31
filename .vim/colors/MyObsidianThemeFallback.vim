" Vim color file
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2016 Oct 10

" This color scheme uses a dark grey background.

" First remove all existing highlighting.
hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "MyObsidianThemeFallback"

" hi Normal ctermbg=DarkGrey ctermfg=White guifg=White guibg=grey20
hi Normal            gui=NONE            cterm=NONE

" Groups used in the 'highlight' and 'guicursor' options default value.
hi ErrorMsg          term=standout       ctermbg=DarkRed      ctermfg=White    guibg=Red    guifg=White
hi IncSearch         term=reverse        cterm=reverse        gui=reverse
hi ModeMsg           term=bold           cterm=bold           gui=bold
hi StatusLine        term=reverse,bold   cterm=reverse,bold   gui=reverse,bold
hi StatusLineNC      term=reverse        cterm=reverse        gui=reverse
hi VertSplit         term=reverse        cterm=reverse        gui=reverse
" hi Visual            term=reverse        ctermbg=black        guibg=grey60
hi visual            term=reverse        cterm=reverse        guibg=#5d5d54
hi VisualNOS         term=underline,bold cterm=underline,bold gui=underline,bold
hi DiffText          term=reverse        cterm=bold           ctermbg=Red      gui=bold     guibg=Red
hi Cursor                                                                      guibg=Green guifg=Black
hi lCursor                                                                     guibg=Cyan guifg=Black
hi Directory term=bold ctermfg=LightCyan guifg=Cyan
" hi LineNr term=underline ctermfg=Yellow guifg=Yellow
hi linenr       cterm=NONE     ctermfg=244     guifg=#808080  ctermbg=NONE
hi MoreMsg term=bold ctermfg=LightGreen gui=bold guifg=SeaGreen
hi NonText term=bold ctermfg=LightBlue gui=bold guifg=LightBlue guibg=grey30
hi Question term=standout ctermfg=LightGreen gui=bold guifg=Green
hi Search term=reverse ctermbg=Yellow ctermfg=Black guibg=Yellow guifg=Black
" hi Special term=bold ctermfg=LightRed guifg=Orange
hi special      term=underline ctermfg=177 guifg=#D787FF
" hi SpecialKey term=bold ctermfg=LightBlue guifg=Cyan
hi SpecialKey   term=underline ctermfg=213 guifg=#FF87FF
hi Title term=bold ctermfg=LightMagenta gui=bold guifg=Magenta
hi WarningMsg term=standout ctermfg=LightRed guifg=Red
hi WildMenu term=standout ctermbg=Yellow ctermfg=Black guibg=Yellow guifg=Black
hi Folded term=standout ctermbg=LightGrey ctermfg=DarkBlue guibg=LightGrey guifg=DarkBlue
hi FoldColumn term=standout ctermbg=LightGrey ctermfg=DarkBlue guibg=Grey guifg=DarkBlue
hi DiffAdd term=bold ctermbg=DarkBlue guibg=DarkBlue
hi DiffChange term=bold ctermbg=DarkMagenta guibg=DarkMagenta
hi DiffDelete term=bold ctermfg=Blue ctermbg=DarkCyan gui=bold guifg=Blue guibg=DarkCyan
hi CursorColumn term=reverse ctermbg=Black guibg=grey40
hi cursorline   ctermbg=NONE guibg=NONE cterm=NONE gui=NONE

" Groups for syntax highlighting
" hi Constant term=underline ctermfg=Magenta guifg=#ffa0a0
hi constant     term=underline ctermfg=215     guifg=#FFAF5F
" if &t_Co > 8
"   hi Statement term=bold cterm=bold ctermfg=Yellow guifg=#ffff60 gui=bold
" endif
hi Ignore ctermfg=DarkGrey guifg=grey20

hi cursorlinenr cterm=NONE     ctermfg=255     guifg=#f3f3f3  ctermbg=NONE
hi comment      term=underline ctermfg=246     guifg=#949494
hi PreProc      term=underline ctermfg=105     guifg=#8787FF
hi type         term=underline ctermfg=80      guifg=#5FD7D7
hi statement    term=underline ctermfg=113     guifg=#87D75F
hi error        term=underline ctermbg=166     guifg=#f3f3f3  ctermfg=255 guibg=#d75f00
hi Todo         term=underline ctermbg=221 guibg=#FFD75F

hi pmenu        guibg=DarkMagenta
hi PmenuSel     guibg=Grey20
hi tabline      guibg=Grey42

if ( &filetype ==# 'zsh' || &filetype ==# 'sh' || &filetype ==# 'vim' )
  hi type         term=underline ctermfg=144 guifg=#AFAF87
  hi Identifier   term=underline ctermfg=110 guifg=#87AFD7
  hi statement    term=underline ctermfg=114 guifg=#87D787
  hi PreProc      term=underline ctermfg=111 guifg=#87AFFF
endif
