" vim-easy-motion configuration
"

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase  = 1

function! Easyfuzzymotion(...)
  return extend(copy({
  \   'converters': [incsearch#config#fuzzy#converter()],
  \   'modules': [incsearch#config#easymotion#module()],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction
