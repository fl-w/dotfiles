" vista.vim configuration
"

if utils#is_plug_loaded('fzf')
  nmap gO :Vista finder<cr>
endif


" au! BufReadPost * call vista#RunForNearestMethodOrFunction()

let g:vista_sidebar_position = 'vertical botright'
let g:vista_sidebar_width = '50'

call utils#window#slide_window('vista', 50)

" vim: sw=2 sts=2 tw=0 fdm=marker
