" General configuration
"

" Use :help 'option' to see the documentation for the given option.

if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

if &shell =~# 'fish$' && (v:version < 704 || v:version == 704 && !has('patch276'))
  set shell=/usr/bin/env\ bash
endif

if exists('g:started_by_firenvim') && g:started_by_firenvim || exists('g:vscode')
  finish
endif

if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
    set grepformat=%f:%l:%c:%m
endif

set list listchars=tab:│\ ,nbsp:+,extends:»,precedes:« | " display hidden chars

set title                                      | " change the terminal title
set autoread                                   | " auto reload unmodified files changed outside vim
set hidden                                     | " allow unsaved buffers to be hidden
set switchbuf=                                 | " always switch buffer instead of opening new one
set number relativenumber                      | " show relative line number
set lazyredraw                                 | " don't redraw when executing macros, smoother experience
set clipboard+=unnamedplus                     | " use system clipboard
set smartcase                                  | " unless uppercase explicitly mentioned
set cursorline                                 | " Highlight the current line
set nostartofline                              | " jump to first character in line
set history=1000                               | " increase max items in history
set timeout ttimeout timeoutlen=480            | " timeout length for mapped sequence (default: 1000)
set history=1000                               | " increase max items in history
set smartindent                                | " indent smartly
set autoindent                                 | " enable auto indentation
set copyindent                                 | " copy struct of lines indent when autoindenting
set mouse=a                                    | " enable mouse support in all modes
set visualbell noerrorbells                    | " disable visual and errorbells
set updatetime=180                             | " set cursor hold timeout
set noshowmode                                 | " hide mode (lightline shows mode)
set splitright                                 | " open vsp on right and bottom
set splitbelow                                 | " » which feels more natural
set previewheight=38                           | " set height for preview window (default: 12)
set inccommand=nosplit                         | " show result of substitution in real time
set wildmenu                                   | " better command line completion
set wildmode=list:full                         | " Autocomplete
set wildoptions=tagfile                        | " Improve completions in command line
set showmatch                                  | " highlight matching braces
set incsearch                                  | " show search whilst typing pattern
set hlsearch                                   | " Highlight search
set emoji                                      | " use full width in unicode characters
set ambiwidth=single                           | " use single width for ambiguous characters
set nobackup                                   | " disable backups
set backspace=indent,eol,start                 | " allow backspacing thru anything
set nowritebackup                              | " disable writing backup file
set nowrap                                     | " Don't wrap text
set laststatus=2                               | " always show statusbar
set scrolloff=5                                | " Minimum space on bottom/top of window
set sidescrolloff=7                            | " Minimum space on side
set showtabline=1                              | " show tabline only if there is at least 1 tab
set shortmess+=c                               | " don't give \|ins-completion-menu\| messages.
set shortmess+=S                               | " don't show search count message.
set smarttab                                   | " indents according to shiftwidth on tab
set expandtab                                  | " use spaces instead of tabs. (spaces > tab)
set shiftround                                 | " make indent a multiple of shiftwidth
set tabstop=4                                  | " make tab 4 spaces
set softtabstop=-1                             | " make num of spaces tab count for same as shiftwidth
set shiftwidth=4                               | " use 4 spaces for indentation.
set cmdheight=2                                | " better display for messages
set pumheight=10                               | " set the maximum numer of items to show in a popup menu
set completeopt=noinsert,menu,preview,menuone  | " set completion opts
set foldcolumn=0                               | " don't show foldcolumn
set signcolumn=yes                             | " always show signcolumn
set nofoldenable                               | " disable folding by default
set fillchars+=vert:\                          | " disable verticle split lines
" set formatoptions&
" set formatoptions+=B                           | " don't insert space when joining lines
" set formatoptions+=j                           | " remove comment leader when joining lines
" set formatoptions+=n                           | " auto insert comment on new line
" set formatoptions+=m                           | " break long lines
" set formatoptions+=r                           | " auto insert comment on new line
" set cc=80                                      | " show linecolumn
" set autochdir                                  | " change working directory to open file
" ignore files when globbing
set wildignore=*.o,*.obj,*~                    | " ignore object files
set wildignore-=.*                             | " don't ignore hidden files

" Undo settings
set undofile
set undodir=~/.cache/nvim/undo
set undolevels=1000  "max number of changes that can be undone
set undoreload=10000 "max number lines to save for undo on buffer reload

" fold settings
set foldmethod=marker
set foldnestmax=3
set foldminlines=15

" vim: sw=2 sts=2 tw=0 fdm=marker
