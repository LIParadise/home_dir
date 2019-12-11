" Vim color file
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2001 Jul 23

" This is the default color scheme.  It doesn't define the Normal
" highlighting, it uses whatever the colors used to be.

" Set 'background' back to the default.  The value can't always be estimated
" and is then guessed.
hi clear Normal
set bg&

" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "MyLightThemeFallback"

hi Normal       ctermfg=16 ctermbg=231 guifg=#000000 guibg=#fcfcf0
" hi CursorLine   term=underline cterm=underline guibg=#cfcfcc
hi cursorline   term=underline cterm=NONE ctermfg=NONE ctermbg=254 guibg=#cfcfcc guifg=NONE
hi cursorlinenr cterm=NONE     ctermfg=232 guifg=#000000   ctermbg=NONE 
hi linenr       cterm=NONE     ctermfg=246 guifg=#949494   ctermbg=NONE 
hi constant     term=underline ctermfg=166 guifg=#D75F00 
hi comment      term=underline ctermfg=243 guifg=#767676 
hi PreProc      term=underline ctermfg=130 guifg=#AF5F00
hi Statement    term=underline ctermfg=91  guifg=#8700AF
hi type         term=underline ctermfg=64  guifg=#5F8700
hi special      term=underline ctermfg=168 guifg=#D75F87 
hi SpecialKey   term=underline ctermfg=134 guifg=#AF5FD7
hi Identifier   term=underline ctermfg=163 guifg=#D700AF 
hi error        term=underline ctermbg=160 ctermfg=231 guifg=#D70000 guibg=#ffffff
hi visual     term=reverse cterm=reverse guibg=#aaaaaa
hi Todo         term=underline ctermbg=220 guibg=#ffd700
if ( &filetype ==# 'c' || &filetype ==# 'cpp' )
  hi PreProc      term=underline ctermfg=199 guifg=#ff00af 
  hi type         term=underline ctermfg=26  guifg=#005FD7 
  hi Identifier   term=underline ctermfg=34  guifg=#00af00 
  hi Special      term=underline ctermfg=93  guifg=#8700FF
endif
