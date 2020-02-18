source $HOME/.config/nvim/functions.vim
source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/plugins-config.vim
source $HOME/.config/nvim/maps.vim

"
" Colorscheme
"

" stop theme from setting bg color
autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
colorscheme palenight
highlight LineNr guibg=NONE gui=NONE

" set t_ut=
" let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
"
"Use 24-bit (true-color) mode in Vim/Neovim
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif


"
" General configuration
"

filetype plugin on
filetype plugin indent on

set termguicolors
set background=dark
set ff=unix
set encoding=UTF-8
set mouse=a
set hidden                      " if hidden is not set, TextEdit might fail.
set cursorline                  " Highlight the current line
set lazyredraw                  " Faster scrolling
set number                      " Show line number
set relativenumber              " Show relative line number
set showcmd                     " Show current command
set autoindent                  " Enable auto indentation
" set cc=140                      " Show linecolumn
set showmode                    " Show current mode
set autochdir                   " Change working directory to open file
set wildmode=longest:list,full  " Autocomplete
set wildignore=*.o,*.obj,*~     " Ignore file
set showmatch                   " highlight matching braces
set hlsearch                    " Highlight search
set ignorecase                  " ignore case while searching
set smartcase                   " unless uppercase explicitly mentioned
set smartindent                 " indent smartly
set nowrap                      " Don't wrap text
set laststatus=2                " Always show statusbar
set scrolloff=5                 " Minimum space on bottom/top of window
set sidescrolloff=7             " Minimum space on side
set sidescroll=1
set showtabline=2               " always show tabline
set shortmess+=c                " don't give \|ins-completion-menu\| messages.
set tabstop=2                   " 2 spaces
set shiftwidth=2                " 2 2 CHAINZ
set cmdheight=2                 " Better display for messages
set list                        " Display hidden chars as defined below
set listchars=tab:▷⋅,trail:⋅,nbsp:+,extends:»,precedes:«
set splitright                  " Open vsp on right and bottom
set splitbelow                  " which feels more natural
set pastetoggle=<F2>
set noshowmode                  " Hide mode (lightline shows mode)
set expandtab                   " Spaces > tabs
set nofoldenable                " Disable folding
set clipboard+=unnamedplus      " Use system clipboard
set completeopt+=noinsert,menu,longest,preview

""" Undo settings
set undodir=~/.config/nvim/vim-undo
set undofile
set undolevels=1000  "max number of changes that can be undone
set undoreload=10000 "max number lines to save for undo on buffer reload

" syntax sync minlines=256  " Makes big files slow
" set synmaxcol=2048        " Also long lines are slow

" Filetype specific settings
autocmd! filetype *commit*,markdown setlocal spell         " Spell Check
autocmd! filetype *commit*,markdown setlocal textwidth=72  " Looks good
autocmd! filetype make setlocal noexpandtab                " In Makefiles DO NOT use spaces instead of tabs
:autocmd BufRead,BufNewFile kitty.conf setf dosini       " Syntax highlighting for .conf
autocmd BufWritePre * call TrimWhitespace() " Remove trailing whitespace when saving
autocmd! BufReadPost * call SetCursorPosition()
augroup vimrc
    au!
    autocmd BufWritePost _vim,.vimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END
" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end

""" vim-current-word configuration
hi CurrentWord gui=bold guifg=Normal
hi CurrentWordTwins guibg=#2c323C guifg=#ffffff
