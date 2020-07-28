" vim:set sw=2:
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

if &history < 1000
  " increase max items in history
  set history=1000
endif

if &timeoutlen > 1000
  " timeout length for mapped sequence (default: 1000)
  timeoutlen=275
endif

set list listchars=tab:│\ ,nbsp:+,extends:»,precedes:« | " display hidden chars

" set ff=unix
set title                                      | " change the terminal title
set autoread                                   | " auto reload unmodified files changed outside vim
set shortmess=a                                | " skip 'press enter to continue' prompt
set number                                     | " show line number
set smarttab                                   | " indents according to shiftwidth on tab
set relativenumber                             | " show relative line number
set lazyredraw                                 | " don't redraw when executing macros, smoother experience
set clipboard+=unnamedplus                     | " use system clipboard
set smartcase                                  | " unless uppercase explicitly mentioned
set cursorline                                 | " Highlight the current line
set nostartofline                              | " jump to first character in line
set smartindent                                | " indent smartly
set autoindent                                 | " enable auto indentation
set mouse=a                                    | " enable mouse support in all modes
set hidden                                     | " allow unsaved buffers to be hidden
set visualbell noerrorbells                    | " disable visual and errorbells
set updatetime=180                             | " set cursor hold timeout
set noshowmode                                 | " hide mode (lightline shows mode)
set inccommand=nosplit                         | " show result of substitution in real time
set wildmenu                                   | " better command line completion
set wildmode=list:full                         | " Autocomplete
set showmatch                                  | " highlight matching braces
set hlsearch                                   | " Highlight search
set splitright                                 | " open vsp on right and bottom
set splitbelow                                 | " » which feels more natural
set nobackup                                   | " disable backups
set backspace=indent,eol,start                 | " allow backspacing thru anything
set nowritebackup                              | " disable writing backup file
set nowrap                                     | " Don't wrap text
set laststatus=2                               | " always show statusbar
set scrolloff=5                                | " Minimum space on bottom/top of window
set sidescrolloff=7                            | " Minimum space on side
set showtabline=1                              | " show tabline only if there is at least 1 tab
" set shortmess+=a                               | " don't give \|ins-completion-menu\| messages.
set tabstop=4                                  | " make tab 4 spaces
set shiftwidth=4                               | " use 4 spaces for indentation.
set expandtab                                  | " use spaces instead of tabs. (spaces > tab)
set cmdheight=2                                | " better display for messages
set pumheight=10                               | " set the maximum numer of items to show in a popup menu
set completeopt=noinsert,menu,preview,menuone  | " set completion opts
set nofoldenable                               | " disable folding by default
set incsearch                                  | " show search whilst typing pattern
set fillchars+=vert:\                          | " disable verticle split lines
" set cc=80                                      | " show linecolumn
" set autochdir                                  | " change working directory to open file

" ignore files when globbing
set wildignore=*.o,*.obj,*~                    | " ignore object files
set wildignore-=.*                             | " don't ignore hidden files

" Undo settings
set undofile
set undodir=~/.config/nvim/vim-undo
set undolevels=1000  "max number of changes that can be undone
set undoreload=10000 "max number lines to save for undo on buffer reload

" fold settings
set foldmethod=marker
set foldnestmax=3
set foldminlines=15
