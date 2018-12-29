set nu ai expandtab tabstop=2 shiftwidth=2 history=200 cursorline laststatus=2 statusline+=%m%F t_Co=256 ignorecase smartcase
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

filetype indent on
syntax on

hi linenr       cterm=NONE  ctermfg=244  ctermbg=NONE guibg=NONE guifg=NONE
hi cursorlinenr cterm=NONE  ctermfg=255  ctermbg=NONE guibg=NONE guifg=NONE
hi cursorline   cterm=NONE  ctermfg=NONE ctermbg=NONE guibg=NONE guifg=NONE

let @f = '/{zfa}``zf``'
let @e = 'zD'
" @f: fold from this line to the end of the nearest {} quoted thing, like c-style functions;
" @e: expand, ie.e unfold, something;

" ctags
set tags=./tags,./TAGS,$HOME/.tags/tags,$HOME/.tags/TAGS,tags;$HOME,TAGS;$HOME

" handling lambda functions;
function Lambda_cpp()
  setlocal cindent cino=j1,(0,ws,Ws,N-s
endfunction

" handling different color scheme
function My_light_theme ()
  hi cursorlinenr cterm=NONE     ctermfg=232  ctermbg=NONE 
  hi linenr       cterm=NONE     ctermfg=246  ctermbg=NONE 
  if ( &filetype ==# 'c' || &filetype ==# 'cpp' )
    hi type         term=underline ctermfg=32
    hi constant     term=underline ctermfg=202
    hi PreProc      term=underline ctermfg=198
    hi Statement    term=underline ctermfg=92
    hi comment      term=underline ctermfg=244
  endif
endfunction

function My_dark_theme ()
  hi linenr       cterm=NONE     ctermfg=244  ctermbg=NONE
  hi cursorlinenr cterm=NONE     ctermfg=255  ctermbg=NONE 
  if ( &filetype ==# 'c' || &filetype ==# 'cpp' )
    hi statement    term=underline ctermfg=113
    hi type         term=underline ctermfg=80
    hi constant     term=underline ctermfg=215
    hi PreProc      term=underline ctermfg=105
    hi comment      term=underline ctermfg=246
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
