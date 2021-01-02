" vista.vim configuration
"

autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

call utils#window#slide_window('vista', 30)

if utils#is_plug_loaded('fzf')
  if !hasmapto('go')
    nmap go :Vista finder<cr>
  endif
endif

" vim: sw=2 sts=2 tw=0 fdm=marker
