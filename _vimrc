set nu ai expandtab tabstop=2 shiftwidth=2 history=200 cursorline laststatus=2 statusline+=%m%F t_Co=256 ignorecase smartcase
set backupdir=~/.backup/,/tmp//
set directory=~/.swp/,/tmp//
set undodir=~/.undo/,/tmp//

filetype indent on
syntax on

hi linenr       cterm=NONE  ctermfg=244  ctermbg=NONE guibg=NONE guifg=NONE
hi cursorlinenr cterm=NONE  ctermfg=255  ctermbg=NONE guibg=NONE guifg=NONE
hi cursorline   cterm=NONE  ctermfg=NONE ctermbg=NONE guibg=NONE guifg=NONE

let @f = '/{
let @e = 'zD'
" @f: fold from this line to the end of the nearest {} quoted thing, like c-style functions;
" @e: expand, ie.e unfold, something;

" ctags
set tags=./tags;/

" handling lambda functions;
function Lambda_cpp()
  setlocal cindent cino=j1,(0,ws,Ws,N-s
endfunction

" handling different color scheme
function My_light_theme ()
  hi cursorlinenr cterm=NONE     ctermfg=232  ctermbg=NONE 
  hi linenr       cterm=NONE     ctermfg=246  ctermbg=NONE 
  if &filetype ==# 'c' || &filetype ==# 'cpp'
    hi type         term=underline ctermfg=38
    hi constant     term=underline ctermfg=166
    hi PreProc      term=underline ctermfg=62
    hi Statement    term=underline ctermfg=77
    hi comment      term=underline ctermfg=244
  endif
endfunction

function My_dark_theme ()
  hi linenr       cterm=NONE     ctermfg=244  ctermbg=NONE
  hi cursorlinenr cterm=NONE     ctermfg=255  ctermbg=NONE 
  if &filetype ==# 'c' || &filetype ==# 'cpp'
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

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Fira\ Code\ Retina:h11:cANSI
  endif
endif