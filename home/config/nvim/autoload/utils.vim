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
  if g:is_work
    return
  endif

  let l:save = winsaveview()
  %s/\s\+$//e
  call winrestview(l:save)
endfunction

function utils#safe(cmd) abort
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

  call utils#safe('IndentLinesDisable') " disable indent lines

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

" vim: sw=2 sts=2 tw=0 fdm=marker
