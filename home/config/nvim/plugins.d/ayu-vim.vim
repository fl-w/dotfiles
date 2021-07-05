" vim: sw=2 sts=2 tw=0 fdm=marker
" ayu-vim configuration
"
finish
augroup ayu_color
    autocmd ColorScheme ayu call s:set_colors()
  au OptionSet          background  if exists('g:colors_name') && g:colors_name == 'ayu'
        \ | echo 'colorscheme ayu'
        \ | endif
augroup end

fun s:set_colors()
  return
    " let g:ayucolor = &background == 'light' ? 'light' : 'dark'
  if &bg == 'dark'
    hi   CursorLine guibg=#151A1E
  else
    " hi   CursorLine guibg=#151A1E
  endif
endfu
