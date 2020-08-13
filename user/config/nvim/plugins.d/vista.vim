" vista.vim configuration
"

autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

if utils#is_plug_loaded('fzf')
  nmap go :Vista finder<cr>
endif
