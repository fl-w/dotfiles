" goyo.vim + limelight configuration
"

let g:goyo_width = 104
let g:limelight_conceal_guifg = '#2b2b30'

fun! s:goyo_enter()
    let s:scr = &scrolloff
    let s:col = g:colors_name
    colo ayu
    Limelight
    set scrolloff=999
endf

fun! s:goyo_leave()
    let &scrolloff = s:scr
    exe 'colo' s:col
    Limelight!
endf

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" vim: sw=2 sts=2 tw=0 fdm=marker
