function! LIParadise_check_if_preview_window_exists ()
   for windowNumber in range(1, winnr('$'))
      if getwinvar( windowNumber, "&previewwindow" ) == 1
         " Found a preview window; close it
         return 1
      endif
   endfor
   return 0
endfunction
