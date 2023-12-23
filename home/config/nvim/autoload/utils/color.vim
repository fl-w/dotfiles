" color functions

fu! utils#color#rgb(color)
  let hex = substitute(a:color, '^#', '', '')
  let rgb = #{r: 0, g: 0, b: 0}
  if len(hex) <= 3
    let hex = join(map(split(hex), {_, c -> c .. c}), '')
  endif
  let rgb.r = str2nr(hex[:1], 16)
  let rgb.g = str2nr(hex[2:3], 16)
  let rgb.b = str2nr(hex[4:6], 16)
  return rgb
endfu

fu! utils#color#brightness(color) abort
  let rgb = utils#color#rgb(a:color)
  return ((rgb.r  * 299) + (rgb.g * 587) + (rgb.b * 114)) / 1000
endfu

fu! utils#color#is_dark(color) abort
  return utils#color#brightness(a:color) < 128
endfu

fu! utils#color#is_light(color) abort
  return !utils#color#is_dark(a:color)
endfu

function! utils#color#syn_group()
    let l:s = synID(line('.'), col('.'), 1)
    return synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

fun! utils#color#copy_hi_group(group, to)
  let id = synIDtrans(hlID(a:group))
  for mode in ['cterm', 'gui']
    for g in ['fg', 'bg']
      exe 'let '. mode.g. "=  synIDattr(id, '". g."#', '". mode. "')"
      exe "let ". mode.g. " = empty(". mode.g. ") ? 'NONE' : ". mode.g
    endfor
  endfor
  exe printf('hi %s ctermfg=%s ctermbg=%s guifg=%s guibg=%s', a:to, ctermbg, ctermfg, guifg, guibg)
endf

" vim: sw=2 sts=2 tw=0 fdm=marker
