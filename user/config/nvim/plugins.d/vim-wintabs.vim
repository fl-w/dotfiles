" vim-wintabs configuration
"

let g:wintabs_ui_readonly = ' '
let g:wintabs_ui_modified = ' '
let s:sep_left = "\ue0be" " or  ue0b6 | a | e
let s:sep_right = "\ue0b8" " or ue0b4 | c | 8

noremap <Right> :<C-u>WintabsNext<cr>
noremap <Left> :<C-u>WintabsPrevious<cr>

fun! s:init()
  let g:wintabs_renderers = extend(wintabs#renderers#defaults(), {
    \ 'buffer': funcref('s:buffer'),
    \ 'buffer_sep': funcref('s:buffer_sep'),
    \ 'line_sep': funcref('s:line_sep'),
    \ 'padding': funcref('s:padding'),
    \ })

  augroup wintabs_powerline_on_colorscheme
  autocmd!
  autocmd ColorScheme,VimEnter * call s:on_colorscheme()
  augroup END
  call s:on_colorscheme()
endf


fun! s:on_colorscheme()
  hi WintabsEmpty      guibg=NONE
  hi WintabsArrow      guibg=NONE
  hi WintabsActive     guibg=#a790d5 gui=italic
  hi WintabsActiveSep  guibg=NONE guifg=#a790d5

  hi! link WintabsInactive Wintabs
  hi! link Wintabs StatusLine
endf

fun! s:buffer(bufnr, config)
  let is_active = a:config.is_active && a:config.is_active_window
  return {
        \'label': wintabs#renderers#buf_label(a:bufnr, a:config),
        \'highlight': is_active ? 'WintabsActive' : 'WintabsInactive',
        \}
endf

fun! s:buffer_sep(config)
  let label = a:config.is_leftmost ? s:sep_left :
        \ a:config.is_rightmost ? s:sep_right :
        \ join([s:sep_right, s:sep_left], '')
  let is_active = a:config.is_active && a:config.is_active_window

  return {
        \ 'label': is_active ? a:config.is_left ? s:sep_left : s:sep_right : '',
        \ 'highlight': is_active ? 'WintabsActiveSep' : 'Wintabs'
        \ }
endf

fun! s:line_sep()
  return {
        \'type': 'sep',
        \'label': '  ',
        \'highlight': 'WintabsEmpty',
        \}
endf

fun! s:padding(len)
  return {
        \'type': 'sep',
        \'label': repeat(' ', a:len),
        \'highlight': 'WintabsEmpty',
        \}
endf

call s:init()
