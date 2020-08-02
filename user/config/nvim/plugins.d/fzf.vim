" fzf{,.vim} configuration
"

let g:fzf_layout = {'up': '~35%'}
let g:fzf_preview_window = 'right:60%'
let g:fzf_default_command = get(g:, 'fzf_default_command', $FZF_DEFAULT_COMMAND . ' -g "!plugged"')
let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let $FZF_DEFAULT_COMMAND = g:fzf_default_command
let $FZF_DEFAULT_OPTS = '--layout=reverse --border'
" let $FZF_DEFAULT_OPTS .= $FZF_CTRL_T_OPTS
" let $FZF_DEFAULT_OPTS .= ' --margin=1,4 --color=dark '
" let $FZF_DEFAULT_OPTS .= ' --color=fg+:#707a8c,bg+:#191e2a,hl+:#ffcc66 '
" let $FZF_DEFAULT_OPTS .= ' --color=fg+:#707a8c,bg+:#191e2a,hl+:#ffcc66 '
" let $FZF_DEFAULT_OPTS .= ' --color=marker:#73d0ff,spinner:#73d0ff,header:#d4bfff'
" let $FZF_DEFAULT_OPTS .= ' --color=info:#73d0ff,prompt:#707a8c,pointer:#cbccc6'

fu! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  let height = float2nr(&lines * 0.35)
  let width = float2nr(&columns * 0.8)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': 1,
        \ 'col': (&columns - width) / 2,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }

  setl winhl=Normal:MarkdownError
  " keepalt file explorer

  call setbufvar(buf, '&signcolumn', 'no')
  call setbufvar(buf, '&rnu', 'no')
  call nvim_open_win(buf, v:true, opts)
endfunction

function! s:line_handler(l)
  let keys = split(a:l, ':\t')
  exec 'buf' keys[0]
  exec keys[1]
  normal! ^zz
endfunction

function! s:buffer_lines()
  let res = []
  for b in filter(range(1, bufnr('$')), 'buflisted(v:val)')
    call extend(res, map(getbufline(b,0,"$"), '"[" . b . "]\t" . (v:key + 1) . ":\t" . v:val '))
  endfor
  return res
endfunction

command! FZFLines call fzf#run({
\   'source':  <sid>buffer_lines(),
\   'sink':    function('<sid>line_handler'),
\   'options': '--extended --nth=3.. --preview-window :wrap',
\   'window': 'call FloatingFZF()'
\})

