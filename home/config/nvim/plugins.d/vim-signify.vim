" vim-signify configuration
"

let g:signify_sign_add               = '▍'
let g:signify_sign_delete            = '▍'
let g:signify_sign_delete_first_line = '▍'
let g:signify_sign_change            = '▍'
let g:signify_sign_show_count        = 0

au! ColorScheme * silent call <sid>set_colors()

function! s:set_colors()
  hi SignifySignAdd    cterm=NONE gui=NONE guifg=#8ec07c guibg=bg
  hi SignifySignDelete cterm=NONE gui=NONE guifg=#fb4934 guibg=bg
  hi SignifySignChange cterm=NONE gui=NONE guifg=#83a598 guibg=bg
endfunction

call <sid>set_colors()

" vim: sw=2 sts=2 tw=0 fdm=marker
