" Move lines up(-) or down(_)
noremap - ddp
noremap _ ddkP
noremap <C-S-Up> ddp
noremap <C-S-Down> ddkP

" Write file as sudo
cnoremap w!! w !sudo tee > /dev/null %

" Two semicolons to leave insert mode
imap ;; <Esc>

 " Clear highlight by pressing esc
nnoremap <esc> :noh<return><esc>

" Use (Ctrl/Alt)+H,J,K,L to navigate (panes/tabs)
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <M-h> <C-w>h
noremap <M-j> <C-w>j
noremap <M-k> <C-w>k
noremap <M-l> <C-w>l
noremap <M-Left> :tabp<cr>
noremap <M-Up> :tabfirst<cr>
noremap <M-Down> :tablast<cr>
noremap <M-Right> :tabn<cr>

" Get off my lawn
" TODO: uncomment (wayyy to annoying 19.12.19)
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Map Ctrl + p to open fuzzy find (FZF)
nnoremap <c-p> :Files<cr>

" Map Ctrl + s to save file
noremap <c-s> <esc>:w!<cr>

" Map Ctrl + / to toggle line comments
noremap <c-/> :<Plug>CommentorLine

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ Check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Map <leader> + f to toggle nerd tree
noremap <silent> <leader>f :NERDTreeToggleVCS<cr>

" Map <leader> + z to toggle zen mode
noremap <silent> <leader>z :Goyo<cr>


""" COC completion

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>


""" IncSearch
noremap <silent><expr> <Space>/ incsearch#go(Config_easyfuzzymotion())
map / <Plug>(incsearch-easymotion-/)
map ? <Plug>(incsearch-easymotion-?)
map g/ <Plug>(incsearch-easymotion-stay)


""" EasyMotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-overwin-s)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-s2)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
