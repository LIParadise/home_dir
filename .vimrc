set nu ai expandtab tabstop=2 shiftwidth=2 history=200 cursorline laststatus=2 statusline+=%<%F\ %h%m%r%=%-16.(%l,%c%V%)\ %P ignorecase smartcase showcmd t_Co=256
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

" isnot#
" enable truecolor when feasible
if exists('+termguicolors')
  if (($TERM !~? '^linux$') && ($TERM !~? '^screen$'))
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif
endif

" vim-plug
" https://github.com/junegunn/vim-plug
call plug#begin('$HOME/.vim/plugged')

Plug 'ayu-theme/ayu-vim'
" https://github.com/ayu-theme/ayu-vim

call plug#end()

" %m%F\ \ %1.4c,%1.6l
" :set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

" set statusline=[%{expand('%:p')}][%{strlen(&fenc)?&fenc:&enc},\ %{&ff},\ %{strlen(&filetype)?&filetype:'plain'}]%{FileSize()}%{IsBinary()}%=%c,%l/%L\ [%3p%%]
"

filetype indent on
syntax on

if has("gui_running")
  set encoding=utf-8
  set fileencodings=utf-8,chinese,latin-1
  if has("gui_win32")
    set guifont=Cascadia_Code:h13
  endif
else
  hi linenr       cterm=NONE  ctermfg=244  ctermbg=NONE guibg=NONE guifg=NONE
  hi cursorlinenr cterm=NONE  ctermfg=255  ctermbg=NONE guibg=NONE guifg=NONE
  hi cursorline   cterm=NONE  ctermfg=NONE ctermbg=NONE guibg=NONE guifg=NONE
endif

" handling lambda functions;
function! Lambda_cpp()
  setlocal cindent cino=j1,(0,ws,Ws,N-s
endfunction

" handling en spell check;
function! Spell_On_Off()
  setlocal spell! spelllang=en
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

" if there's no true color, fallback
function! s:My_dark_theme_fallback ()
  set notermguicolors
  syntax reset
  colorscheme industry
  syntax on
endfunction

" if there's no true color, fallback
function! s:My_light_theme_fallback ()
  set notermguicolors
  syntax reset
  colorscheme default
  syntax on
  hi Normal         ctermfg=0 ctermbg=255
  hi linenr         ctermfg=3 ctermbg=7
  hi CursorLineNr   term=none cterm=none ctermfg=5 ctermbg=7
  hi cursorline     term=none cterm=none ctermbg=250
  hi Constant       term=underline ctermfg=3
endfunction

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

function! My_light_theme ()
  if &termguicolors
    let g:ayucolor="light"
    colorscheme ayu
    hi LineNr      ctermfg=130 guifg=#C8C7C6
    hi Comment     ctermfg=4   guifg=#A6AAB1
    hi PreProc     ctermfg=81  guifg=#E8B268
    hi Operator    guifg=#A58D2E
    hi StatusLine  guibg=#5C6773 guifg=#FFFFFF
    hi VertSplit   guifg=#CCC2C2
  else
    call s:My_light_theme_fallback()
  endif
endfunction

function! My_dark_theme ()
  if &termguicolors
    let g:ayucolor="dark"
    colorscheme ayu
    hi LineNr      ctermfg=130 guifg=#38414A
    hi SpecialKey  ctermfg=4   guifg=#6990B5
    hi StatusLine  guifg=#14191F guibg=#E6E1CF 
    hi VertSplit   guifg=#354659
  else
    call s:My_dark_theme_fallback()
  endif
endfunction

function! My_mirage_theme ()
  if &termguicolors
    let g:ayucolor="mirage"
    colorscheme ayu
    hi LineNr      ctermfg=130 guifg=#3e4a5c
    hi Comment     ctermfg=14  guifg=#606A77
    hi SpecialKey  ctermfg=4   guifg=#6990B5
    hi StatusLine  guifg=#272D38 guibg=#D9D7CE 
    hi VertSplit   guifg=#2B3B5B
  else
    call s:My_dark_theme_fallback()
  endif
endfunction

