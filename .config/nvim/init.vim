let mapleader=" "

" Plugin: `plugged`
"
filetype off
call plug#begin('~/.vim/plugged')
" Language Server
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Beautify Indentation
Plug 'Yggdroot/indentLine'
Plug 'ayu-theme/ayu-vim'
Plug 'webdevel/tabulous'
Plug 'rust-lang/rust.vim'
call plug#end()
" All of your Plugins must be added before the following line
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Put your non-Plugin stuff after this line

" coc setup
"
runtime liparadise_coc.vim

set nu ai expandtab tabstop=4 shiftwidth=4 history=3000 cursorline laststatus=2 statusline+=%<%F\ %h%m%r%=%-16.(%l,%c%V%)\ %P ignorecase smartcase showcmd t_Co=256 backspace=indent,eol,start encoding=utf-8 nocompatible ttimeoutlen=5 mouse=a
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

syntax on

runtime plugins/coc_scroll_in_insert_mode.vim
runtime liparadise_color.vim

autocmd VimEnter * call My_stop_hide_underscore()
augroup my_color
    autocmd!
    autocmd ColorScheme * if !&diff | call My_dark_theme() | endif
augroup END
autocmd filetype c setlocal cindent cino=j1,(s,ws,Ws,N-s,m1
autocmd filetype cpp setlocal cindent cino=j1,(s,ws,Ws,N-s,m1
if !&diff | colorscheme ayu | endif

" Some mapleader Settings
" Some miscellaneous key mapping
nnoremap <Leader>n :set nu!
nnoremap <Leader>b :windo set scrollbind
nnoremap <Leader>B :windo set noscrollbind
nnoremap <Leader>g gg=Gzz
nnoremap <C-Up> 
nnoremap <C-Down> 
inoremap  <C-w>
cnoremap  <C-w>
cnoremap Q tabc
" For opening ctag in new tab

" key mappings

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
