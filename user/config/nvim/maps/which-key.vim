" which-key.vim configuration and keybinds
"

call which_key#register('<Space>', 'g:which_key_map')

" map leader to which key
nnoremap <silent> <leader>  :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader>  :<c-u>WhichKeyVisual '<Space>'<CR>

let g:which_key_use_floating_win = 1
let g:which_key_map =  {}

" Single mappings
let g:which_key_map[' '] = [ ':update',              'write file if modified' ]
let g:which_key_map[','] = [ '`.',                   'goto last change location' ]
let g:which_key_map[';'] = [ ':Dashboard',           'start screen' ]
let g:which_key_map['c'] = [ '<Plug>CommentaryLine', 'toggle comment' ]
let g:which_key_map['='] = [ '<C-W>=',               'balance windows' ]
let g:which_key_map['Q'] = [ ':quit',                'close window' ]
let g:which_key_map['q'] = [ ':WintabsClose',        'close buffer' ]
let g:which_key_map['d'] = [ ':Drawer',              'toggle file drawer' ]
let g:which_key_map['e'] = [ ':Files',               'edit files' ]
let g:which_key_map['E'] = [ ':GFiles',              'edit project files' ]
let g:which_key_map['S'] = [ ':SessionSave',         'save session' ]
let g:which_key_map['v'] = [ ':Vista!!',             'toggle tags window' ]
let g:which_key_map['z'] = [ ':Goyo',                'zen' ]

" remove previous mappings
for k in keys(g:which_key_map)
      let key = substitute(k, ' ', '<leader>', '')
      if !empty(maparg('<leader>' . key, 'n'))
            " echom 'unmapping: <leader>'. key
            exe 'nunmap <leader>' . (key == ' ' ? '<leader>' : key)
      endif
endfor

" . is for vimrc
let g:which_key_map['.'] = {
      \ 'name': '+config',
      \ '.': [ ':if &ft=="vim" | so % | :echo "vim: sourced ".bufname("%") | else | so $MYVIMRC | endif',
            \ 'source current file or reload vimrc' ],
      \ 'p': [ ':e $VIM_ROOT/plugins.vim',             'open plugins' ],
      \ 'g': [ ':e $VIM_ROOT/general.vim',             'open general conf' ],
      \ 's': [ ':e $VIM_ROOT/conf.d/statusline.vim',   'open statusline conf' ],
      \ 'c': [ ':e $VIM_ROOT/conf.d/colorscheme.vim',  'open colorscheme conf' ],
      \ 't': [ ':e $VIM_ROOT/conf.d/terminal.vim',     'open terminal conf' ],
      \ 'r': [ ':so %',                                'reload vimrc' ],
      \}

" b is for buffer
let g:which_key_map.b = {
      \ 'name' : '+buffer',
      \ 'n' : [':WintabsNext', 'next'],
      \ 'p' : [':WintabsPrevious', 'previous'],
      \ 'd' : [':WintabsClose', 'previous'],
      \ }

" f is for fzf/find
let g:which_key_map.f = {
      \ 'name': '+find',
      \ 't': [':Rg',       'find text'],
      \ 'f': [':Files',    'find files'],
      \ 'b': [':Buffers',  'find buffers'],
      \ 'c': [':Colors',   'find colors'],
      \ 'C': [':Commands', 'find commands'],
      \ 'h': [':Helptags', 'find help'],
      \ 'o': [':normal go', 'find tags in file'],
      \ '/': [':History',  'find history'],
      \ }

" g is for git
let g:which_key_map.g = {
      \ 'name': '+git',
      \ 'v': [':Gmove',   'git move wrapper'],
      \ 'b': [':Gblame',  'git blame wrapper'],
      \ 'g': [':Ggrep',   'git grep wrapper'],
      \ 'm': [':Gmerge',  'git merge wrapper'],
      \ 'r': [':Grebase', 'git rebase wrapper'],
      \ 'p': [':Gpush',   'git push wrapper'],
      \ 'f': [':Gfetch',  'git fetch wrapper'],
      \ 'u': [':Gpull',   'git pull wrapper'],
      \ 's': [':Gstatus', 'git status']
      \}

