" firenvim.vim
"

if exists('g:started_by_firenvim') && g:started_by_firenvim
  " general options
  set laststatus=0 nonumber noruler noshowcmd

  " general config for firenvim
  let g:firenvim_config = {
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
      \ '.*': {
        \ 'cmdline': 'neovim',
        \ 'priority': 0,
        \ 'selector': 'textarea',
        \ 'takeover': 'never',
      \ },
    \ }
  \ }

  augroup firenvim
    autocmd!
    autocmd BufEnter *.txt setlocal filetype=markdown.pandoc
  augroup END
endif

" vim: sw=2 sts=2 tw=0 fdm=marker
