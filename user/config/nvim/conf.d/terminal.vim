" terminal configuration.
"

" if !exists(':terminal') | finish | endif

let s:term_height = 0.21
let s:term_name = 'terminal-window'
let s:term_auto_clear = v:false

let s:terminal = utils#sliding_window('terminal_window_id', { 'height': &lines * s:term_height })

" Q to hide terminal
" tnoremap <expr> Q if &buftype == 'terminal' | echo noo | endif

fu! s:term_init()
  setl nonumber nornu " remove line numbering
  setl nobuflisted    " hide term buffers
  setl noruler
  setl noshowmode
  setl cmdheight=1
  setl nocursorline
  setl bufhidden=hide

  let &l:statusline='%{getline(line("w$")+1)}' " hide statusline

  startinsert

  " Leave insert mode with escape in a term buffer and goto last win
  tnoremap <buffer> <Esc> <C-\><C-n>
  nnoremap <buffer> <silent> q :call terminal#close()<cr>
  nnoremap <buffer> h <C-w>h
  nnoremap <buffer> j <C-w>j
  nnoremap <buffer> k <C-w>k
  nnoremap <buffer> l <C-w>l
endfu

augroup term_btdetect
  au!
  " au VimResized *
  au BufEnter * if &buftype == 'terminal' | :startinsert | endif
  au BufEnter term://* startinsert
  au TermOpen * if win_getid() == s:terminal.id()
        \ | call s:term_init()
        \ | endif
augroup END

function! terminal#toggle()
  if s:terminal.is_open()
    call terminal#close()
  else
    call terminal#open()
  endif
endf

fun! terminal#close()
  call s:terminal.close()
endf

fun! terminal#open() abort
  " create a window pane
  call s:terminal.open()

  call win_gotoid(s:terminal.id())
  let name = terminal#get_ready_term()

  " create buffer if not exists
  if !bufexists(name)
    " spawn term
    call termopen($SHELL, { 'detach': 1 })

    " rename buffer
    silent exe 'noswapfile keepalt file' name
  else
    exe 'buffer' name
  endif
endfunction

fun! terminal#get_ready_term(...)
  " args: from
  " todo: return first available term buffer name
  return printf('%s-%d', s:term_name, get(a:, 1, 1))
endf


fun! terminal#exec_interactive()
  call inputsave() | let cmd = input('exec> ') | call inputrestore()
  if !isempty(cmd)
    call terminal#exec(cmd, v:true)
  endif
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

nnoremap <silent> <leader>tt :call terminal#toggle()<cr>
nnoremap <silent> <leader>to :call terminal#open()<cr>
nnoremap <silent> <leader>tc :call terminal#close()<cr>
nnoremap <silent> <leader>te :call terminal#exec_interactive()<cr>
