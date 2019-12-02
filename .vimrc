set nu ai expandtab tabstop=2 shiftwidth=2 history=200 cursorline laststatus=2 statusline+=%<%F\ %h%m%r%=%-16.(%l,%c%V%)\ %P t_Co=256 ignorecase smartcase showcmd
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

" %m%F\ \ %1.4c,%1.6l
" :set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

" set statusline=[%{expand('%:p')}][%{strlen(&fenc)?&fenc:&enc},\ %{&ff},\ %{strlen(&filetype)?&filetype:'plain'}]%{FileSize()}%{IsBinary()}%=%c,%l/%L\ [%3p%%]

filetype indent on
syntax on

hi linenr       cterm=NONE  ctermfg=244  ctermbg=NONE guibg=NONE guifg=NONE
hi cursorlinenr cterm=NONE  ctermfg=255  ctermbg=NONE guibg=NONE guifg=NONE
hi cursorline   cterm=NONE  ctermfg=NONE ctermbg=NONE guibg=NONE guifg=NONE

" ctags
set tags=./tags,./TAGS,$HOME/.tags/tags,$HOME/.tags/TAGS,tags;$HOME,TAGS;$HOME,src/tags,src/TAGS

" handling lambda functions;
function! Lambda_cpp()
  setlocal cindent cino=j1,(0,ws,Ws,N-s
endfunction

" tab index support
if (exists("g:loaded_tabline_vim") && g:loaded_tabline_vim) || &cp
  finish
endif
let g:loaded_tabline_vim = 1

function! Tabline()
  let s = ''
  for i in range(tabpagenr('$'))
    let tab = i + 1
    let winnr = tabpagewinnr(tab)
    let buflist = tabpagebuflist(tab)
    let bufnr = buflist[winnr - 1]
    let bufname = bufname(bufnr)
    let bufmodified = getbufvar(bufnr, "&mod")

    let s .= '%' . tab . 'T'
    let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' ' . tab .':'
    let s .= (bufname != '' ? '['. fnamemodify(bufname, ':t') . '] ' : '[No Name] ')

    if bufmodified
      let s .= '[+] '
    endif
  endfor

  let s .= '%#TabLineFill#'
  if (exists("g:tablineclosebutton"))
    let s .= '%=%999XX'
  endif
  return s
endfunction
set tabline=%!Tabline()
" end of tab index support




" tab index support
" if exists("+showtabline")
"   function! MyTabLine()
"     let s = ''
"     let wn = ''
"     let t = tabpagenr()
"     let i = 1
"     while i <= tabpagenr('$')
"       let buflist = tabpagebuflist(i)
"       let winnr = tabpagewinnr(i)
"       let s .= '%' . i . 'T'
"       let s .= (i == t ? '%1*' : '%2*')
"       let s .= ' '
"       let wn = tabpagewinnr(i,'$')
" 
"       let s .= (i== t ? '%#TabNumSel#' : '%#TabNum#')
"       let s .= i
"       if tabpagewinnr(i,'$') > 1
"         let s .= '.'
"         let s .= (i== t ? '%#TabWinNumSel#' : '%#TabWinNum#')
"         let s .= (tabpagewinnr(i,'$') > 1 ? wn : '')
"       end
" 
"       let s .= ' %*'
"       let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
"       let bufnr = buflist[winnr - 1]
"       let file = bufname(bufnr)
"       let buftype = getbufvar(bufnr, 'buftype')
"       if buftype == 'nofile'
"         if file =~ '\/.'
"           let file = substitute(file, '.*\/\ze.', '', '')
"         endif
"       else
"         let file = fnamemodify(file, ':p:t')
"       endif
"       if file == ''
"         let file = '[No Name]'
"       endif
"       let s .= file
"       let s .= (i == t ? '%m' : '')
"       let i = i + 1
"     endwhile
"     let s .= '%T%#TabLineFill#%='
"     return s
"   endfunction
"   set stal=2
"   set tabline=%!MyTabLine()
" endif
" end of tab index support

" handling different color scheme
function! My_light_theme ()
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

  " let colors_name = "default"

  hi Normal       ctermfg=16 ctermbg=231 guifg=#000000 guibg=#fffffc
  " hi CursorLine   term=underline cterm=underline guibg=#cfcfcc
  hi cursorline   term=underline cterm=NONE ctermfg=NONE ctermbg=254 guibg=#cfcfcc guifg=NONE
  hi cursorlinenr cterm=NONE     ctermfg=232 guifg=#000000   ctermbg=NONE 
  hi linenr       cterm=NONE     ctermfg=246 guifg=#949494   ctermbg=NONE 
  hi constant     term=underline ctermfg=202 guifg=#ff5f00 
  hi comment      term=underline ctermfg=244 guifg=#808080 
  hi PreProc      term=underline ctermfg=205 guifg=#ff5faf
  hi Statement    term=underline ctermfg=92  guifg=#8700d7
  hi type         term=underline ctermfg=4   guifg=#1296be
  hi special      term=underline ctermfg=171 guifg=#d75fff 
  hi SpecialKey   term=underline ctermfg=141 guifg=#af87ff
  hi Identifier   term=underline ctermfg=33  guifg=#0087ff 
  hi error        term=underline ctermbg=166 ctermfg=255 guifg=#ffffff guibg=#d75f00
  hi visual     term=reverse cterm=reverse guibg=#aaaaaa
  hi Todo         term=underline ctermbg=220 guibg=#ffd700
  if ( &filetype ==# 'c' || &filetype ==# 'cpp' )
    hi PreProc      term=underline ctermfg=199 guifg=#ff00af 
    hi type         term=underline ctermfg=33  guifg=#0087ff 
    hi Identifier   term=underline ctermfg=34  guifg=#00af00 
  endif
endfunction

function! My_dark_theme ()
  " Vim color file
  " Maintainer:	Bram Moolenaar <Bram@vim.org>
  " Last Change:	2016 Oct 10

  " This color scheme uses a dark grey background.

  " First remove all existing highlighting.
  set background=dark
  hi clear
  if exists("syntax_on")
    syntax reset
  endif

  " let colors_name = "evening"

  " hi Normal ctermbg=DarkGrey ctermfg=White guifg=White guibg=grey20
  hi Normal       ctermfg=255 ctermbg=234 guifg=White guibg=#0a0a09

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
  " hi CursorLine term=underline cterm=underline guibg=grey40
  " hi CursorLine   term=underline cterm=underline guibg=#444444
  hi cursorline   term=underline cterm=NONE ctermfg=NONE ctermbg=237 guibg=#444444 guifg=NONE

  " Groups for syntax highlighting
  " hi Constant term=underline ctermfg=Magenta guifg=#ffa0a0
  hi constant     term=underline ctermfg=215     guifg=#FFAF5F
  " hi Special term=bold ctermfg=LightRed guifg=Orange
  hi special      term=underline ctermfg=177 guifg=#D787FF
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
  if ( &filetype ==# 'zsh' || &filetype ==# 'sh' || &filetype ==# 'vim' )
    hi type         term=underline ctermfg=144 guifg=#AFAF87
    hi Identifier   term=underline ctermfg=110 guifg=#87AFD7
    hi statement    term=underline ctermfg=114 guifg=#87D787
    hi PreProc      term=underline ctermfg=111 guifg=#87AFFF
  endif
endfunction

