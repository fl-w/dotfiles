" which-key.vim configuration and keybinds
"

call which_key#register('<Space>', "g:which_key_map")

" map leader to which key
nnoremap <silent> <leader>  :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader>  :<c-u>WhichKeyVisual '<Space>'<CR>

let g:which_key_use_floating_win = 1
let g:which_key_map =  {}
let s:key_sep = '//'

" Map <leader> + e to open fuzzy find (FZF) " 
nnoremap <silent> <leader>e :call fzf#vim#files('.', {'options': '--prompt " "'})<CR>

" Map <leader> + E to open buffers in fzf
nnoremap <silent> <leader>E :Buffers<CR>

" map <leader> + t to toggle tags bar
nmap <silent><leader>t           :TagbarOpenAutoClose<cr>

" Map <ctrl> + F to search open buffers in fzf
nnoremap <silent> <C-F> :FZFLines<CR>

" Single mappings
let g:which_key_map['/'] = [ '<Plug>NERDCommenterToggle'  , 'toggle comment' ]
let g:which_key_map[' '] = [ ':update'                    , 'write file if modified' ]
let g:which_key_map[';'] = [ ':Commands'                  , 'commands' ]
let g:which_key_map['='] = [ '<C-W>='                     , 'balance windows' ]
let g:which_key_map[','] = [ ':Dashboard'                 , 'start screen' ]
let g:which_key_map['d'] = [ ':WintabsClose'              , 'delete buffer']
let g:which_key_map['q'] = [ ':q'                         , 'close window']
let g:which_key_map['f'] = [ ':Drawer'                    , 'toggle file drawer' ]
let g:which_key_map['e'] = [ ':Files'                     , 'search files' ]
let g:which_key_map['h'] = [ '<C-W>s'                     , 'split below']
let g:which_key_map['q'] = [ 'q'                          , 'quit' ]
let g:which_key_map['S'] = [ ':SessionSave'               , 'save session' ]
let g:which_key_map['F'] = [ ':Rg'                        , 'search text' ]
let g:which_key_map['v'] = [ '<C-W>v'                     , 'split right']
let g:which_key_map['z'] = [ 'Goyo'                       , 'zen' ]


" . is for vimrc
let g:which_key_map['.'] = {
      \ '.': [ ':e $MYVIMRC',              'open vimrc' ],
      \ 'p': [ ':e $VIM_ROOT/plugins.vim', 'open plugins' ],
      \ 'g': [ ':e $VIM_ROOT/general.vim', 'open general conf' ],
      \ 'r': [ ':so $MYVIMRC',             'reload source'],
      \ ';': [ ':so %',                    'source current file'],
      \}

" b is for buffer
let g:which_key_map.b = {
      \ 'name' : s:key_sep . 'buffer',
      \ 'n' : [':WintabsNext', 'next'],
      \ 'p' : [':WintabsPrevious', 'previous'],
      \ }

" c is for comment
let g:which_key_map.c = {
      \ 'name' : s:key_sep . 'comment'
      \ }

" g is for git
let g:which_key_map.g = {
      \ 'name': s:key_sep . 'git',
      \ 'v': [':Gmove', 'git move wrapper'],
      \ 'b': [':Gblame', 'git blame wrapper'],
      \ 'g':  [':Ggrep', 'git grep wrapper'],
      \ 'm': [':Gmerge', 'git merge wrapper'],
      \ 'r': [':Grebase', 'git rebase wrapper'],
      \ 'p': [':Gpush', 'git push wrapper'],
      \ 'f': [':Gfetch', 'git fetch wrapper'],
      \ 'u': [':Gpull', 'git pull wrapper'],
      \ 's': [':Gstatus', 'git status']
      \}

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
      \ 'z' : [':CocDisable'                         , 'disable CoC'],
      \ 'Z' : [':CocEnable'                          , 'enable CoC'],
      \ }

" w is for window
let g:which_key_map.w = {
      \ 'name' : '+windows' ,
      \ 'w' : ['<C-W>w'     , 'other-window']          ,
      \ 'd' : ['<C-W>c'     , 'delete-window']         ,
      \ '-' : ['<C-W>s'     , 'split-window-below']    ,
      \ '|' : ['<C-W>v'     , 'split-window-right']    ,
      \ '2' : ['<C-W>v'     , 'layout-double-columns'] ,
      \ 'h' : ['<C-W>h'     , 'window-left']           ,
      \ 'j' : ['<C-W>j'     , 'window-below']          ,
      \ 'l' : ['<C-W>l'     , 'window-right']          ,
      \ 'k' : ['<C-W>k'     , 'window-up']             ,
      \ 'H' : ['<C-W>5<'    , 'expand-window-left']    ,
      \ 'J' : [':resize +5'  , 'expand-window-below']   ,
      \ 'L' : ['<C-W>5>'    , 'expand-window-right']   ,
      \ 'K' : [':resize -5'  , 'expand-window-up']      ,
      \ '=' : ['<C-W>='     , 'balance-window']        ,
      \ 's' : ['<C-W>s'     , 'split-window-below']    ,
      \ 'v' : ['<C-W>v'     , 'split-window-below']    ,
      \ '?' : ['Windows'    , 'fzf-window']            ,
      \ }

""" vim-easy-align
xmap <leader>a                  <Plug>(EasyAlign)
nmap <leader>a                  <Plug>(EasyAlign)

""" vim-smoothie
" silent! nmap <unique> <S-j>      <Plug>(SmoothieDownwards)
" silent! nmap <unique> <S-k>      <Plug>(SmoothieUpwards)
