" Plug 'sainnhe/everforest'
if has('termguicolors')
    set background=dark
    let g:everforest_better_performance=1
    let g:everforest_enable_italic=1
    " let g:everforest_ui_contrast='high'
    " let g:everforest_background='hard'
    autocmd ColorScheme * hi specialkey ctermbg=240 guifg=#816f6a
    colorscheme everforest
endif
