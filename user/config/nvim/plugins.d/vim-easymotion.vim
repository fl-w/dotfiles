" vim-easy-motion configuration
"

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase  = 1
let g:EasyMotion_inc_highlight     = 0
let g:EasyMotion_landing_highlight = 0
let g:EasyMotion_off_screen_search = 0
let g:EasyMotion_smartcase         = 0
let g:EasyMotion_startofline       = 0
let g:EasyMotion_use_smartsign_us  = 1
let g:EasyMotion_use_upper         = 0
let g:EasyMotion_skipfoldedline    = 0

function! Easyfuzzymotion(...)
  return extend(copy({
  \   'converters': [incsearch#config#fuzzy#converter()],
  \   'modules': [incsearch#config#easymotion#module()],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction

""" IncSearch
noremap <silent><expr> <Space>/ incsearch#go(Easyfuzzymotion())
map /                           <Plug>(incsearch-easymotion-/)
" map ?                           <Plug>(incsearch-easymotion-?)
map g/                          <Plug>(incsearch-easymotion-stay)

" `s{char}{char}{label}`
nmap s                  <Plug>(easymotion-s2)
" JK motions: Line motions
map <leader>j                   <Plug>(easymotion-j)
map <leader>k                   <Plug>(easymotion-k)

" vim: sw=2 sts=2 tw=0 fdm=marker
