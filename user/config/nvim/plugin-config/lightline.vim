" lightline/-buffers configuration
"

let g:lightline = get(g:, 'lightline', {})

let g:lightline.colorscheme  = 'molokai'

let g:lightline.separator    = { 'left': "\ue0b0", 'right': "\ue0b2" }
let g:lightline.subseparator = { 'left': "\ ", 'right': "/" }

let g:lightline.mode_map = {
    \ 'n' : 'n',
    \ 'i' : 'i',
    \ 'R' : 'r',
    \ 'v' : 'VISUAL',
    \ 'V' : 'V-LINE',
    \ "\<C-v>": 'V-BLOCK',
    \ 'c' : 'COMMAND',
    \ 's' : 'SELECT',
    \ 'S' : 'S-LINE',
    \ "\<C-s>": 'S-BLOCK',
    \ 't': 'TERMINAL',
    \ }

let g:lightline#bufferline#clickable         = 1
let g:lightline#bufferline#enable_devicons   = 1
let g:lightline#bufferline#unicode_symbols   = 1
let g:lightline#bufferline#min_buffer_count  = 1
let g:lightline#bufferline#show_number       = 2
let g:lightline#bufferline#unnamed           = 'Untitled'
let g:lightline#bufferline#filename_modifier = ':t'

let g:lightline.active = {}
let g:lightline.active.left = [['mode', 'paste'], ['filename', 'gitbranch']]
let g:lightline.active.right = [['lineinfo', 'percent'], ['hlsearch', 'spell'], ['diagnostics', 'linter', 'cocstatus', 'currentfunction']]

let g:lightline.inactive = {}

"
let g:lightline.tabline = {
      \  'left': [['buffers']],
      \  'right': [[ 'close' ]]
\}

" let g:lightline.component = {  }

let g:lightline.component_raw = { 'buffers': 1 }

let g:lightline.component_function = {
      \ 'filename': 'statusline#filename',
      \ 'gitbranch': 'statusline#gitbranch',
      \ 'linter': 'statusline#linter',
      \ 'hlsearch': 'statusline#hlsearch',
      \ 'cocstatus': 'coc#status',
      \ 'currentfunction': 'CocCurrentFunction',
      \ 'spell': 'statusline#spell',
      \ 'diagnostics': 'Diag'
\}

function! Diag()
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', tagbar#currenttag('%s', '', ''))
endfunction

let g:lightline.component_expand = {
      \ 'buffers':          'lightline#bufferline#buffers',
      \ 'linter_checking':  'lightline#ale#checking',
      \ 'linter_warnings':  'lightline#ale#warnings',
      \ 'linter_errors':    'lightline#ale#errors',
      \ 'linter_ok':        'lightline#ale#ok',
\}

let g:lightline.component_type = {
      \     'buffers':         'tabsel',
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors':   'error',
      \     'linter_ok':       'left',
      \ }


fu! lightline#_update()
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfu


call lightline#_update()

let g:lightline#bufferline#number_map = {
\ 0: '⁰', 1: '¹', 2: '²', 3: '³', 4: '⁴',
\ 5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'}
