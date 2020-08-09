" Use :help command for keyword when pressing `K` in vim file,
" see `:h K` and https://stackoverflow.com/q/15867323/6064933
setl keywordprg=:help

setl softtabstop=2
setl shiftwidth=2
setl foldmethod=syntax
setl formatoptions-=r       | " disable auto insert comment after <cr> in insert mode
setl formatoptions-=o       | " disable auto insert comment after o or O

" set only useful autopairs in vim fts
if &runtimepath =~? 'auto-pairs'
  let b:AutoPairs = {'(':')', '[':']', '{':'}', "'":"'", "`":"`", '<':'>'}
endif

if !exists('g:which_key_map')
  nnoremap <buffer> <silent> <leader>.. :source %<cr>
endif

noremap <buffer> <silent> <F10> :<C-u>exec getline('.')<cr>
