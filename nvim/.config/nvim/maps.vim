let mapleader="\<Space>"

" Move lines up(-) or down(_)
noremap - ddp
noremap _ ddkP
noremap <C-Up> ddp
noremap <C-Down> ddkP

vnoremap p "_dP

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

" Map <leader> + e to open fuzzy find (FZF)
nnoremap <silent> <leader>e :call fzf#vim#files('.', {'options': '--prompt ""'})<CR>

" Map Ctrl + p to open buffers in fzf
nnoremap <silent> <leader>E :Buffers<CR>

" map <leader> + x to save and exit file
noremap <silent><leader>x        <esc>:x!<cr>

" map <leader> + q to quit file
noremap <silent><leader>q        <esc>:q!<cr>

" map <leader> + Q to quit buffer
noremap <silent><leader>Q        <esc>:q!<cr>

" map <leader><leader> to save
noremap <silent><leader><leader> :w!<cr>

" map <leader> + b to toggle tags bar
nmap <silent><leader>b           :TagbarOpenAutoClose<cr>

" Map <leader> + f to toggle nerd tree
noremap <silent><leader>f        :NERDTreeToggleVCS<cr>

" Map <leader> + z to toggle zen mode
noremap <silent><leader>z        :Goyo<cr>

" Map <leader> + h to toggle keyword hl
noremap <silent><leader>h        :VimCurrentWordToggle<cr>

noremap <silent><leader>y "*y
noremap <silent><leader>p "*p
noremap <silent><leader>Y "+y
noremap <silent><leader>P "+y

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
nnoremap s                          <Plug>(easymotion-overwin-s)
" or
" `s{char}{char}{label}`
nmap <leader>s                  <Plug>(easymotion-s2)

" JK motions: Line motions
map <leader>j                   <Plug>(easymotion-j)
map <leader>k                   <Plug>(easymotion-k)

" LanguageClient

function! SetLSPShortcuts()
  nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
  nnoremap K          :call LanguageClient#textDocument_definition()<CR>
  nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
  nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
  nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <c-p>      :call LanguageClient#textDocument_hover()<CR>
  nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
  nnoremap <leader><enter> :call LanguageClient#textDocument_codeAction()<CR>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType cpp,c,java,ts,py,typescript call SetLSPShortcuts()
augroup END
