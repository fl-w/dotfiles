" utils.vim: contains useful functions and settings
"

fu! utils#is_plug_loaded(plugname)
  return exists('g:plugs') && has_key(g:plugs, a:plugname)
endfu

fu! utils#boolexists(varname) abort
  if !exists(a:varname)
    return v:false
  endif
  redir => value
  silent execute 'echon ' . a:varname
  redir END
  return value
endfu

fu! utils#sliding_window(name, opt)
  " name: name of sliding window
  " opt:
  "   width | height: size of window in direction
  "   close: callback function to close new win
  let is_width = has_key(a:opt, 'width')
  let size = is_width ? a:opt.width : a:opt.height
  let window = { 'name': a:name, 'is_width': is_width, 'size': size }

  function! window.id()
    return get(t:, self.name, -1)
  endf

  function! window.is_open()
    return win_id2win(self.id()) != 0
  endf

  function! window._resize(size)
    exe printf('%sresize %d', self.is_width ? 'vert ' : '', a:size)
  endf

  function! window._animate(size, callback)
    try
      call win_gotoid(self.id())
      exe printf('call animate#window_absolute_%s(%f)', self.is_width ? 'width' : 'height', a:size)
      call timer_start(float2nr(get(g:, 'animate#duration', 0)), a:callback)
    catch
      call self._resize(a:size)
      call a:callback()
    endtry
  endf

  function! window.open(...) abort
    " open([, fnc])
    " {fnc} is the callback function to create the new window
    if win_gotoid(self.id()) | return | endif

    let name = self.name
    let Create = get(a:, 1,
          \ { -> execute(printf('%s +set\ nobuflisted %s', self.is_width ? 'topleft vsplit' : 'botright split', name)) })

    try
      call Create() | call statusline#update_hi() | setl wfh wfw
    catch
      echoerr 'Error: could not create window with function:' string(Create)
      return
    endtry

    call settabvar(tabpagenr(), name, win_getid())
    call self._resize(1)
    call self._animate(self.size, { -> printf('')})
  endf

  function! window.close()
    let w = win_id2win(self.id())
    let name = self.name
    call self._animate(1, { -> execute([printf('%dwincmd c', w), printf('unlet t:%s', name)]) })
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

function! utils#sliding_window_animate(size, callback, ...)
  let vert = get(a:, 1, v:false)

  try
    exe printf('call animate#window_absolute_%s(%f)', vert ? 'height' : 'width', a:size)
    call timer_start(float2nr(get(g:, 'animate#duration', 0)), a:callback)
  catch
    call printf('%sresize %d', vert ? '' : 'vert', a:size)
    call a:callback()
  endtry
endf

fun! utils#hide_statusline()
  let &l:statusline='%{getline(line("w$")+1)}' " hide statusline
endf

" https://github.com/lambdalisue/dotfiles/blob/6304fb488916d07d24e97e0c9bb785320bff1f4a/nvim/init.vim#L422
function! utils#auto_mkdir(dir, force) abort
  if empty(a:dir) || a:dir =~# '^\w\+://' || isdirectory(a:dir) || a:dir =~# '^suda:'
    return
  endif
  if !a:force
    echohl Question | call inputsave()
    try
      let result = input(
            \ printf('"%s" does not exist. Create? [y/N]', a:dir),
            \ '',
            \)
      if empty(result)
        echohl WarningMsg | echo 'Canceled'
        return
      endif
    finally
      call inputrestore()
      echohl None
    endtry
  endif
  call mkdir(a:dir, 'p')
endfunction

function! utils#isdir(dir) abort
  " tests whether the path of the current buffer matches a directory.
  return !empty(a:dir) && (isdirectory(a:dir) ||
        \ (!empty($SYSTEMDRIVE) && isdirectory('/'.tolower($SYSTEMDRIVE[0]).a:dir)))
endfunction

function! utils#project_root()
  return getcwd()
endfunction

function! utils#trim_whitespace()
  " Trims trailing whitespace
  """
  let l:save = winsaveview()
  %s/\s\+$//e
  call winrestview(l:save)
endfunction

function s:safe(cmd) abort
  try
    exe a:cmd
  catch
    return
  endtry
endf

function! utils#init_minimal_window() abort
  setl nonumber norelativenumber
  setl noruler
  setl nospell
  setl nolist
  setl conceallevel=3

  call s:safe('IndentLinesDisable') " disable indent lines

endfunction

function! utils#set_cursor_postition()
  " Function to recover cursor postion
  " dont do it when writing a commit log entry
  """
  if &filetype !~ 'svn\|commit\c'
    if line("'\"") > 0 && line("'\"") <= line("$")
      exe "normal! g`\""
      normal! zz
    endif
  else
    call cursor(1,1)
  endif
endfunction

function! utils#toggle_setting(name) abort
  " toggle given setting name
  """
  if !exists('&' . a:name)
    echohl WarningMsg | echo printf("cannot toggle unknown setting: '%s'", a:name) | echohl None
    return
  endif
  if execute('echon &'. a:name)
    exe 'set no' . a:name
    echo a:name . ': off'
  else
    exe 'set' a:name
    echo a:name . ': on'
  endif
endfunction

function! utils#abbr_command(from, to)
  " Function to abbr commands
  """
  exec 'cnoreabbrev <expr> ' . a:from
        \ . ' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

" Replace word under cursor
function! Rename_under_cursor(...)
  let l:winview = winsaveview()
  let l:curword = expand('<cword>')
  let l:singleline = get(a:, 0, 0)
  let l:range = l:singleline ? "," : "%"

  call inputsave()
  let l:replacement = input('replacement: ')
  call inputrestore()

  exe l:range . "s/" . l:curword . "/" . l:replacement . "/g"
  call winrestview(l:winview)
  redraw
  echo "\"" . l:curword . "\" replaced with \"" . l:replacement . "\" in " . (l:singleline ? "line" : "file")
endfunction

function! utils#jump_error()
  " go to the next error
  """
  try
    lnext
  catch
    try | lfirst | catch | endtry
  endtry
endfunction
