" coc.nvim configuration
"

set nobackup
set nowritebackup
" set pumheight=15
" set completeopt-=preview

if exists('*utils#abbr_command')
  call utils#abbr_command('ci', 'CocInstall')  " Use ci to install coc extention
  call utils#abbr_command('cu', 'CocUninstall')  " Use cu to uninstall coc extention
  call utils#abbr_command('coc', 'CocConfig')  " Use coc to open coc config
endif

let g:auto_format_ft          = [ 'rs' ]
let g:auto_organize_import_ft = [ ]
let g:coc_snippet_next        = '<tab>'
let g:coc_global_extensions   = [
  \ "coc-syntax"       ,
  \ "coc-snippets"     ,
  \ "coc-lists"        ,
  \ "coc-json"         ,
  \ "coc-rust-analyzer",
  \ "coc-clangd"       ,
  \ "coc-yank"         ,
  \ "coc-diagnostic"   ,
  \ ]

if utils#is_plug_loaded('fzf')
  let g:vista_default_executive = 'coc'
endif

" configure error color
hi! link CocErrorSign Error
hi CocUnderline gui=undercurl term=undercurl
hi CocErrorHighlight ctermfg=red  guifg=#c4384b gui=undercurl term=undercurl
hi CocWarningHighlight ctermfg=yellow guifg=#c4ab39 gui=undercurl term=undercurl

function! s:show_signature_help()
  if coc#rpc#ready()
    call CocActionAsync('showSignatureHelp')
  endif
endfunction

augroup coc_autocomplete
  au!

  " " coc-highlight: highlight word under cursor
  " au CursorHold * silent call CocActionAsync('highlight')

  " show signature in insert mode
  au CursorHoldI * silent call <sid>show_signature_help()

  " Update signature help on jump placeholder.
  au User CocJumpPlaceholder silent call <sid>show_signature_help()

  " Format prior to save
  exe "au BufWritePre *.{" . join(g:auto_format_ft, ",") . "} silent! call CocAction('format')"

  " Organise imports prior to save
  exe "au BufWritePre *.{" . join(g:auto_organize_import_ft, ",") . "} silent! call CocAction('runCommand', 'editor.action.organizeImport')"

  " close the preview window when completion is done.
  au CompleteDone * if pumvisible() == 0 | silent! pclose | endif
augroup END

function! s:show_documentation()
 if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Use K to show documentation in preview window.
nnoremap <silent> K :call <sid>show_documentation()<cr>

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:tab_complete() abort
  if coc#pum#visible()
    return coc#pum#next(1)
  endif

  if coc#expandableOrJumpable()
    return "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>"
  endif

  return s:check_back_space() ? "\<tab>" : coc#refresh()
endfunction

" completes tab completion on insert mode
" on selection, completions are expanded if snippet
" if no completion selected: auto completes the first item on list
" otherwise: selects the selected completion

inoremap <silent> <expr>   <TAB> <sid>tab_complete()
inoremap <silent> <expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<s-tab>"
inoremap <silent> <expr>    <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" inoremap <silent> <expr>   <ESC> pumvisible() ? "\<c-e>" : "\<esc>"

" use ctrl+space to trigger completion
if has('nvim')
  inoremap <silent> <expr> <c-space> coc#refresh()
else
  inoremap <silent> <expr>     <c-@> coc#refresh()
endif


" Use `[e` and `]e` to navigate diagnostics
nmap    <silent> [e <Plug>(coc-diagnostic-prev)
nmap    <silent> ]e <Plug>(coc-diagnostic-next)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

nmap    <silent> gd <Plug>(coc-definition)
nmap    <silent> gy <Plug>(coc-type-definition)
nmap    <silent> gi <Plug>(coc-implementation)
nmap    <silent> gr <Plug>(coc-references)
nmap    <silent> gR <Plug>(coc-rename)

" Map function and class text objects
xmap    <silent> if <Plug>(coc-funcobj-i)
xmap    <silent> af <Plug>(coc-funcobj-a)
omap    <silent> if <Plug>(coc-funcobj-i)
omap    <silent> af <Plug>(coc-funcobj-a)
xmap    <silent> ic <Plug>(coc-classobj-i)
xmap    <silent> ac <Plug>(coc-classobj-a)
omap    <silent> ic <Plug>(coc-classobj-i)
omap    <silent> ac <Plug>(coc-classobj-a)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" vim: sw=2 sts=2 tw=0 fdm=marker
