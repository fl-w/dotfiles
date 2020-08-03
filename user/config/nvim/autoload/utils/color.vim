" color functions

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
