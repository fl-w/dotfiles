" which-key.vim configuration and keybinds
"

" map leader to which key
nnoremap <silent> <leader>  :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader>  :<c-u>WhichKeyVisual '<Space>'<CR>

let s:key_sep = '//'
let g:which_key_sep = '→'
let g:which_key_map =  {}

" Map <leader> + e to open fuzzy find (FZF) " 
nnoremap <silent> <leader>e :call fzf#vim#files('.', {'options': '--prompt " "'})<CR>

" Map <leader> + E to open buffers in fzf
nnoremap <silent> <leader>E :Buffers<CR>

" map <leader> + t to toggle tags bar
nmap <silent><leader>t           :TagbarOpenAutoClose<cr>

" Map <leader> + f to toggle nerd tree
noremap <silent><leader>f        :CocCommand explorer<cr>

" Map <leader> + z to toggle zen mode
noremap <silent><leader>z        :Goyo<cr>

" Map <ctrl> + F to search open buffers in fzf
nnoremap <silent> <C-F> :FZFLines<CR>

" Single mappings
let g:which_key_map['/'] = [ '<Plug>NERDCommenterToggle'  , 'toggle comment' ]
let g:which_key_map['.'] = [ ':e $MYVIMRC'                , 'open vimrc' ]
let g:which_key_map[' '] = [ ':w!'                        , 'force write file' ]
let g:which_key_map['w'] = [ ':w'                         , 'write file' ]
let g:which_key_map[';'] = [ ':Commands'                  , 'commands' ]
let g:which_key_map['='] = [ '<C-W>='                     , 'balance windows' ]
let g:which_key_map[','] = [ 'Startify'                   , 'start screen' ]
let g:which_key_map['d'] = [ ':BD'                        , 'delete buffer']
let g:which_key_map['e'] = [ ':CocCommand explorer'       , 'explorer' ]
let g:which_key_map['f'] = [ ':Files'                     , 'search files' ]
let g:which_key_map['h'] = [ '<C-W>s'                     , 'split below']
let g:which_key_map['q'] = [ 'q'                          , 'quit' ]
let g:which_key_map['r'] = [ ':RnvimrToggle'              , 'ranger' ]
let g:which_key_map['S'] = [ ':SSave'                     , 'save session' ]
let g:which_key_map['F'] = [ ':Rg'                        , 'search text' ]
let g:which_key_map['v'] = [ '<C-W>v'                     , 'split right']
let g:which_key_map['z'] = [ 'Goyo'                       , 'zen' ]


" b is for buffer
let g:which_key_map.b = {
      \ 'name' : s:key_sep . 'buffer'
      \ }

" l is for language server protocol
let g:which_key_map.l = {
      \ 'name' : '>lsp' ,
      \ '.' : [':CocConfig'                          , 'config'],
      \ ';' : ['<Plug>(coc-refactor)'                , 'refactor'],
      \ 'a' : ['<Plug>(coc-codeaction)'              , 'line action'],
      \ 'A' : ['<Plug>(coc-codeaction-selected)'     , 'selected action'],
      \ 'b' : [':CocNext'                            , 'next action'],
      \ 'B' : [':CocPrev'                            , 'prev action'],
      \ 'c' : [':CocList commands'                   , 'commands'],
      \ 'd' : ['<Plug>(coc-definition)'              , 'definition'],
      \ 'D' : ['<Plug>(coc-declaration)'             , 'declaration'],
      \ 'e' : [':CocList extensions'                 , 'extensions'],
      \ 'f' : ['<Plug>(coc-format-selected)'         , 'format selected'],
      \ 'F' : ['<Plug>(coc-format)'                  , 'format'],
      \ 'h' : ['<Plug>(coc-float-hide)'              , 'hide'],
      \ 'i' : ['<Plug>(coc-implementation)'          , 'implementation'],
      \ 'I' : [':CocList diagnostics'                , 'diagnostics'],
      \ 'j' : ['<Plug>(coc-float-jump)'              , 'float jump'],
      \ 'l' : ['<Plug>(coc-codelens-action)'         , 'code lens'],
      \ 'n' : ['<Plug>(coc-diagnostic-next)'         , 'next diagnostic'],
      \ 'N' : ['<Plug>(coc-diagnostic-next-error)'   , 'next error'],
      \ 'o' : ['<Plug>(coc-openlink)'                , 'open link'],
      \ 'O' : [':CocList outline'                    , 'outline'],
      \ 'p' : ['<Plug>(coc-diagnostic-prev)'         , 'prev diagnostic'],
      \ 'P' : ['<Plug>(coc-diagnostic-prev-error)'   , 'prev error'],
      \ 'q' : ['<Plug>(coc-fix-current)'             , 'quickfix'],
      \ 'r' : ['<Plug>(coc-rename)'                  , 'rename'],
      \ 'R' : ['<Plug>(coc-references)'              , 'references'],
      \ 's' : [':CocList -I symbols'                 , 'references'],
      \ 'S' : [':CocList snippets'                   , 'snippets'],
      \ 't' : ['<Plug>(coc-type-definition)'         , 'type definition'],
      \ 'u' : [':CocListResume'                      , 'resume list'],
      \ 'U' : [':CocUpdate'                          , 'update CoC'],
      \ 'v' : [':Vista!!'                            , 'tag viewer'],
      \ 'z' : [':CocDisable'                         , 'disable CoC'],
      \ 'Z' : [':CocEnable'                          , 'enable CoC'],
      \ }

" " Hide statusline
" autocmd! FileType which_key
" autocmd  FileType which_key set laststatus=0 noshowmode noruler
"   \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
"

" Plugin specific mappings
"

" rename symbol
nmap <leader>rn <Plug>(coc-rename)

""" vim-easy-align
xmap <leader>a                  <Plug>(EasyAlign)
nmap <leader>a                  <Plug>(EasyAlign)

""" vim-smoothie
" silent! nmap <unique> <S-j>      <Plug>(SmoothieDownwards)
" silent! nmap <unique> <S-k>      <Plug>(SmoothieUpwards)

""" IncSearch
noremap <silent><expr> <Space>/ incsearch#go(Easyfuzzymotion())
map /                           <Plug>(incsearch-easymotion-/)
" map ?                           <Plug>(incsearch-easymotion-?)
map g/                          <Plug>(incsearch-easymotion-stay)


""" EasyMotion
" `s{char}{char}{label}`
nmap s                  <Plug>(easymotion-s2)

" JK motions: Line motions
map <leader>j                   <Plug>(easymotion-j)
map <leader>k                   <Plug>(easymotion-k)

" markdown
augroup MD_SCR
autocmd FileType md,markdown noremap s :call InsertMarkdownScreenShot()<CR>
augroup END

" vim-fugative
"
noremap <leader>gm  :Gmove<cr>
noremap <leader>gb  :Gblame<cr>
noremap <leader>gg  :Ggrep<cr>
noremap <leader>gc  :Gcommit<cr>
noremap <leader>gm  :Gmerge<cr>
noremap <leader>gr  :Grebase<cr>
noremap <leader>gp  :Gpush<cr>
noremap <leader>gf  :Gfetch<cr>
noremap <leader>gu  :Gpull<cr>
noremap <leader>gs  :Gstatus<cr>
