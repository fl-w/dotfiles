" coc-fzf configuration

" GoTo code navigation.
nmap    <silent> <nowait> go :<C-u>CocFzfList outline<cr>
nmap    <silent> <nowait> gO :<C-u>CocFzfList symbols<cr>
nmap    <silent> <nowait> ge :<C-u>CocFzfList diagnostics<cr>
nmap    <silent> <nowait> gE :<C-u>CocFzfList diagnostics --current-buf<cr>

" vim: sw=2 sts=2 tw=0 fdm=marker
