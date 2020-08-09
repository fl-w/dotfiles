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
  " Colorschemes (yes i know)
  "
  Plug 'ayu-theme/ayu-vim'                      | " Modern theme for modern VIMs
  Plug 'sjl/badwolf'                            | " clean theme for vim
  Plug 'drewtempelmeyer/palenight.vim'          | " awesome colorful theme for vim #1
  Plug 'owickstrom/vim-colors-paramount'        | " V. Dark colorscheme with purple accent
  Plug 'cseelus/vim-colors-lucid'               | " Fantastic colors

  "
  " Syntax highlighting
  "
  Plug 'vim-pandoc/vim-pandoc-syntax'           | " Pandoc syntax
  Plug 'sheerun/vim-polyglot'                   | " Mega language support pack


  "
  " Autocomplete
  "
  Plug 'neoclide/coc.nvim'                      | " Intellisense engine with lsp
  Plug 'neoclide/coc-neco'                      | " Add vim completion to coc
  Plug 'Shougo/neco-vim'                        | " Vim completion source

  "
  " Editor
  "
  Plug 'AndrewRadev/splitjoin.vim'              | " Switch between single-line and multi-line code
  Plug 'bkad/CamelCaseMotion'                   | " Add camel case motion
  Plug 'dhruvasagar/vim-table-mode',
        \ { 'for': 'markdown' }                 | " Easily create tables in vim
  Plug 'easymotion/vim-easymotion'              | " More vim motions!
  Plug 'jiangmiao/auto-pairs'                   | " Add brackets automatically
  Plug 'junegunn/goyo.vim'                      | " Distraction-free writing in Vim
  Plug 'junegunn/limelight.vim'
  Plug 'junegunn/vim-peekaboo'                  | " Show register contents on /@
  Plug 'kshenoy/vim-signature'                  | " Visualise and navigate marks in gutter
  Plug 'liuchengxu/vim-which-key'               | " Show keybindings in a popup
  Plug 'machakann/vim-highlightedyank'          | " Highlight yanked text
  Plug 'majutsushi/tagbar'                      | " Display tags in a window by scope.
  " Plug 'mhinz/vim-signify'                      | " Git gutter
  Plug 'airblade/vim-gitgutter'
  Plug 'rhysd/clever-f.vim'                     | " Quick f,t vim motions
  Plug 'samoshkin/vim-mergetool'                | " use vim as mergetool
  Plug 'tpope/vim-abolish'                      | " Easily search and substitute
  Plug 'tpope/vim-surround'                     | " Change your surroundings
  Plug 'vim-pandoc/vim-pandoc'                  | " Pandoc integration
  Plug 'Yggdroot/indentLine'                    | " Indent guides


  "
  " Tools
  "
  Plug 'camspiers/animate.vim'                  | " animation library
  Plug 'junegunn/vim-easy-align'                | " Easily align text
  Plug 'majutsushi/tagbar'                      | " Display tags in a window by scope.
  Plug 'mbbill/undotree'                        | " Graphical undo history
  Plug 'tpope/vim-commentary'                   | " Awesome commenting
  Plug 'psliwka/vim-smoothie'                   | " Smooth scrolling
  Plug 'samoshkin/vim-mergetool'                | " use vim as mergetool
  Plug 'simnalamburt/vim-mundo'                 | " Another graphical undo history
  Plug 'thinca/vim-template'                    | " Template file engine
  Plug 'tpope/vim-dispatch'                     | " Autodetect file spacing
  Plug 'tpope/vim-eunuch'                       | " Add unix commands to vim
  Plug 'tpope/vim-fugitive'                     | " Git wrapper
  Plug 'tpope/vim-obsession'                    | " Continuously update session files
  Plug 'tpope/vim-sleuth'                       | " Autodetect file spacing
  Plug 'vim-scripts/autoswap.vim'               | " Handle swap files intelligently
  Plug 'zefei/vim-wintabs'                      | " Manage buffers per window


  "
  " Snippets
  "
  Plug 'Shougo/neosnippet.vim'                  | " Snippets engine
  Plug 'Shougo/neosnippet-snippets'             | " Snippets
  Plug 'honza/vim-snippets'                     | " MOH Snippets


  "
  " File explorer
  "
  Plug 'lambdalisue/fern.vim'
  " \ { 'commit': '0e862fc1a13ddb18fbd8b410d208b034c3cf7370' }                  | " Asynchronous tree viewer
  Plug 'ryanoasis/vim-devicons'                 | " Add file icons to plugins
  " Plug 'lambdalisue/fern-renderer-nerdfont.vim'
  Plug 'lambdalisue/fern-renderer-devicons.vim' | " Add file icons to fern
  " Plug 'lambdalisue/nerdfont.vim'
  " Plug 'folws/fern-devicons-syntax'             | " Add syntax highlight to icons
  " Plug 'lambdalisue/glyph-palette.vim'


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
let s:self = expand('%')
augroup vimrc_pi
  au!
  " au VimEnter * call <SID>install_missing_plugins()
  exe 'au SourcePost' s:self 'call <SID>install_missing_plugins()'
augroup END


call utils#abbr_command('pi', 'PlugInstall')
call utils#abbr_command('pud', 'PlugUpdate')
call utils#abbr_command('pug', 'PlugUpgrade')
call utils#abbr_command('ps', 'PlugStatus')
call utils#abbr_command('pc', 'PlugClean')
