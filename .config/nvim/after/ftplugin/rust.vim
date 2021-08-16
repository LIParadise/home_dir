scriptencoding utf-8

nnoremap <buffer> <Leader>= :RustFmt<CR>
nnoremap <buffer> <Leader>h :CocCommand rust-analyzer.toggleInlayHints<CR>
echomsg "Custom `rust` indent shall be loaded."
