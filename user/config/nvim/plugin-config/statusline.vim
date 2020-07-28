" statusline.vim: minimal custom statusline (ripped from eleline)
" ref: https://github.com/liuchengxu/eleline.vim
"

" if exists('g:loaded_statusline') || v:version < 700 |  finish endif
let g:loaded_statusline = 1

let s:save_cpo = &cpo
set cpo&vim

let s:_ = 1 " disabled: -1, enabled: 0, uninitialized: 1

function! s:def(name, ...) abort
  let hi_grp = 'StatusLine' . s:titlecase(a:name)
  let fn = 'statusline#' . a:name
  return exists('*'. fn) ? printf('%%#%s#%%{%s()}%%*', hi_grp, fn) : ''
endfunction

function! s:titlecase(word)
  return substitute(substitute(substitute(a:word,'_',' ','g'), '\(\<\w\)','\=toupper(submatch(1))','g'), ' ', '', 'g')
endfunction

function! s:statusline_expr() abort
  " if !exists('*WebDevIconsGetFileTypeSymbol')
  "   echohl WarningMsg | echo 'statusline: vim-devicons plugin is required to display file icons' | echohl NONE
  " endif

  let l:_trunc = '%<' " truncate items to the left if too long
  let l:_align = '%=' " everything after this line is right aligned
  let l:mode = s:def('mode') " show mode
  let l:paste = s:def('paste') " show paste
  let l:fname = s:def('fname_full') " show file name with icons
  let l:linter = s:def('linter') " show linter
  let l:tag = s:def('current_function_tag')
  let l:git = s:def('git') " show git branch
  let l:ft = s:def('ft_icon') " show file type
  let l:enc = '%{&fenc != "" ? &fenc : &enc}  %l:%-2c'
  let l:ff = '%{&ff} %*'
  let l:u = '%#Eleline9# %P %*'

  let l:expr = {}
  let l:expr.active = {}

  let l:expr.active.slim = l:fname . l:_trunc
  let l:expr.active._ =
        \ ' ' . l:expr.active.slim .
        \ l:_align .
        \ join([l:tag, '', l:linter, l:git, l:enc, l:ft], repeat(' ', 2))

  let l:expr.inactive = l:expr.active
  return l:expr
endfunction

function! statusline#update(...) abort
  if s:_ == -1 || s:is_invalid_win() | return | endif

  let w = winnr()
  let e = get(a:, 'force', !exists('s:expr')) ? s:statusline_expr() : s:expr
  let s:expr = e

  let slim = utils#boolexists('statusline_slimmode')
  let slimw = get(g:, 'statusline_slimwidth', 50)

  for n in range(1, winnr('$'))
    call setwinvar(n, '&statusline',
          \ e[n!=w ? 'active' : 'inactive'][slim || winwidth(n) <= slimw ? 'slim' : '_'])
  endfor
endfunction

function! s:on_mode_change(mode) abort
  " todo
endfunction

function! s:is_temp_file()
  if !empty(&buftype) || &previewwindow
    return 1
  endif
  let curfname = expand('%:p')
  return curfname =~# '^/tmp' || curfname =~# '^fugitive:'
endfunction

function! s:is_invalid_win() abort
  return s:is_temp_file() "|| &buftype ==# 'popup'
endfunction

" init vars and set statusline
call statusline#update()

augroup statusline_update
  autocmd!
  " Change colors for insert mode
  " autocmd InsertEnter,InsertChange * call s:on_mode_change(v:insertmode)
  autocmd WinEnter,ColorScheme * call statusline#update()
augroup END

let &cpo=s:save_cpo
unlet s:save_cpo
