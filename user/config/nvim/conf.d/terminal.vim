" terminal configuration.
"

" if !exists(':terminal') | finish | endif

let s:term_height = 10
let s:term_name = 'terminal'
let s:term_auto_clear = v:false

let s:term_pane = -1

  " Leave insert mode with escape in a term buffer and goto last win
tnoremap <Esc> <C-\><C-n><CR><c-w><c-p>

" Q to hide terminal
" tnoremap <expr> Q if &buftype == 'terminal' | echo noo | endif

fu! s:term_init()
  setl nonumber       " remove line numbering
  setl nobuflisted    " hide term buffers
  setl laststatus=0   " hide statusline
  setl noruler
  setl noshowmode
  setl noshowcmd
  setl cmdheight=1
  set bufhidden=hide
endfu

augroup term_btdetect
  au!
  " au VimResized *
  au BufEnter * if &buftype == 'terminal' | :startinsert | endif
  au BufEnter term://* startinsert
  au TermOpen * call <SID>term_init()
augroup END

function! terminal#toggle()
  if terminal#is_open()
    call terminal#open()
  else
    call terminal#close()
  endif
endf

fun! terminal#close()
  let w = win_id2win(s:term_pane)
  if w > 0
    exe w . "wincmd c"
    let s:term_pane = -1
  endif
endf

fun! terminal#is_open()
  return win_id2win(s:term_pane) == 0
endf

fun! terminal#open()
  " create a window pane
  if !win_gotoid(s:term_pane)
    exe 'botright split' s:term_name . '-window'
    exe 'resize' s:term_height
    setl wfh wfw

    let s:term_pane = win_getid()
  endif

  " create buffer if not exists
  if !bufexists(s:term_name . '-1')
    " echom 'opening new term buffer'
    " spawn term
    call termopen($SHELL, { 'detach': 1 })

    " todo allow for multiple buffers
    silent exe 'file' s:term_name . '-1'
    call s:term_init()
  else
    exe 'buffer' s:term_name . '-1'
  endif
endfunction

fun! terminal#get_ready_term(...)
  " args: from
  " todo: return first available term buffer name
  return printf('%s-%d', s:term_name, get(a:, 1, 1))
endf

fun! terminal#exec_interactive()
  " todo: ask for input and send to term
endfu

fun! terminal#exec(cmd, ...)
  " open terminal if not open
  if !terminal#is_open()
    call terminal#open()
  endif

  " get job id of terminal buffer
  let l:term_job_id = getbufvar(terminal#get_ready_term(), 'terminal_job_id')

  " clear term if option is present
  if get(a:, 1, s:term_auto_clear)
    call jobsend(l:term_job_id, "clear\n")
  endif

  " run cmd
  call jobsend(l:term_job_id, printf("%s\n", a:cmd))
endf
