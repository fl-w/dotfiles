" fzf{,.vim} configuration
"

" Jump to the existing window if possible.
let g:fzf_buffers_jump = v:true

" Tell ripgrep to use current working directory
" let g:rg_derive_root = v:true

" " Set fzf to floating layout
" let g:fzf_layout = {
"       \ 'window': {
"       \   'width': 0.75,
"       \   'height': 0.75,
"       \   'highlight': 'Comment',
"       \   'yoffset': 0.25,
"       \   'border': 'sharp'
"       \ } }

let g:fzf_height = 16
let g:fzf_layout = {
 \ 'window': 'new | wincmd J | resize 1 | call animate#window_absolute_height(g:fzf_height)'
\ }

augroup fzf_custom
  au!
  autocmd FileType fzf call utils#init_minimal_window()
        \ | tnoremap <buffer> <silent> <Esc> <C-\><C-n>:call utils#sliding_window_animate(1, { -> execute('wincmd c')}, v:true)<cr>i
augroup end

" Override fzf command
let g:fzf_default_command = get(g:, 'fzf_default_command',
      \ $FZF_DEFAULT_COMMAND . (!empty($FZF_DEFAULT_COMMAND) ? ' -g "!plugged"' : ''))
if !empty(g:fzf_default_command) | let $FZF_DEFAULT_COMMAND = g:fzf_default_command | endif

" Override fzf opts
let g:fzf_default_opts = get(g:, 'fzf_default_opts',
      \ $FZF_DEFAULT_OPTS . ' --inline-info --bold --margin=1,4')
let $FZF_DEFAULT_OPTS = g:fzf_default_opts

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

" nnoremap \ :Rg<CR>
nnoremap <C-T> :Files<cr>

command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(
      \ <q-args>,
      \ fzf#vim#with_preview({'options': ['--prompt=ﬦ ', '--info=hidden']}),
      \ <bang>0)

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

if !empty($RG_DEFAULT_COMMAND)
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \ $RG_DEFAULT_COMMAND . shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
endif

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

