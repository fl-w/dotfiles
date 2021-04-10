" coc.nvim configuration
"

set nobackup
set nowritebackup
set pumheight=15
set completeopt-=preview

if exists('*utils#abbr_command')
  call utils#abbr_command('ci', 'CocInstall')  " Use ci to install coc extention
  call utils#abbr_command('cu', 'CocUninstall')  " Use cu to uninstall coc extention
  call utils#abbr_command('coc', 'CocConfig')  " Use coc to open coc config
endif

let g:coc_global_extensions = [ 
  \ "coc-syntax"       ,
  \ "coc-snippets"     ,
  \ "coc-lists"        ,
  \ "coc-json"         ,
  \ "coc-rust-analyzer",
  \ "coc-clangd"       ,
  \ ]

" configure error color
highlight! link CocErrorSign Error

augroup coc_autocomplete
  au!

  " coc-highlight: highlight word under cursor
  au CursorHold * silent call CocActionAsync('highlight')

  " show signature in insert mode
  au CursorHoldI * silent call CocActionAsync('showSignatureHelp')

  " Update signature help on jump placeholder.
  au User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

  " Format prior to save
  autocmd BufWritePre * silent call CocAction('format')
  " close the preview window when completion is done.
  au CompleteDone * if pumvisible() == 0 | silent! pclose | endif
augroup END

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

function! s:tab_complete() abort
  if coc#expandableOrJumpable()
    " uses coc-snippet to check neosnippet/ultisnips/etc
    return "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>"
  endif
  if pumvisible()
    " complete_info()["selected"] gives index of selected completion
    return exists('*complete_info') ?
          \ complete_info()["selected"] == "-1" ? "\<c-n>\<c-y>" : "\<c-y>"
          \ : "\<c-y>"
  endif
  return s:check_back_space() ? "\<tab>" : coc#refresh()
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

nnoremap <silent> K :call <sid>show_documentation()<cr>

" completes tab completion on insert mode
" on selection, completions are expanded if snippet
" if no completion selected: auto completes the first item on list
" otherwise: selects the selected completion
inoremap <silent> <expr>   <TAB> <sid>tab_complete()
inoremap <silent> <expr> <S-TAB> pumvisible() ? "\<c-n>" : "\<c-h>"
inoremap <silent> <expr>    <CR> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>\<c-r>=coc#on_enter()\<cr>"
" inoremap <silent> <expr>   <ESC> pumvisible() ? "\<c-e>" : "\<esc>"

" Use `[e` and `]e` to navigate diagnostics
nmap    <silent> [e <Plug>(coc-diagnostic-prev)
nmap    <silent> ]e <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap    <silent> gd <Plug>(coc-definition)
nmap    <silent><nowait> go :CocFzfList outline<cr>
nmap    <silent><nowait> gO :CocFzfList symbols<cr>
nmap    <silent><nowait> ge :CocFzfList diagnostics<cr>
nmap    <silent><nowait> gE :CocFzfList diagnostics --current-buf<cr>
nmap    <silent> ga <Plug>(coc-codeaction-selected)w
nmap    <silent> gy <Plug>(coc-type-definition)
nmap    <silent> gi <Plug>(coc-implementation)
nmap    <silent> gr <Plug>(coc-references)
nmap    <silent> gR <Plug>(coc-rename)

xmap    <silent> if <Plug>(coc-funcobj-i)
xmap    <silent> af <Plug>(coc-funcobj-a)
omap    <silent> if <Plug>(coc-funcobj-i)
omap    <silent> af <Plug>(coc-funcobj-a)
xmap    <silent> ic <Plug>(coc-classobj-i)
xmap    <silent> ac <Plug>(coc-classobj-a)
omap    <silent> ic <Plug>(coc-classobj-i)
omap    <silent> ac <Plug>(coc-classobj-a)

" vim: sw=2 sts=2 tw=0 fdm=marker
