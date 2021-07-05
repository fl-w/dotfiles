" gruvbox config file
"

augroup gruv_color
    autocmd ColorScheme gruvbox call s:set_colors()
augroup end

fun s:set_colors()
  hi GruvboxRed gui=bold
  hi GruvboxGreen gui=bold
  hi CursorLineNr guibg=bg ctermbg=NONE
  if &bg == 'dark'
    hi   CursorLine guibg=#151A1E
  else
    " hi   CursorLine guibg=#151A1E
  endif

  hi! link LineNr EndOfBuffer
  call utils#color#copy_hi_group("GruvboxRedSign", "CocErrorSign")
  hi CocErrorSign guibg=bg ctermbg=NONE
endfu
