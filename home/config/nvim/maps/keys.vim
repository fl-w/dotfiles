" keys.vim: Basic keymaps i can't live without
"

let mapleader = "\<Space>"

" Map ; -> : to speed up commands
nnoremap ; :

" Write file as sudo with w!!
cnoremap w!! w !sudo tee > /dev/null %

" Move lines up(_) or down(-)
noremap       - ddp
noremap       _ ddkP
vmap <silent> J :m '>+1<CR>gv=gv
vmap <silent> K :m '<-2<CR>gv=gv

" Move lines with alt + up or down
noremap <m-Up> ddkP
noremap <m-Down> ddp
vmap <silent> <m-Up> _
vmap <silent> <m-Down> -

" Make j/k really go down
nnoremap j gj
nnoremap k gk

" Yank to end of line
nnoremap Y y$

" Open vertial split
nnoremap <silent> \| :vnew<cr>
nnoremap <silent> \ :new<cr>

" Scroll with arrow keys
noremap <Down> <C-e>
noremap <Up>   <C-y>

" Clear highlight by pressing esc
nnoremap <silent> <esc>  :noh<return><esc>

" Use alt + hjkl to resize windows
nnoremap <silent> <M-j>    :resize +2<CR>
nnoremap <silent> <M-k>    :resize -2<CR>
nnoremap <silent> <M-h>    :vertical resize -2<CR>
nnoremap <silent> <M-l>    :vertical resize +2<CR>

" Force gf to open file under cursor
map <silent> gf :e <cfile><CR>

" Map double <leader> to save
noremap <silent> <leader><leader> :update!<cr>

" Map <leader> + x to save and exit file
noremap <silent> <leader>x  :x!<cr>

" Map <leader> + q to quit window
nmap <silent> <leader>q  :q!<cr>

" Map gd to goto word def
noremap gd  <S-K>

" Map {[/]}<space> to {prepend/append} blank line (inspired by tpope)
noremap <silent> ]<space>  :<c-u>pu =repeat(nr2char(10),v:count)<bar>execute "'[-1"<cr>
noremap <silent> [<space>  :<c-u>pu!=repeat(nr2char(10),v:count)<bar>execute "']+1"<cr>

" Map useful commands to [/]
nnoremap <silent> [l       :lprevious<cr>
nnoremap <silent> ]l       :lnext<cr>
nnoremap <silent> [t       :tabprevious<cr>
nnoremap <silent> ]t       :tabnext<cr>

" Map {,shift} + enter to insert blank line with ( ]/[ + space ) ^
nmap    <cr>   ]<space>
nmap    <s-cr> [<space>

" Use ctrl+{h,j,k,l} to navigate window panes
noremap  <c-h>   <c-w>h
noremap  <c-j>   <c-w>j
noremap  <c-k>   <c-w>k
noremap  <c-l>   <c-w>l
inoremap <c-h>   <c-w>h
inoremap <c-j>   <c-w>j
inoremap <c-k>   <c-w>k
inoremap <c-l>   <c-w>l
if exists(':tnoremap')
  tnoremap <c-h>   <c-\><c-n><c-w>h
  tnoremap <c-j>   <c-\><c-n><c-w>j
  tnoremap <c-k>   <c-\><c-n><c-w>k
  tnoremap <c-l>   <c-\><c-n><c-w>l
endif

" Use ctrl+p to replace word under cursor with clipboard text
noremap <c-p>   viw"0p
noremap <c-P>   vaW"0p

" Use {,shift}+tab to navigate tabs
" nnoremap <silent>   <tab> :tabnext<CR>
" nnoremap <silent> <s-tab> :tabprevious<CR>

" Use (left/right) to navigate buffers
" nnoremap <silent> <Right> :bnext<CR>
" nnoremap <silent> <Left>  :bprevious<CR>

" Navigate lines quickly
nnoremap L $
nnoremap H ^

" Keep visual mode after indent
vnoremap > >gv
vnoremap < <gv

" Paste in visual mode without losing clipboard content
vnoremap p "_dP

" Map Shif+j,k to highlight and scroll down/up
" noremap <expr> <s-k> mode() != visualmode() ? 'V' : 'k'
" noremap <expr> <s-j> mode() != visualmode() ? 'V' : 'j'

noremap <silent><leader>y "*y
noremap <silent><leader>p "*p
noremap <silent><leader>Y "+y
noremap <silent><leader>P "+y

" Map {jj/kk} -> {down/up} in insert mode
inoremap <nowait> kk <esc>k
inoremap <nowait> jj <esc>j

" Use ctrl+{j,k} to navigate omnifunc
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" vim: sw=2 sts=2 tw=0 fdm=marker
