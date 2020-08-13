" statusline.vim: helper functions for statusline
"

scriptencoding utf-8

let s:mode_map = extend(get(g:, 'statusline#mode_map', {}), {
  \ 'n': "\ufb26",
  \ 'i': "",
  \ 'R': '',
  \ 't': '~',
  \ 'v': 'VISUAL', 'V': 'V-LINE', "\<C-v>": 'V-BLOCK',
  \  'c': 'COMMAND', 's': 'SELECT', 'S': 'S-LINE', "\<C-s>": 'S-BLOCK'
  \ })

let s:ft_map = extend(get(g:, 'statusline#ft_map', {}), {
  \ 'unite': 'Unite', 'vimshell': 'VimShell',
  \ 'fern': function('fern#get_status_string'),
  \ 'vimfiler': function('vimfiler#get_status_string'),
  \ })

function! statusline#map_mode(mode, str)
  let s:mode_map[a:mode] = a:str
endfu

fun! statusline#map_ft(ft, map)
  let s:ft_map[a:ft] = a:map
endf

fun! s:tjoin(l, ...)
  return join(filter(a:l, 'v:val != ""'), get(a:, 1, ' '))
endf

function! statusline#mode()
  return get(s:mode_map, mode(), '')
endfunction

function! statusline#paste()
  return &paste ? 'PASTE ' : ''
endfunction

function! statusline#fname()
  return expand("%:.")
endfunction

function! statusline#fname_full_active()
  " return '« ' . statusline#fname() . ' »'
  return statusline#fname()
endfunction

function! statusline#fname_full()
  return has_key(s:ft_map, &ft) ? type(s:ft_map[&ft]) == 2 ? s:ft_map[&ft]() : s:ft_map[&ft]() :
        \ s:tjoin([statusline#fname(), statusline#fname_readonly(), statusline#fname_modified()])
endfunction

function! statusline#fname_readonly()
  return !&readonly ? '' : get(g:, 'statusline_icon_readonly', '') "  is a good alt
endfunction

function! statusline#fname_modified()
  return !&modified ? '' : get(g:, 'statusline_icon_modified', '') " ⚡is a good alt
endfunction

function! statusline#ftype()
  return get(s:ft_map, &ft, '')
endfunction

fun! statusline#ft_icon()
  return exists('*WebDevIconsGetFileTypeSymbol') && &ft != '' ? WebDevIconsGetFileTypeSymbol() :  get(g:, 'statusline_icon_file', '')
endf

function! statusline#git()
  return trim(join([statusline#gitbranch(), statusline#gitstatus()]))
endfunction

function! statusline#gitbranch()
  if !exists('g:loaded_fugitive')
    return ''
  endif
  let branch = fugitive#head()
  return branch ==# '' ? branch : branch . ' ' . get(g:, 'statusline_icon_branch', '')
endfunction

function! statusline#gitstatus()
  if !exists('*sy#repo#get_stats()')
    return ''
  endif
  let [a, m, r] = sy#repo#get_stats()
  return max([a, m, r]) > 0 ? printf('+%d ~%d -%d', a, m, r) : ''
endfunction

function! statusline#current_function_tag()
  let fn = get(b:, 'vista_nearest_method_or_function', get(b:, 'coc_current_function', ''))
  return !empty(fn) ? printf('%s()', fn) : ''
endfunction

function! statusline#linter() abort
  return printf('%s  %s', statusline#linter_warning() , statusline#linter_error())
endfunction

function! statusline#linter_warning() abort
  return printf('%s %s', get(g:, 'statusline#icon#warning', ''),
        \  get(get(b:, 'coc_diagnostic_info', {}), 'warning', 0))
endfunction

function! statusline#linter_error() abort
    " ✘ is a good alt
  return printf('%s %s',
        \  get(g:, 'statusline#icon#error', ''),
        \  get(get(b:, 'coc_diagnostic_info', {}), 'error', 0))
endfunction

function! statusline#hlsearch() abort
  return !&hlsearch ? '' : ' ' . get(g:, 'statusline_icon_search', '' )
endfunction

function! statusline#spell() abort
  return !&spell ? '' : ' ' . get(g:, 'statusline_icon_spell', '' )
endfunction

function! statusline#markdownpreview() abort
  return exists('b:markdownpreview') ? get(g:, 'statusline_icon_markdownpreview', '' . ' ') : ''
endfunction
