
setl formatoptions-=r       | " disable auto insert comment after <cr> in insert mode
setl formatoptions-=o       | " disable auto insert comment after o or O

" Use :help command for keyword when pressing `K` in vim file,
" see `:h K` and https://stackoverflow.com/q/15867323/6064933
setl keywordprg=:help

" set only useful autopairs in vim fts
if &runtimepath =~? 'auto-pairs'
  let b:AutoPairs = {'(':')', '[':']', '{':'}', "'":"'", "`":"`", '<':'>'}
endif
