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
  Plug 'dylanaraps/wal.vim'                " Pywal for vim
  Plug 'kjssad/quantum.vim'                " A modern colorscheme inspired by firefox

  Plug 'sheerun/vim-polyglot'              " Mega language support pack

  Plug 'dominikduda/vim_current_word'      " Highlighting word under cursor
  Plug 'junegunn/goyo.vim'                 " Distraction-free writing in Vim
  " Plug 'godlygeek/tabular' |
  " Plug 'godlygeek/vim-markdown'       " Syntax highlighting for markdown (depends: tabular)

  Plug 'scrooloose/nerdtree'               " File tree view
  Plug 'Xuyuanp/nerdtree-git-plugin'       " Git indicators for nerdtree.
  Plug 'airblade/vim-gitgutter'            " Git gutter

  Plug 'ryanoasis/vim-devicons'            " Add file icons to vim plugins

  "
  " Syntax check
  "
  Plug 'dense-analysis/ale'                " Async Lint Engine
  Plug 'tpope/vim-sensible'                " Some sensible settings

  Plug 'itchyny/lightline.vim'             " Awesome status bar
  Plug 'maximbaz/lightline-ale'            " ALE indicator for lightline
  Plug 'mengelbrecht/lightline-bufferline' " A buffer plugin for lightline

  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'deoplete-plugins/deoplete-jedi'    " Deoplete source for python
  Plug 'artur-shaik/vim-Javacomplete2'     " Deoplete source for java

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
