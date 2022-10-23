" kitty.vim: minimal configuration on kitty term
"

if $TERM != "xterm-kitty" || !executable('kitty') || empty("$KITTY_LISTEN_ON")
  finish
endif

if exists('g:loaded_kitty') | finish | endif
let g:loaded_kitty = 1

let s:save_cpo = &cpo
set cpo&vim

fu! kitty#get_colors() abort
  let l:colors = {}
  let l:kitty_colors = systemlist('kitty @ --to $KITTY_LISTEN_ON get-colors')
  for val in map(kitty_colors, {_, val -> split(val)})
    let l:colors[val[0]] = val[1]
  endfor
  return l:colors
endfu

fu! kitty#refresh_bg()
  let kitty_bg = get(kitty#get_colors(), 'background')
  let &bg = utils#color#is_dark(kitty_bg) ? 'dark' : 'light'
endfu

let &cpo=s:save_cpo
unlet s:save_cpo

call kitty#refresh_bg()

" vim: sw=2 sts=2 tw=0 fdm=marker
