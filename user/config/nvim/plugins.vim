" List all plugins here.
"

command! PI PlugInstall | q                     | " register command to plug install and quit

" Check for custom site directory
if !exists("g:vim_plug_dir")
  " default site to local instead of nvim config dir
  let g:vim_data_dir = expand(stdpath('data'))
  let g:vim_plug_dir = g:vim_data_dir . '/plugged'
endif

" Install VimPlug if not present
if empty(glob(g:vim_data_dir . '/autoload/plug.vim'))
  if executable('curl')
    echomsg 'Downloading and installing vim-plug.'
    silent exe '!curl -fLo ' . g:vim_data_dir . '/autoload/plug.vim' .
      \ ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  else
    echoerr 'curl is needed to install vim-plug and is not found in path, please install vim-plug manually.'
    finish
  endif
endif

" Plugin List
"
call plug#begin(g:vim_plug_dir)

if exists('g:started_by_firenvim')
  Plug 'glacambre/firenvim', { 'do':
    \ { _ -> firenvim#install(0) } }            | " Use neovim client in browser
else

  "
  " Base
  "
  if !has('nvim')
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif

  Plug 'hardcoreplayers/dashboard-nvim'         | " Fancy start screen


  "
  " Colorschemes
  "
  Plug 'ayu-theme/ayu-vim'                      | " Modern theme for modern VIMs
  Plug 'sjl/badwolf'                            | " clean theme for vim
  Plug 'AlessandroYorba/Despacio'               | " Soft theme for vim
  Plug 'morhetz/gruvbox'                        | " Gruvbox (dont ask)...
  Plug 'kaicataldo/material.vim'                | " Fantastic colors
  Plug 'drewtempelmeyer/palenight.vim'          | " awesome colorful theme for vim #1
  Plug 'jaredgorski/SpaceCamp'                  | " Bright colorful theme for vim with a hint of purple
  Plug 'owickstrom/vim-colors-paramount'        | " V. Dark colorscheme with purple accent
  Plug 'challenger-deep-theme/vim'

  "
  " Syntax highlighting
  "
  Plug 'vim-pandoc/vim-pandoc-syntax'           | " Pandoc syntax
  Plug 'sheerun/vim-polyglot'                   | " Mega language support pack


  "
  " Autocomplete
  "
  Plug 'neoclide/coc.nvim'                      | " Intellisense engine with lsp
  Plug 'neoclide/coc-neco'                      | " Vim Completion source for coc
  Plug 'Shougo/neco-vim'

  "
  " Editor
  "
  Plug 'tpope/vim-abolish'                      | " Easily search and substitute
  Plug 'jiangmiao/auto-pairs'                   | " Add brackets automatically
  Plug 'bkad/CamelCaseMotion'                   | " Add camel case motion
  Plug 'rhysd/clever-f.vim'                     | " Quick f,t vim motions
  Plug 'junegunn/goyo.vim'                      | " Distraction-free writing in Vim
  Plug 'Yggdroot/indentLine'                    | " Indent guides
  Plug 'majutsushi/tagbar'                      | " Display tags in a window by scope.
  Plug 'tpope/vim-surround'                     | " Change your surroundings
  Plug 'dhruvasagar/vim-table-mode'             | " Easily create tables in vim
  " Plug 'tpope/vim-characterize'                 | " Show unicode charater metadata
  Plug 'mbbill/undotree'                        | " Graphical undo history
  Plug 'simnalamburt/vim-mundo'
  Plug 'luochen1990/rainbow'                    | " Colorise bracket pairs
  Plug 'easymotion/vim-easymotion'              | " More vim motions!
  Plug 'machakann/vim-highlightedyank'          | " Highlight yanked text
  Plug 'mhinz/vim-signify'                      | " Git gutter
  Plug 'vim-pandoc/vim-pandoc'                  | " Pandoc integration
  Plug 'junegunn/vim-peekaboo'                  | " Show register contents on /@
  Plug 'kshenoy/vim-signature'                  | " Visualise and navigate marks in gutter
  Plug 'liuchengxu/vim-which-key'               | " Show keybindings in a popup
  " Plug 'bagrat/vim-buffet'


  "
  " Tools
  "
  Plug 'vim-scripts/autoswap.vim'               | " Handle swap files intelligently
  Plug 'preservim/nerdcommenter'                | " Awesome commenting
  Plug 'majutsushi/tagbar'                      | " Display tags in a window by scope.
  Plug 'qpkorr/vim-bufkill'                     | " Delete buffer without losing split window
  Plug 'tpope/vim-obsession'                    | " continuously update session files
  Plug 'tpope/vim-eunuch'                       | " Add unix commands to vim
  Plug 'tpope/vim-fugitive'                     | " Git wrapper
  Plug 'samoshkin/vim-mergetool'                | " use vim as mergetool
  Plug 'tpope/vim-sleuth'                       | " Autodetect file spacing
  Plug 'psliwka/vim-smoothie'                   | " Smooth scrolling

  "
  " Snippets
  "
  Plug 'Shougo/neosnippet.vim'                  | " Snippets engine
  Plug 'Shougo/neosnippet-snippets'             | " Snippets
  Plug 'honza/vim-snippets'                     | " MOH Snippets


  "
  " File explorer
  "
  Plug 'lambdalisue/fern.vim'                   | " Asynchronous tree viewer
  Plug 'ryanoasis/vim-devicons'                 | " Add file icons to plugins
  Plug 'lambdalisue/fern-renderer-devicons.vim' | " Add file icons to fern
  " Plug 'folws/fern-devicons-syntax'             | " Add syntax highlight to icons


  "
  " Search
  "
  Plug 'haya14busa/incsearch.vim'               | " Incremental searching
  Plug 'haya14busa/incsearch-easymotion.vim'
  Plug 'haya14busa/incsearch-fuzzy.vim'
  Plug 'junegunn/fzf', {
        \ 'dir': '~/.local/lib/fzf',
        \ 'do': './install --all' }
  Plug 'junegunn/fzf.vim'                       | " Fuzzy searching in vim

endif
call plug#end()

fu! s:install_missing_plugins()
  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    PlugInstall --sync | q
  endif
endfu

" install missing plugins on startup
augroup vimrc_pi
  let s:self = expand('%')
  au!
  " au VimEnter * call <SID>install_missing_plugins()
  exe 'au SourcePost' s:self 'call <SID>install_missing_plugins()'
augroup END


call utils#abbr_command('pi', 'PlugInstall')
call utils#abbr_command('pud', 'PlugUpdate')
call utils#abbr_command('pug', 'PlugUpgrade')
call utils#abbr_command('ps', 'PlugStatus')
call utils#abbr_command('pc', 'PlugClean')
