" abbr.vim: useful command abbreviations
"

if exists('g:utils#abbr#loaded')
  finish
endif

let g:utils#abbr#loaded = 1

cnoreabbrev W w
cnoreabbrev E e

cnoreabbrev Qa qa
cnoreabbrev Bd bd

cnoreabbrev wrap set wrap
cnoreabbrev nowrap set nowrap

" vim: sw=2 sts=2 tw=0 fdm=marker
