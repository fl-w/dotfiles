" winslide.vim
"

let s:ft_winsize = get(s:, 'ft_winsize', {})
let s:warned = v:false

function! utils#window#animate(nr, is_vert, size, callback)
  " navigate to window
  exe a:nr . 'wincmd w'

  if exists('g:animate#loaded') && g:animate#loaded
    if !animate#window_is_animating(winnr())
      exe printf('call animate#window_absolute_%s(%f)',
            \ a:is_vert ? 'width' : 'height', a:size)
      call timer_start(float2nr(get(g:, 'animate#duration', 0)), a:callback)
    endif
  else
    if !s:warned
      echohl WarningMsg | echomsg "plug 'animate.vim' is required to animate windows" | echohl NONE
      let s:warned = v:true
    endif
    exe printf('%sresize %d', a:is_vert ? 'vert ' : '', 1)
    call a:callback()
  endif
endf

augroup sliding_window_ftdetect
  au!

  " au WinNew * call timer_start(1, { ->  s:on_new_win(winnr())})
  au FileType * if has_key(s:ft_winsize, &ft) | call s:slide_win(s:ft_winsize[&ft]) | endif
augroup end

fun! s:slide_win(size)
  let n = winnr()

  if winheight(n) + &cmdheight  + 2 == &lines
    let is_vertical = v:true
  elseif winwidth(n) == &columns
    let is_vertical = v:false
  else
    " echohl WarningMsg | echom 'cannot slide, window is not in a valid split' (winwidth(a:n) - &columns )| echohl NONE
    return
  endif

  " minimise window
  exe printf('%sresize %d', is_vertical ? 'vert ' : '', 1)

  " if size is decimal, treat it as a percent
  let size = type(a:size) == v:t_float ?
        \ float2nr((is_vertical ? &columns : &lines) * a:size) :
        \ a:size

  " animate window to correct dimensions
  call utils#window#animate(n, is_vertical, size, { -> printf('') })

  let cl = printf(':call utils#window#animate(%d, %d, 0, { -> execute("%dwincmd c") })', n, is_vertical, n)

  " set win var to animate close this window
  call setwinvar(n, '_animated_close', cl)

  " create mapping to slide out window on <esc>
  exe printf('nnoremap <silent> <buffer> <esc> %s<cr>', cl)
endf

fun! utils#window#slide_window(name, size)
  if a:size > 0
    let s:ft_winsize[a:name] = a:size
  else
    call remove(s:ft_winsize, a:name)
  endif
endf


fu! utils#window#toggle_window(name)
  " name: name of sliding window
  " opt:
  "   size: size of window in direction
  let window = { 'name': a:name }

  function! window.id()
    return get(t:, self.name, -1)
  endf

  function! window.is_open()
    return win_id2win(self.id()) != 0
  endf

  function! window.open(...) abort
    " open([, fnc])
    " {fnc} is the callback function to create the new window
    if win_gotoid(self.id()) | return | endif

    let name = self.name
    let Create = get(a:, 1,
          \ { -> execute(printf('botright split +set\ nobuflisted %s', name)) })

    try
      call Create() | call statusline#update_hi() | setl wfh wfw
    catch
      echoerr 'Error: could not create window with function:' string(Create)
      return
    endtry

    call settabvar(tabpagenr(), name, win_getid())
  endf

  function! window.close()
    let w = win_id2win(self.id())
    let cl = getwinvar(w, '_animated_close')

    " unset tab variable
    exe printf('unlet t:%s', self.name)

    " close normally or animate if possible
    exe empty(cl) ? printf('%dwincmd c', w) : cl
  endf

  function window.toggle(fnc)
    "
    " {fnc} is the callback function to create the new window

    if self.is_open()
      call self.close()
    else
     call self.open(a:fnc)
    endif
  endf

  return window
endf

" vim: sw=2 sts=2 tw=0 fdm=marker