" l is for language server protocol
let g:which_key_map.l = {
      \ 'name' : '+lsp',
      \ '.' : [':CocConfig',                        'config'],
      \ ';' : ['<Plug>(coc-refactor)',              'refactor'],
      \ 'a' : [':CocCommand actions.open',          'line action'],
      \ 'b' : [':CocNext',                          'next action'],
      \ 'B' : [':CocPrev',                          'prev action'],
      \ 'c' : [':CocList commands',                 'commands'],
      \ 'd' : ['<Plug>(coc-definition)',            'definition'],
      \ 'e' : [':CocList extensions',               'extensions'],
      \ 'f' : ['<Plug>(coc-format)',                'format'],
      \ 'F' : ['<Plug>(coc-format-selected)',       'format selected'],
      \ 'h' : ['<Plug>(coc-float-hide)',            'hide'],
      \ 'i' : ['<Plug>(coc-implementation)',        'implementation'],
      \ 'I' : [':CocList diagnostics',              'diagnostics'],
      \ 'j' : ['<Plug>(coc-float-jump)',            'float jump'],
      \ 'l' : ['<Plug>(coc-codelens-action)',       'code lens'],
      \ 'n' : ['<Plug>(coc-diagnostic-next)',       'next diagnostic'],
      \ 'N' : ['<Plug>(coc-diagnostic-next-error)', 'next error'],
      \ 'o' : ['<Plug>(coc-openlink)',              'open link'],
      \ 'O' : [':CocList outline',                  'outline'],
      \ 'p' : ['<Plug>(coc-diagnostic-prev)',       'prev diagnostic'],
      \ 'P' : ['<Plug>(coc-diagnostic-prev-error)', 'prev error'],
      \ 'q' : ['<Plug>(coc-fix-current)',           'quickfix'],
      \ 'r' : ['<Plug>(coc-rename)',                'rename'],
      \ 'R' : ['<Plug>(coc-references)',            'references'],
      \ 's' : [':CocList -I symbols',               'references'],
      \ 'S' : [':CocList snippets',                 'snippets'],
      \ 't' : ['<Plug>(coc-type-definition)',       'type definition'],
      \ 'u' : [':CocListResume',                    'resume list'],
      \ 'U' : [':CocUpdate',                        'update CoC'],
      \ 'z' : [':CocDisable',                       'disable CoC'],
      \ 'Z' : [':CocEnable',                        'enable CoC'],
      \ }

" t is for terminal
let g:which_key_map.t = {
      \ 'name': '+terminal',
      \ 't':    'toggle terminal',
      \ 'o':    'open terminal',
      \ 'c':    'close terminal',
      \ 'e':    'exec input in terminal',
      \ }

" w is for window
let g:which_key_map.w = {
      \ 'name' : '+windows',
      \ 'w' : ['<C-W>w',     'other-window']          ,
      \ 'd' : ['<C-W>c',     'delete-window']         ,
      \ '-' : ['<C-W>s',     'split-window-below']    ,
      \ '|' : ['<C-W>v',     'split-window-right']    ,
      \ '2' : ['<C-W>v',     'layout-double-columns'] ,
      \ 'h' : ['<C-W>h',     'window-left']           ,
      \ 'j' : ['<C-W>j',     'window-below']          ,
      \ 'l' : ['<C-W>l',     'window-right']          ,
      \ 'k' : ['<C-W>k',     'window-up']             ,
      \ 'H' : ['<C-W>5<',    'expand-window-left']    ,
      \ 'J' : [':resize +5', 'expand-window-below']   ,
      \ 'L' : ['<C-W>5>',    'expand-window-right']   ,
      \ 'K' : [':resize -5', 'expand-window-up']      ,
      \ '=' : ['<C-W>=',     'balance-window']        ,
      \ 's' : ['<C-W>s',     'split-window-below']    ,
      \ 'v' : ['<C-W>v',     'split-window-below']    ,
      \ '?' : ['Windows',    'fzf-window']            ,
      \ }

""" vim-smoothie
" silent! nmap <unique> <S-j>      <Plug>(SmoothieDownwards)
" silent! nmap <unique> <S-k>      <Plug>(SmoothieUpwards)
