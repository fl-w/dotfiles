if !exists('IsPlugLoaded') || !IsPlugLoaded('defx')
  finish
endif

augroup defxinit
  au!
  autocmd FileType defx call s:defx_init()
  " auto close last defx windows
  autocmd BufEnter * nested if
        \ (!has('vim_starting') && winnr('$') == 1 && &filetype ==# 'defx')
        \ | endif
augroup END

let s:icon_root = ' '
let s:icon_opened = '▼'
let s:icon_directory = '▶'

" default options for all buffers
call defx#custom#option('_', {
  \ 'winwidth': 30,
  \ 'columns': 'indent:git:icons:filename:type',
  \ 'split': 'vertical',
  \ 'direction': 'leftabove',
  \ 'show_ignored_files': 1,
  \ 'buffer_name': '',
  \ 'toggle': 1,
  \ 'resume': 1,
  \ })

call defx#custom#column('icon', {
  \ 'directory_icon': s:icon_directory,
  \ 'opened_icon': s:icon_opened,
  \ 'root_icon': s:icon_root,
  \ })

call defx#custom#column('mark', {
  \ 'readonly_icon': '',
  \ 'selected_icon': '',
  \ })

call defx#custom#column('filename', {
  \ 'max_width': -90,
  \ 'root_marker_highlight': 'String',
  \ })

function! s:defx_init() abort

  setl nonumber
  "setl nospell
  "setl nolist
  "setl conceallevel=3
  "setl statusline=0
  setl nofoldenable
  setl foldmethod=manual
  "setl signcolumn=no
  set guifont=FiraCode\ Nerd\ Font\ 11

  " disable this mappings
  nnoremap <silent><buffer> <3-LeftMouse> <Nop>
  nnoremap <silent><buffer> <4-LeftMouse> <Nop>
  nnoremap <silent><buffer> <LeftMouse> <LeftMouse><Home>

  nnoremap <silent><buffer><expr> <2-LeftMouse> <SID>defx_expand_or_open()
  nnoremap <silent><buffer><expr> <CR>          <SID>defx_expand_or_open()
  nnoremap <silent><buffer><expr> l <SID>defx_expand_or_open()
  nnoremap <silent><buffer><expr> h defx#do_action('close_tree')
  nnoremap <silent><buffer><expr> C defx#do_action('copy')
  nnoremap <silent><buffer><expr> P defx#do_action('paste')
  nnoremap <silent><buffer><expr> M defx#do_action('rename')
  nnoremap <silent><buffer><expr> D defx#do_action('remove_trash')
  nnoremap <silent><buffer><expr> A defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> S defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> U defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> . defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select')
  nnoremap <silent><buffer><expr> R defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <Tab> <SID>defx_toggle_zoom()
endfunction

function s:defx_expand_or_open()
  return defx#is_directory() ? defx#do_action('open_or_close_tree') : defx#do_action('drop')
endfunction

function s:defx_toggle_zoom() abort "{{{
  let b:DefxOldWindowSize = get(b:, 'DefxOldWindowSize', winwidth('%'))
  let size = b:DefxOldWindowSize
  if exists("b:DefxZoomed") && b:DefxZoomed
      exec "silent vertical resize ". size
      let b:DefxZoomed = 0
  else
      exec "vertical resize ". get(g:, 'DefxWinSizeMax', '')
      let b:DefxZoomed = 1
  endif
endfunction "}}}
