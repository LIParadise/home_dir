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

function! s:Coc_Rust_Analyzer_Colors ()
    hi CocRustTypeHint ctermfg=247 guifg=#9e9e9e
    hi CocRustChainingHint ctermfg=245 guifg=#8a8a8a
endfunction

function! My_light_theme ()
    if MySetAndReturnTermguicolors () == 1
        let g:ayucolor="light"
        hi LineNr      ctermfg=130    guifg=#C8C7C6
        hi Comment     ctermfg=4      guifg=#A5A9AE
        hi PreProc     ctermfg=81     guifg=#E8B268
        hi Operator    guifg=#A58D2E
        hi StatusLine  guibg=#5C6773  guifg=#FFFFFF
        hi VertSplit   guifg=#CCC2C2
        hi normal      guifg=#4B5057  guibg=#FBFBF7
        call s:Coc_Rust_Analyzer_Colors()
    else
        call s:My_light_theme_fallback()
    endif
endfunction

function! My_dark_theme ()
    if MySetAndReturnTermguicolors () == 1
        let g:ayucolor="dark"
        hi LineNr      ctermfg=130    guifg=#38414A
        hi SpecialKey  ctermfg=4      guifg=#6990B5
        hi StatusLine  guifg=#14191F  guibg=#E6E1CF 
        hi VertSplit   guifg=#354659
        hi Normal      ctermfg=255 ctermbg=234 guifg=#E7E7E6 guibg=#0a0a09
        call s:Coc_Rust_Analyzer_Colors()
    else
        call s:My_dark_theme_fallback()
    endif
endfunction

function! My_obsidian_theme ()
    if MySetAndReturnTermguicolors () == 1
        let g:ayucolor="dark"
        hi LineNr       ctermfg=130    guifg=#0A1009
        hi SpecialKey   ctermfg=4      guifg=#6990B5
        hi StatusLine   guifg=#14191F  guibg=#E6E1CF 
        hi VertSplit    guifg=#354659
        " hi Normal       ctermfg=255 ctermbg=234 guifg=NONE guibg=NONE
        hi Normal       ctermbg=NONE   guibg=NONE guifg=#E8EAD0
        hi NonText      ctermbg=NONE   guibg=NONE
        hi cursorline   guibg=NONE     gui=NONE ctermbg=NONE
        hi cursorlinenr guibg=NONE     guifg=#F4B723
        call s:Coc_Rust_Analyzer_Colors()
    else
        call s:My_obsidian_theme_fallback()
    endif
endfunction

function! My_mirage_theme ()
    if MySetAndReturnTermguicolors () == 1
        let g:ayucolor="mirage"
        hi LineNr      ctermfg=130    guifg=#455367
        hi Comment     ctermfg=14     guifg=#606A77
        hi SpecialKey  ctermfg=4      guifg=#6990B5
        hi StatusLine  guifg=#272D38  guibg=#D9D7CE 
        hi VertSplit   guifg=#2B3B5B
        call s:Coc_Rust_Analyzer_Colors()
    else
        call s:My_dark_theme_fallback()
    endif
endfunction
