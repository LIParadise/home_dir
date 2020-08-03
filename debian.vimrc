set nu ai expandtab tabstop=3 shiftwidth=3 history=3000 cursorline laststatus=2 statusline+=%<%F\ %h%m%r%=%-16.(%l,%c%V%)\ %P ignorecase smartcase showcmd t_Co=256 backspace=indent,eol,start encoding=utf-8 nocompatible ttimeoutlen=5
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//
filetype indent on
syntax on

runtime liparadise_color.vim
runtime liparadise_tabline.vim

autocmd VimEnter * call My_stop_hide_underscore()
if !&diff
   autocmd VimEnter * call My_dark_theme()
endif

" Some mapleader Settings
let mapleader=" "
" For quick markdown highlight
vnoremap <Leader>H c__*<C-r>"*__
vnoremap <Leader>h c__<C-r>"__
vnoremap <Leader>a c*<C-r>"*

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
