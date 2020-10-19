" Ayu configuration
"

fu s:set_theme()
  let g:ayucolor = &background == 'light' ? 'light' : 'dark'
  colo ayu
endfu

au OptionSet background call s:set_theme()

let colors_name = get(g:, 'colors_name', "default")
if empty(colors_name) || colors_name == "default"
  call s:set_theme()
endif

" vim: sw=2 sts=2 tw=0 fdm=marker
