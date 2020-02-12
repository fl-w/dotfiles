let mapleader="\<Space>"

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
noremap <C-h>   <C-w>h
noremap <C-j>   <C-w>j
noremap <C-k>   <C-w>k
noremap <C-l>   <C-w>l
noremap <M-h>   <C-w>h
noremap <M-j>   <C-w>j
noremap <M-k>   <C-w>k
noremap <M-l>   <C-w>l

" Map Shif+j,k to scroll down/up
noremap <S-j>   <C-e>
noremap <S-k>   <C-y>

" Use Alt+h,j,k,l to navigate tabs
noremap <M-h>   :tabp<cr>
noremap <M-k>   :tabfirst<cr>
noremap <M-j>   :tablast<cr>
noremap <M-l>   :tabn<cr>

command! -nargs=1 -range TabFirst exec <line1> . ',' . <line2> . 'Tabularize /^[^' . escape(<q-args>, '\^$.[?*~') . ']*\zs' . escape(<q-args>, '\^$.[?*~')

" Get off my lawn
"nnoremap <Left> :echoe "Use h"<CR>
"nnoremap <Right> :echoe "Use l"<CR>
nnoremap <silent><Left> :bprev<CR>
nnoremap <silent><Right> :bnext<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Map Ctrl + p to open fuzzy find (FZF)
nnoremap <c-p>                   :Files<cr>

" map <leader> + w to save file
noremap <silent><leader>w        <esc>:w!<cr>

" map <leader> + q to quit file
noremap <silent><leader>q        <esc>:q!<cr>

" map <leader><leader> to save and quit file
noremap <silent><leader><leader> :wq!<cr>

" map <leader> + . to toggle tags bar
nmap <silent><leader>            :TagbarToggle<cr>

" Map <leader> + f to toggle nerd tree
noremap <silent><leader>f        :NERDTreeToggleVCS<cr>

" Map <leader> + z to toggle zen mode
noremap <silent><leader>z        :Goyo<cr>

" Map <leader> + h to toggle keyword hl
noremap <silent><leader>h        :VimCurrentWordToggle<cr>


"
" Plugin specific mappings
"

""" vim-easy-align
xmap <leader>a                  <Plug>(EasyAlign)
nmap <leader>a                  <Plug>(EasyAlign)


""" IncSearch
noremap <silent><expr> <Space>/ incsearch#go(Config_easyfuzzymotion())
map /                           <Plug>(incsearch-easymotion-/)
map ?                           <Plug>(incsearch-easymotion-?)
map g/                          <Plug>(incsearch-easymotion-stay)


""" EasyMotion
" `s{char}{label}`
nmap s                          <Plug>(easymotion-overwin-s)
" or
" `s{char}{char}{label}`
nmap <leader>s                  <Plug>(easymotion-s2)

" JK motions: Line motions
map <leader>j                   <Plug>(easymotion-j)
map <leader>k                   <Plug>(easymotion-k)
