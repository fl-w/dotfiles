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

function! utils#isdir(dir) abort
  " tests whether the path of the current buffer matches a directory.
  return !empty(a:dir) && (isdirectory(a:dir) ||
        \ (!empty($SYSTEMDRIVE) && isdirectory('/'.tolower($SYSTEMDRIVE[0]).a:dir)))
endfunction

function! utils#trim_whitespace()
  " Trims trailing whitespace
  """
  let l:save = winsaveview()
  %s/\s\+$//e
  call winrestview(l:save)
endfunction

fun! utils#copy_hi_group(group, to)
  let id = synIDtrans(hlID(a:group))
  for mode in ['cterm', 'gui']
    for g in ['fg', 'bg']
      exe 'let '. mode.g. "=  synIDattr(id, '". g."#', '". mode. "')"
      exe "let ". mode.g. " = empty(". mode.g. ") ? 'NONE' : ". mode.g
    endfor
  endfor
  exe printf('hi %s ctermfg=%s ctermbg=%s guifg=%s guibg=%s', a:to, ctermbg, ctermfg, guifg, guibg)
endf

function! utils#nonwrite_buffer_init() abort
  setl nonumber
  setl norelativenumber
  setl nospell
  setl nolist
  setl conceallevel=3
  " disable indent lines
  if exists(':IndentLinesDisable')
    IndentLinesDisable
  endif
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

function! utils#has_colorscheme(name) abort
  " check if a colorscheme exists
  " inspired by https://stackoverflow.com/a/5703164/6064933.
  let l:pat = 'colors/' . a:name . '.vim'
  return !empty(globpath(&runtimepath, l:pat))
endfunction

function! utils#toggle_settings(name) abort
  " toggle given setting name
  """
  if !exists('&' . a:name)
    echohl WarningMsg | echo 'cannot toggle unknwon setting: \''.  | echohl None
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
