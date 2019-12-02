set nu ai expandtab tabstop=2 shiftwidth=2 history=200 cursorline laststatus=2 statusline+=%m%F\ \ (%c,%l) t_Co=256 ignorecase smartcase showcmd
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

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

" handling different color scheme
function! My_light_theme ()
  hi cursorlinenr cterm=NONE     ctermfg=232  ctermbg=NONE 
  hi linenr       cterm=NONE     ctermfg=246  ctermbg=NONE 
  hi constant     term=underline ctermfg=202
  hi comment      term=underline ctermfg=244
  hi PreProc      term=underline ctermfg=205
  hi Statement    term=underline ctermfg=92
  hi type         term=underline ctermfg=4
  hi special      term=underline ctermfg=171
  hi SpecialKey   term=underline ctermfg=141
  hi Identifier   term=underline ctermfg=33
  hi error        term=underline ctermbg=166 ctermfg=255
  hi Todo         term=underline ctermbg=220
  if ( &filetype ==# 'c' || &filetype ==# 'cpp' )
    hi PreProc      term=underline ctermfg=199
    hi type         term=underline ctermfg=33
    hi Identifier   term=underline ctermfg=34
  endif
endfunction

function! My_dark_theme ()
  hi linenr       cterm=NONE     ctermfg=244  ctermbg=NONE
  hi cursorlinenr cterm=NONE     ctermfg=255  ctermbg=NONE 
  hi constant     term=underline ctermfg=215
  hi comment      term=underline ctermfg=246
  hi PreProc      term=underline ctermfg=105
  hi type         term=underline ctermfg=80
  hi statement    term=underline ctermfg=113
  hi error        term=underline ctermbg=166 ctermfg=255
  hi Todo         term=underline ctermbg=221
  hi special      term=underline ctermfg=177
  hi SpecialKey   term=underline ctermfg=213
  if ( &filetype ==# 'zsh' || &filetype ==# 'sh' || &filetype ==# 'vim' )
    hi type         term=underline ctermfg=144
    hi Identifier   term=underline ctermfg=110
    hi statement    term=underline ctermfg=114
    hi PreProc      term=underline ctermfg=111
  endif
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
