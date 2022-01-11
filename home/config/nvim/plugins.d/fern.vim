" Fern configuration
"

" Disable netrw
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1

" fern settings
let g:fern_renderer_devicons_disable_warning = 1
let g:fern#default_hidden                    = 1
let g:fern#disable_default_mappings          = 1
let g:fern#drawer_keep                       = 1
let g:fern#disable_drawer_auto_resize        = 1
let g:fern#renderer                          = "devicons"
let g:fern#drawer_width                      = 40

" start fern on vim enter if is directory
let g:fern_vimstart = v:true

" make fern windows 'slide' in and out on open
call utils#window#slide_window('fern', g:fern#drawer_width)

augroup fern_ftdetect
  au!

  " replace netrw with fern to open directory
  autocmd BufEnter * ++nested call <SID>hijack_netrw()

  " set drawer colors on color scheme change
  autocmd ColorScheme * call <SID>set_colors()

  " customize fern buffer
  autocmd FileType fern call <SID>fern_init()

  " add mappings to rename buffer to feel more natural
  autocmd FileType fern-renamer
        \  nnoremap <buffer> <cr> :w<cr>
        \| nnoremap <buffer> <esc> :q!<cr>
        \| nnoremap <buffer> q :q!<cr>
augroup END

fu! s:hijack_netrw()
  let path = fnameescape(expand('%:p'))
  if isdirectory(path)
    bwipeout %
    exe 'cd' path
    if !has('vim_starting') || g:fern_vimstart
      Fern .
      " try
      "   call fern#toggle_drawer(path)
      " catch
      " endtry
    endif
  endif
endfu

fu! fern#get_status_string() abort
  return 'fern'
endfu

let s:drawer = utils#window#toggle_window('fern_drawer')
fu! fern#toggle_drawer(...) abort
  let path = get(a:, 1, fnamemodify('.', ':p'))
  call s:drawer.toggle(
    \ { -> execute(printf('Fern %s -drawer -keep -reveal=%s', path, expand('%'))) })
endfu

command! Drawer call fern#toggle_drawer()

fun! s:set_colors()
  " set custom fern colors
  hi       FernLeaf ctermfg=159 guifg=#3E4B59
  hi! link FernRoot Keyword
  hi! link FernBranch Keyword
endf

function! s:fern_init() abort
  silent! call utils#explorer#init("fern")
  call s:set_colors()

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

  nmap <buffer> <Plug>(fern-action-rename) <Plug>(fern-action-rename:tabedit)

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
  nmap <buffer> q :<C-u>silent call fern#toggle_drawer()<cr>
endfunction

" vim: sw=2 sts=2 tw=0 fdm=marker
