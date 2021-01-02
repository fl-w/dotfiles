" statusline.vim: minimal custom statusline (inspired by eleline)
"

" if exists('g:loaded_statusline') || v:version < 700 |  finish | endif
let g:loaded_statusline = 1

let s:save_cpo = &cpo
set cpo&vim

" todo split by (in)/active
function! s:def(name, ...) abort
  let fn = 'statusline#' . a:name
  return exists('*'. fn) ?
        \ printf('%%#%s#%%{%s()}%%*',
        \ 'StatusLine' . s:titlecase(a:name),
        \ fn)
        \ : ''
endfunction

function! s:titlecase(word)
  return substitute(substitute(substitute(a:word,'_',' ','g'),
        \ '\(\<\w\)','\=toupper(submatch(1))','g'), ' ', '', 'g')
endfunction

function! s:statusline() abort
  let l:fname = s:def('fname_full') " show file name with icons
  let l:stl = {}
  let l:stl.active = {}
  let l:stl.inactive = {}

  let l:stl.active['slim'] = l:fname . '%<'
  let l:stl.active['_'] = join([
        \ '%<',
        \ l:fname,
        \ '%=',
        \ join([
          \ s:def('current_function_tag'),
          \ '',
          \ s:def('linter'),
          \ s:def('git'),
          \ '%{&fenc != "" ? &fenc : &enc}  %l:%-2c',
          \ s:def('ft_icon') . ' %{&ft}'],
        \ repeat(' ', 2))
        \])

  " for now make inactive statusline same as active slim
  let l:stl.inactive.slim = l:stl.active.slim
  let l:stl.inactive._ = l:stl.active.slim

  return l:stl
endfunction

function! statusline#update(...) abort
  if s:is_invalid_win() | return | endif

  let w = winnr()
  let slim = utils#boolexists('statusline_slimmode')
  let slimw = get(g:, 'statusline_slimwidth', 50)

  let s:stl = get(a:, '1', !exists('s:stl')) ? s:statusline() : s:stl
  for n in range(1, winnr('$'))
    if getwinvar(n, '&buftype') != 'terminal'
      " call setwinvar(n, '&tabline',
      call setwinvar(n, '&stl',
            \ s:stl[n==w ? 'active' : 'inactive'][slim || winwidth(n) <= slimw ? 'slim' : '_'])
    endif
  endfor
endfunction

function statusline#update_hi() abort
  if !has('nvim')
    return
  endif

  for n in range(1, winnr('$'))
    let hl = getwinvar(n, '&winhl')
    let whl = getwinvar(n, '_statusline_winhl')
    if empty(whl)
      call setwinvar(n, '_statusline_winhl', { 'cache': hl })
    else
      let hl = whl.cache
    endif
    call setwinvar(n, '&winhl', s:win_has_bottom_neighbour(n) ?
          \ hl . "StatusLine:StatusLineI,StatusLineNC:StatusLineINC" :
          \ hl
          \ )
  endfor
endf

fun! s:win_has_bottom_neighbour(n)
  let b = win_screenpos(a:n)[0] + winheight(a:n) - 1
  for l:win in range(1, winnr('$'))
    if a:n != l:win && win_screenpos(l:win)[0] > b && buflisted(winbufnr(l:win))
      return v:true
    endif
  endfor
  return v:false
endf

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
  return s:is_temp_file() || &buftype ==# 'popup'
endfunction

" init vars and set statusline
call statusline#update()

augroup statusline_update
  autocmd!
  " Change colors for insert mode
  " autocmd InsertEnter,InsertChange * call s:on_mode_change(v:insertmode)
  autocmd VimEnter,BufEnter,WinEnter * call statusline#update()
  autocmd WinNew,WinClosed * call statusline#update_hi()
augroup END

hi default link StatusLineI StatusLine
hi default link StatusLineINC StatusLineNC

let &cpo=s:save_cpo
unlet s:save_cpo

" vim: sw=2 sts=2 tw=0 fdm=marker
