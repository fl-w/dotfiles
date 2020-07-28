" window.vim
"

if !exists("g:window_buffer_cycle")
  let g:window_buffer_cycle = 1
endif

function! s:on_window_add(...) abort
  let w = get(a:, 1, winnr())
  call setwinvar(w, "window_buffers", [])
endfunction

" function! s:on_window_close() abort
"   echom "close window ".expand('<amatch>')."--". win_getid()
" endfunction

augroup window_catch
  autocmd!
  autocmd WinNew * call s:on_window_add()
  " autocmd WinClosed * call s:on_window_close()
  autocmd BufWinEnter * call window#add_buffer()
  autocmd BufDelete * call window#remove_buffer()
augroup END

function window#refresh_buffers_list()
  for w in range(1, winnr('$'))
    if !exists('w:window_buffers')
      call s:on_window_add(w)
    else
      " add current buffer to list of this window
      call window#add_buffer(w)
    endif
  endfor
endfunction

function! window#add_buffer(...) abort
  " add_buffer({win}, {buf})
  let win = get(a:, 1, winnr())
  let buf = get(a:, 2, winbufnr(win))
  let list = window#get_buffer_list(win)
  if index(list, buf) == -1
    call sort(add(list, buf))
  endif
endfunction

function! window#remove_buffer(...) abort
  " remove_buffer({win}, {buf})
  let w = get(a:, 1, winnr())
  let b = window#get_buffer_list(w)
  let i = index(b, get(a:, 2, winbufnr(w)))
  if i != -1
    call remove(b, i)
  endif
endfunction

function! window#remove_all_buffer(...) abort
  " remove_buffer({buf})
  let b = get(a:, 1, bufnr('%'))
  for w in range(1, winnr('$'))
    call window#remove_buffer(w, b)
  endfor
endfunction

function window#get_buffer_list(...) abort
  return getwinvar(get(a:, 1, winnr()), "window_buffers", -1)
endfunction

function! window#buffer_prev() abort
  let w = window#get_buffer(v:false)
  if w != -1
    exe "buffer" w
  endif
endfunction

function! window#buffer_next() abort
  let w = window#get_buffer(v:true)
  if w != -1
    exe "buffer" w
  endif
endfunction

function! window#get_buffer(next, ...) abort
  let w = get(a:, 2, 1)
  let b = window#get_buffer_list()
let g:buffet_left_trunc_icon = "\uf0a8"
  let l = len(b)
  if l == 0
    return -1
  else
    let n = index(b, winbufnr(w))
    return b[a:next ?
          \ n + 1 == l ? g:window_buffer_cycle ? 0 : l - 1 : n + 1
          \ : n - 1 < 0 ? g:window_buffer_cycle ? l - 1 : 0 : n - 1
          \]
  endif
endfunction

function! window#update_tabline() abort
endfunction

function! window#tabline() abort
  let t = ''
  let l =  window#get_buffer_list()
  for b in range(1, len(l))
    let t .= i == bufnr() ? '%#TabLineSel#' : '%#TabLine#'

	    " set the tab page number (for mouse clicks)
	    let s .= '%' . (i + 1) . 'T'

	    " the label is made by MyTabLabel()
	    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
	  endfor

	  " after the last tab fill with TabLineFill and reset tab page nr
	  let s .= '%#TabLineFill#%T'

	  " right-align the label to close the current tab page
	  if tabpagenr('$') > 1
	    let s .= '%=%#TabLine#%999Xclose'
	  endif
	  return s
endfunction

	function MyTabLabel(n)
	  let buflist = tabpagebuflist(a:n)
	  let winnr = tabpagewinnr(a:n)
	  return bufname(buflist[winnr - 1])
	endfunction

nnoremap <silent> <right> :call window#buffer_next()<cr>
nnoremap <silent> <left> :call window#buffer_prev()<cr>

call window#refresh_buffers_list()

if exists('g:window_buffer_set_tabline') && g:window_buffer_set_tabline
  set tabline=%!window#tabline()

endif
