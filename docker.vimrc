set nu ai expandtab tabstop=3 shiftwidth=3 history=3000 cursorline laststatus=2 statusline+=%<%F\ %h%m%r%=%-16.(%l,%c%V%)\ %P ignorecase smartcase showcmd t_Co=256 backspace=indent,eol,start encoding=utf-8 nocompatible
filetype off
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'ycm-core/YouCompleteMe'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

syntax on

runtime liparadise_color_debian.vim
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

" key mappings

" # ycm settings and mappings
nnoremap <C-@> :YcmCompleter GetDoc
inoremap <C-Space> :YcmCompleter GetDoc
inoremap <C-@> <C-Space>
nnoremap <Leader>h :pc<Enter>
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_semantic_triggers={'c,cpp,python,rust,java,go,erlang,perl,cs,lua,javascript':['re!\w{2}']}

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
