" fzf{,.vim} configuration
"

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

" Jump to the existing window if possible.
let g:fzf_buffers_jump = v:true

" Prefix all fzf commands with F
let g:fzf_command_prefix = 'F'

let g:fzf_height = 16

" don't open files over the following buffers
let g:_fzf_prevent_winbuf = ['fern', 'fugitive', 'vista']

" slide fzf in
call utils#window#slide_window('fzf', g:fzf_height)

" function s:fzf_ignore_buf()
"   " check if coming from fzf and going to a buf is a listed
"   let name = bufname('%')
"   echom 'before' winnr() ' with ' name
"   let ar = copy(g:_fzf_prevent_winbuf)
"   if winnr('$') > 1
"         \ && len(filter(ar, "bufname('%') =~ v:val")) > 0
"     exe "normal! \<c-w>\<c-w>"
"     echom 'yeah man ;D'
"     wincmd w
"     echom 'after'  winnr() ' with ' bufname()
"   endif
"   echom ar
" endf

" augroup fzf_ignore_buf
"   au BufWinEnter * call s:fzf_ignore_buf()
" augroup end

fun! s:close_fzf()
  let w = winnr()
  let cl = getwinvar(w, '_animated_close')
  " close normally or animate if possible
  exe empty(cl) ? printf('%dwincmd c', w) : cl
endf

augroup fzf_custom
  au!
  autocmd FileType fzf call utils#init_minimal_window()
        \ | tnoremap <buffer> <silent> <Esc> <C-\><C-n>:call <sid>close_fzf()<cr>
augroup end

" Override fzf command to add extra ripgrep opts
if !empty($FZF_DEFAULT_COMMAND)
  let g:fzf_default_command = get(g:, 'fzf_default_command',
        \ $FZF_DEFAULT_COMMAND . ' --follow -g "!vim-undo/**" -g "!plugged/**" -g "!.git/**"')
  let $FZF_DEFAULT_COMMAND = g:fzf_default_command
endif

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
nnoremap ? :Rg<cr>

let s:fzf_opts = {'options': [
  \ '--prompt=ﬦ ',
  \ '--info=hidden',
  \ '--preview-window=noborder'
  \ ]}

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(
  \ <q-args>,
  \ fzf#vim#with_preview(s:fzf_opts),
  \ <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \ printf(
  \   'rg --follow --column --line-number --no-heading --color=always --smart-case -- %s || true',
  \   shellescape(<q-args>)),
  \ 1,
  \ fzf#vim#with_preview(s:fzf_opts), <bang>0)

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" vim: sw=2 sts=2 tw=0 fdm=marker
