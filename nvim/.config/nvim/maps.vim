" Move lines up(-) or down(_)
noremap - ddp
noremap _ ddkP
noremap <C-S-Up> ddp
noremap <C-S-Down> ddkP

" Write file as sudo
cnoremap w!! w !sudo tee > /dev/null %

" Two semicolons to leave insert mode
imap ;; <Esc>

" Swap J & K
" noremap j k
" " noremap k j

 " Cliear highlight by pressing esc
nnoremap <esc> :noh<return><esc>

" Use (Ctrl/Alt)+H,J,K,L to navigate panes
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <M-h> <C-w>h
noremap <M-j> <C-w>j
noremap <M-k> <C-w>k
noremap <M-l> <C-w>l
noremap <M-Left> <C-w>h
noremap <M-Up> <C-w>j
noremap <M-Down> <C-w>k
noremap <M-Right> <C-w>l

" Get off my lawn
" TODO: uncomment (wayyy to annoying 19.12.19)
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Map Ctrl + p to open fuzzy find (FZF)
nnoremap <c-p> :Files<cr>

" Map Ctrl + s to save file
noremap <c-s> ;;:w!<cr>

" Map Ctrl + (e/f) to toggle nerd tree
noremap <c-e> :NERDTreeToggle<cr>
noremap <c-f> :NERDTreeToggle<cr>

" Map Ctrl + / to toggle line comments
noremap <c-/> :<Plug>CommentorLine

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n>
