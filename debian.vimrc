set nu ai expandtab tabstop=3 shiftwidth=3 history=3000 cursorline laststatus=2 statusline+=%<%F\ %h%m%r%=%-16.(%l,%c%V%)\ %P ignorecase smartcase showcmd t_Co=256 backspace=indent,eol,start
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//
filetype indent on
syntax on
autocmd VimEnter * call My_stop_hide_underscore()
if !&diff
   autocmd VimEnter * call My_dark_theme()
endif

" Some mapleader Settings
let mapleader=" "
" For quick markdown highlight
map <Leader>H c__*<C-o>P*__
map <Leader>h c__<C-o>P__

" isnot#
" enable truecolor when feasible
if exists('+termguicolors')
   if (($TERM !~? '^linux$') && ($TERM !~? '^screen$'))
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      set termguicolors
   endif
endif

" vim highlight is broken in many ways....
" this fixes ayu colorscheme with markdown
" basically, stop it from hiding '_'
function! My_stop_hide_underscore()
   set concealcursor="nc"
endfunction


" language
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
   echohl None
   echo "Spell Check is now "
   echohl Boolean
   if &spell
      echo "ON"
   else
      echo "OFF"
   endif
   echohl None
endfunction

" check highlight group of the word where cursor is
function! MyColorCheck ()
   if !exists("*synstack")
      return
   endif
   echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

function! MySetAndReturnTermguicolors ()
   " enable truecolor when feasible
   if exists('+termguicolors')
      if (($TERM !~? '^linux$') && ($TERM !~? '^screen$'))
         let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
         let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
         set termguicolors
         return 1
      endif
   endif
   return 0
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
   colorscheme MyDarkThemeFallback
   syntax on
endfunction

function! s:My_light_theme_fallback ()
   set notermguicolors
   syntax reset
   colorscheme MyLightThemeFallback
   syntax on
endfunction

function! s:My_obsidian_theme_fallback ()
   set notermguicolors
   syntax reset
   colorscheme MyObsidianThemeFallback
   syntax on
endfunction

function! My_light_theme ()
   if MySetAndReturnTermguicolors () == 1
      let g:ayucolor="light"
      colorscheme ayu
      hi LineNr      ctermfg=130    guifg=#C8C7C6
      hi Comment     ctermfg=4      guifg=#A6AAB1
      hi PreProc     ctermfg=81     guifg=#E8B268
      hi Operator    guifg=#A58D2E
      hi StatusLine  guibg=#5C6773  guifg=#FFFFFF
      hi VertSplit   guifg=#CCC2C2
      hi normal      guifg=#515B65  guibg=#FAFAFA
   else
      call s:My_light_theme_fallback()
   endif
endfunction

function! My_dark_theme ()
   if MySetAndReturnTermguicolors () == 1
      let g:ayucolor="dark"
      colorscheme ayu
      hi LineNr      ctermfg=130    guifg=#38414A
      hi SpecialKey  ctermfg=4      guifg=#6990B5
      hi StatusLine  guifg=#14191F  guibg=#E6E1CF 
      hi VertSplit   guifg=#354659
      hi Normal      ctermfg=255 ctermbg=234 guifg=#E7E7E6 guibg=#0a0a09
   else
      call s:My_dark_theme_fallback()
   endif
endfunction

function! My_obsidian_theme ()
   if MySetAndReturnTermguicolors () == 1
      let g:ayucolor="dark"
      colorscheme ayu
      hi LineNr      ctermfg=130    guifg=#38414A
      hi SpecialKey  ctermfg=4      guifg=#6990B5
      hi StatusLine  guifg=#14191F  guibg=#E6E1CF 
      hi VertSplit   guifg=#354659
      hi Normal      ctermfg=255 ctermbg=234 guifg=NONE guibg=NONE
      hi cursorline  guibg=NONE  gui=underline term=underline
      hi cursorlinenr guibg=NONE
   else
      call s:My_obsidian_theme_fallback()
   endif
endfunction

function! My_mirage_theme ()
   if MySetAndReturnTermguicolors () == 1
      let g:ayucolor="mirage"
      colorscheme ayu
      hi LineNr      ctermfg=130    guifg=#3e4a5c
      hi Comment     ctermfg=14     guifg=#606A77
      hi SpecialKey  ctermfg=4      guifg=#6990B5
      hi StatusLine  guifg=#272D38  guibg=#D9D7CE 
      hi VertSplit   guifg=#2B3B5B
   else
      call s:My_dark_theme_fallback()
   endif
endfunction

