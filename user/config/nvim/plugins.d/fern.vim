" Fern configuration
"

" Disable netrw
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1

" fern settings
let g:fern#disable_drawer_auto_quit = 1
let g:fern#default_hidden = 1
let g:fern#drawer_keep=1
let g:fern#disable_drawer_auto_resize=1
let g:fern#renderer="devicons"
let g:fern#drawer_width = 32
let g:fern#disable_default_mappings = 1
let g:fern#disable_drawer_auto_winfixwidth= 1

command! Drawer call OpenFernDrawer()

augroup fern_ftdetect
  au!
  autocmd FileType fern call <SID>fern_init()
  autocmd BufEnter * ++nested call <SID>hijack_netrw()
  autocmd ColorScheme * call <SID>set_colors()
augroup END

fun! s:set_colors()
  hi       FernLeaf ctermfg=159 guifg=#3E4B59
  hi! link FernRoot Keyword
  hi! link FernBranch Keyword
  " call fern#renderers.devicons().highlight() " update icon highlight
endf

function! s:fern_init() abort
  silent! call utils#explorer#init("fern")
  call s:set_colors()

  let t:fern_drawer_win_id = win_getid()

  " disable these mappings
  nmap <silent> <buffer> <3-LeftMouse> <Nop>
  nmap <silent> <buffer> <4-LeftMouse> <Nop>
  nmap <buffer> p <Nop>
  nmap <buffer> P <Nop>

  " set default open action to select window
  " or edit if in explorer mode
  nmap <buffer> <expr> <Plug>(fern-action-open)
    \ fern#smart#drawer(
    \   "\<Plug>(fern-action-open:edit)",
    \   "\<Plug>(fern-action-open:select)",
    \ )

  nmap <buffer> <Plug>(fern-action-rename) <Plug>(fern-action-rename:vsplit)
  hi! link FernRoot Keyword

  " set custom close on open action, no space after \ and before :<C-u> is
  " important
  nmap <silent> <buffer> <Plug>(fern-close-on-open)
    \ <Plug>(fern-action-open)
    \:<C-u>FernDo close -drawer -stay<CR>

  " perform 'open' on leaf node, 'expand' on collapsed node, and
  " 'collapse' on expanded node.
  nmap <buffer> <expr> <Plug>(fern-expand-or-collapse)
    \ fern#smart#leaf(
    \   "\<Plug>(fern-close-on-open)",
    \   "\<Plug>(fern-action-expand)",
    \   "\<Plug>(fern-action-collapse)",
    \ )


  " set custom enter action to open if file or enter if directory
  nmap <buffer> <expr> <Plug>(fern-open-or-enter)
    \ fern#smart#leaf(
    \   "\<Plug>(fern-close-on-open)",
    \   "\<Plug>(fern-action-enter)",
    \   "\<Plug>(fern-action-enter)",
    \ )

  " perform 'expand' on drawer and 'enter' on explorer
  nmap <buffer> <expr> <Plug>(fern-expand-or-enter)
    \ fern#smart#drawer(
    \   "\<Plug>(fern-action-enter)",
    \   "\<Plug>(fern-expand-or-collapse)",
    \ )

  " perform 'collapse' on drawer and 'leave' on explorer
  nmap <buffer> <expr> <Plug>(fern-collapse-or-leave)
    \ fern#smart#drawer(
    \   "\<Plug>(fern-action-leave)",
    \   "\<Plug>(fern-action-collapse)",
    \ )

  nmap <buffer> <CR> <Plug>(fern-expand-or-enter)<C-w>p:q<cr><C-w>p
  nmap <buffer> l    <Plug>(fern-expand-or-enter)
  nmap <buffer> L    <Plug>(fern-open-or-enter)
  nmap <buffer> h    <Plug>(fern-collapse-or-leave)
  nmap <buffer> H    <Plug>(fern-action-leave)
  nmap <buffer> <LeftMouse> <LeftMouse>^w
  nmap <buffer> <2-LeftMouse> <Plug>(fern-expand-or-collapse)
  nnoremap <silent><buffer><expr> <Tab> <SID>fern_toggle_zoom()
  nmap <buffer> d <Plug>(fern-action-remove)
  nmap <buffer> D <Plug>(fern-action-remove)
  nmap <buffer> r <Plug>(fern-action-rename)
  nmap <buffer> <C-r> <Plug>(fern-action-reload)<C-o>
  nmap <buffer> o <Plug>(fern-action-open:edit)
  nmap <buffer> go <Plug>(fern-action-open:edit)<C-w>p
  nmap <buffer> t <Plug>(fern-action-open:tabedit)
  nmap <buffer> T <Plug>(fern-action-open:tabedit)gT
  nmap <buffer> i <Plug>(fern-action-open:split)
  nmap <buffer> gi <Plug>(fern-action-open:split)<C-w>p
  nmap <buffer> s <Plug>(fern-action-open:vsplit)
  nmap <buffer> gs <Plug>(fern-action-open:vsplit)<C-w>p
  nmap <buffer> C <Plug>(fern-action-enter)
  nmap <buffer> u <Plug>(fern-action-leave)
  nmap <buffer> cd <Plug>(fern-action-cd)
  nmap <buffer> CD gg<Plug>(fern-action-cd)<C-o>
  nmap <buffer> I <Plug>(fern-action-hide-toggle)
  nmap <buffer> md <Plug>(fern-action-new-dir)
  nmap <buffer> mf <Plug>(fern-action-new-file)
  nmap <buffer> . <Plug>(fern-action-hide-toggle)
  nmap <buffer> q :<C-u>quit<CR>
endfunction

fu! s:hijack_netrw()
  let path = fnameescape(expand('%:p'))
  if !isdirectory(path)
    return
  endif
  bwipeout %
  exe 'cd ' . path
  execute printf('Fern %s -drawer', path)
endfu

fu! fern#get_status_string() abort
  return 'fern'
endfu

fu! ToggleFernDrawer() abort
  let w = win_id2win(get(t:, 'fern_drawer_win_id', -1))
  if w == 0
    call OpenFernDrawer()
  else
    exe w . 'wincmd c'
    unlet t:fern_drawer_win_id
  endif
endfu

fu! OpenFernDrawer() abort
  " open fern drawer
  " echo fnamemodify('.', ':p')
  exe printf('Fern %s -drawer -width=%d -keep -reveal=%s',
    \  fnamemodify('.', ':p'),
    \  g:fern#drawer_width,
    \  expand('%')
    \ )
endfu
