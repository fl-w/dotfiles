" List all plugins here.
"

" Install VimPlug if not present
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" Plugin List
call plug#begin()

  "
  " Visuals
  "
  Plug 'drewtempelmeyer/palenight.vim'     " Fantastic colors
  Plug 'nightsense/cosmic_latte'           " Theme that's easy on the eyes
  Plug 'kjssad/quantum.vim'                " A modern colorscheme inspired by firefox
  Plug 'rakr/vim-one'                      " one-dark colorscheme for vim


  Plug 'sheerun/vim-polyglot'              " Mega language support pack

  Plug 'dominikduda/vim_current_word'      " Highlighting word under cursor
  Plug 'junegunn/goyo.vim'                 " Distraction-free writing in Vim
  " Plug 'godlygeek/tabular' |
  " Plug 'godlygeek/vim-markdown'       " Syntax highlighting for markdown (depends: tabular)
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

  Plug 'scrooloose/nerdtree'               " File tree view
  Plug 'Xuyuanp/nerdtree-git-plugin'       " Git indicators for nerdtree.
  Plug 'airblade/vim-gitgutter'            " Git gutter

  Plug 'ryanoasis/vim-devicons'            " Add file icons to vim plugins
  Plug 'kshenoy/vim-signature'             " Visualise and navigate marks

  " Syntax check
  "
  Plug 'dense-analysis/ale'                " Async Lint Engine
  Plug 'tpope/vim-sensible'                " Some sensible settings

  Plug 'itchyny/lightline.vim'             " Awesome status bar
  Plug 'maximbaz/lightline-ale'            " ALE indicator for lightline
  Plug 'mengelbrecht/lightline-bufferline' " A buffer plugin for lightline

  Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

  Plug 'Shougo/echodoc'                     " Displays function signatures from completions
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'deoplete-plugins/deoplete-jedi'    " Deoplete source for python
  " Plug 'ternjs/tern_for_vim'               " Deoplete source for js
  Plug 'artur-shaik/vim-Javacomplete2'     " Deoplete source for java
  Plug 'HerringtonDarkholme/yats.vim'      " Syntax highlighting for ts
  Plug 'leafgarland/typescript-vim'

  Plug 'haya14busa/incsearch.vim'          " Incremental searching
  Plug 'haya14busa/incsearch-fuzzy.vim'
  Plug 'haya14busa/incsearch-easymotion.vim'

  "
  " Tools
  "
  Plug 'majutsushi/tagbar'                 " Display tags in a window by scope.
  Plug 'tpope/vim-sleuth'                  " Autodetect file spacing
  Plug 'scrooloose/nerdcommenter'          " Awesome Commenting
  Plug 'jiangmiao/auto-pairs'     " Add brackets automatically
  Plug 'vim-scripts/autoswap.vim'          " Handle swap files intelligently
  Plug 'tpope/vim-fugitive'                " Git wrapper
  Plug 'junegunn/vim-peekaboo'             " Show register contents on "/@

  Plug 'airblade/vim-rooter'               " Change working dir to project root

  Plug 'camspiers/animate.vim'             " A Vim Automatic Window Resizing Plugin
  Plug 'camspiers/lens.vim'

  Plug 'tpope/vim-eunuch'                  " Add unix commands to vim
  Plug 'tpope/vim-unimpaired'              " Bracket mappings
  Plug 'psliwka/vim-smoothie'
  Plug 'mhinz/vim-startify'

  Plug 'samoshkin/vim-mergetool'           " use vim as mergetool

  Plug 'vimwiki/vimwiki'                   " personal wiki tool for vim
  Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

  Plug 'junegunn/fzf', { 'dir': '~/.local/lib/fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  Plug 'editorconfig/editorconfig-vim'     " .editorconfig support
  Plug 'tpope/vim-surround'                " Change your surroundings
  Plug 'Yggdroot/indentLine'               " Indent guides

  Plug 'easymotion/vim-easymotion'         " Navigate files with ease
  Plug 'junegunn/vim-easy-align'           " Align things

  Plug 'SirVer/ultisnips'                  " Snippets engine
  Plug 'honza/vim-snippets'                " Snippets

call plug#end()
