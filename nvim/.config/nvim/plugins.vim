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
  " Base
  "
  Plug 'tpope/vim-sensible'                | " Some sensible settings


  "
  " Visuals
  "
  Plug 'drewtempelmeyer/palenight.vim'     | " Fantastic colors
  Plug 'nightsense/cosmic_latte'           | " Theme that's easy on the eyes
  Plug 'kjssad/quantum.vim'                | " A modern colorscheme inspired by firefox
  Plug 'owickstrom/vim-colors-paramount'   | " V. Dark colorscheme with purple accent
  Plug 'rakr/vim-one'                      | " one-dark colorscheme for vim
  Plug 'itchyny/lightline.vim'             | " Awesome status bar
  Plug 'maximbaz/lightline-ale'            | " ALE indicator for lightline
  Plug 'mengelbrecht/lightline-bufferline' | " A buffer plugin for lightline
  Plug 'psliwka/vim-smoothie'              | " Smooth scrolling
  Plug 'Yggdroot/indentLine'               | " Indent guides


  "
  " Editor
  "
  Plug 'junegunn/goyo.vim'                 | " Distraction-free writing in Vim
  Plug 'tpope/vim-surround'                | " Change your surroundings
  Plug 'junegunn/vim-peekaboo'             | " Show register contents on /@
  Plug 'jiangmiao/auto-pairs'              | " Add brackets automatically
  Plug 'Shougo/deoplete.nvim', {
  \ 'do': 'UpdateRemotePlugins'
  \ }                                      | " Async completion
  Plug 'artur-shaik/vim-Javacomplete2'     | " Deoplete source for java
  Plug 'deoplete-plugins/deoplete-jedi'    | " Deoplete source for python

  Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }                                      | " LSP protocol for vim
  Plug 'airblade/vim-gitgutter'            | " Git gutter
  Plug 'kshenoy/vim-signature'             | " Visualise and navigate marks


  "
  " Syntax
  "
  Plug 'dense-analysis/ale'                | " Async Lint Engine
  Plug 'sheerun/vim-polyglot'              | " Mega language support pack
  Plug 'HerringtonDarkholme/yats.vim'      | " Syntax highlighting for ts
  Plug 'dart-lang/dart-vim-plugin'         | " Syntax highlighting for dart
  Plug 'dominikduda/vim_current_word'      | " Highlighting word under cursor


  "
  " Tools
  "
  Plug 'majutsushi/tagbar'                 | " Display tags in a window by scope.
  Plug 'qpkorr/vim-bufkill'                | " Delete buffer without losing split window
  Plug 'tpope/vim-sleuth'                  | " Autodetect file spacing
  Plug 'scrooloose/nerdcommenter'          | " Awesome Commenting
  Plug 'vim-scripts/autoswap.vim'          | " Handle swap files intelligently
  Plug 'tpope/vim-obsession'               | " continuously update session files
  Plug 'tpope/vim-fugitive'                | " Git wrapper
  Plug 'airblade/vim-rooter'               | " Set working directory to project root
  Plug 'tpope/vim-eunuch'                  | " Add unix commands to vim
  Plug 'tpope/vim-unimpaired'              | " Bracket mappings
  Plug 'samoshkin/vim-mergetool'           | " use vim as mergetool
  " Plug 'vimwiki/vimwiki'                   | " personal wiki tool for vim
  Plug 'editorconfig/editorconfig-vim'     | " .editorconfig support
  Plug 'easymotion/vim-easymotion'         | " Navigate files with ease
  Plug 'junegunn/vim-easy-align'           | " Align things
  Plug 'SirVer/ultisnips'                  | " Snippets engine
  Plug 'honza/vim-snippets'                | " Snippets
  Plug 'thosakwe/vim-flutter'              | " Commands for Flutter from vim
  Plug 'Shougo/echodoc'                    | " Displays function signatures from completions
  " Plug 'camspiers/animate.vim'             |   " A Vim Automatic Window Resizing Plugin
  " Plug 'camspiers/lens.vim'


  "
  " File manager
  "
  Plug 'scrooloose/nerdtree'               | " File tree view
  Plug 'ryanoasis/vim-devicons'            | " Add file icons to vim plugins
  Plug 'Xuyuanp/nerdtree-git-plugin'       | " Git indicators for nerdtree.


  "
  " Search
  "
  Plug 'haya14busa/incsearch.vim'          | " Incremental searching
  Plug 'haya14busa/incsearch-fuzzy.vim'
  Plug 'haya14busa/incsearch-easymotion.vim'
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.local/lib/fzf', 'do': './install --all' }


call plug#end()
