fu! utils#explorer#_name()
  return get(g:, 'utils#explorer#name', 'explorer')
endfu

fu! utils#explorer#init(...)
  " This function is called ON an explorer buffer when initialized
  """
  let l:explorer_name = get(a:, 1, utils#explorer#_name())
  exe  'keepalt file ' . l:explorer_name
  setl conceallevel=3
  setl nofoldenable
  setl foldmethod=manual
  setl signcolumn=no
  call utils#init_minimal_window()
endfunction

" vim: sw=2 sts=2 tw=0 fdm=marker
