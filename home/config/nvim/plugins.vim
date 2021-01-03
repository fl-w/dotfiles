" List all plugins here.
"

command! PI PlugInstall | q | " register command to plug install and quit

" Install VimPlug if not present
let s:data_site = $VIM_DATA_ROOT . '/site/autoload/plug.vim'
if empty(glob(s:data_site))
  if executable('curl')
    echomsg 'Downloading and installing vim-plug.'
    silent exe '!curl -fLo ' . s:data_site .
      \ ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  else
    echoerr 'curl is needed to install vim-plug and is not found in path, please install vim-plug manually.'
    finish
  endif
endif
unlet s:data_site

" Plugin List
"
call plug#begin($VIM_DATA_ROOT. '/plugged')
if exists('g:started_by_firenvim')
  Plug 'glacambre/firenvim', { 'do':
    \ { _ -> firenvim#install(0) } }            | " Use neovim client in browser
else

  "
  " Core
  "

  Plug 'camspiers/animate.vim'                  | " animation library

  "
  " Autocomplete
  "
  " Intellisense engine with lsp
  Plug 'lervag/vimtex'
  Plug 'neoclide/coc.nvim', 
    \ { 'branch': 'master', 
    \   'do': 'yarn install --frozen-lockfile',
    \   'commit': '7f84d6bdd79e30b71862a9ef228fc0312fe04beb' }
  " Intellisense engine with lsp
  Plug 'neoclide/coc-neco'                      | " Add vim completion to coc
  Plug 'Shougo/neco-vim', { 'for': 'vim' }      | " Vim completion source


  "
  " Colorschemes (yes i know)
  "
  Plug 'ayu-theme/ayu-vim'                      | " Modern theme for modern VIMs
  Plug 'sjl/badwolf'                            | " clean theme for vim
  Plug 'drewtempelmeyer/palenight.vim'          | " awesome colorful theme for vim #1
  Plug 'owickstrom/vim-colors-paramount'        | " V. Dark colorscheme with purple accent
  Plug 'rakr/vim-one'                           | " Fantastic colors
  Plug 'NLKNguyen/papercolor-theme'             | " Light theme with sane background
  Plug 'lifepillar/vim-gruvbox8'                | " Gruvbox theme for VIM
  Plug 'jaredgorski/SpaceCamp'
  Plug 'liuchengxu/space-vim-dark'
  Plug 'tyrannicaltoucan/vim-deep-space'
  Plug 'AlessandroYorba/Sierra'
  Plug 'junegunn/seoul256.vim'
  Plug 'jdsimcoe/abstract.vim'
  Plug 'glepnir/oceanic-material'
  Plug 'mhartington/oceanic-next'
  Plug 'wadackel/vim-dogrun'
  Plug 'morhetz/gruvbox'


  "
  " Syntax highlighting
  "
  Plug 'arzg/vim-rust-syntax-ext'               | " Extra syntax for rust
  Plug 'harenome/vim-mipssyntax'                | " MIPS Syntax 
  Plug 'justinmk/vim-syntax-extra'              | " Syntax for c,bison,flex
  Plug 'sheerun/vim-polyglot'                   | " Mega language support pack
  Plug 'vim-pandoc/vim-pandoc-syntax'           | " Pandoc syntax
  if has('nvim-0.5')
    " Plug 'nvim-treesitter/nvim-treesitter'
  endif


  "
  " Editor
  "
  Plug 'andymass/vim-matchup'
  Plug 'antoinemadec/coc-fzf'                   | " FzF integration for coc.nvim
  Plug 'dhruvasagar/vim-table-mode',
        \ { 'for': 'markdown' }                 | " Easily create tables in vim
  " Plug 'easymotion/vim-easymotion'              | " More vim motions!
  Plug 'jiangmiao/auto-pairs'                   | " Add brackets automatically
  Plug 'junegunn/goyo.vim'                      | " Distraction-free writing in Vim
  Plug 'junegunn/limelight.vim'                 | " Distraction-free mode
  Plug 'junegunn/vim-peekaboo'                  | " Show register contents on /@
  Plug 'kshenoy/vim-signature'                  | " Visualise and navigate marks in gutter
  Plug 'liuchengxu/vim-which-key'               | " Show keybindings in a popup
  Plug 'machakann/vim-highlightedyank'          | " Highlight yanked text
  Plug 'mhinz/vim-signify'
  Plug 'rhysd/clever-f.vim'                     | " Quick f,t vim motions
  Plug 'samoshkin/vim-mergetool'                | " use vim as mergetool
  Plug 'terryma/vim-expand-region'              | " Expand visually selected text regions
  Plug 'tpope/vim-surround'                     | " Change your surroundings
  Plug 'udalov/kotlin-vim'
  " Plug 'vim-pandoc/vim-pandoc',
  "       \ { 'for': 'markdown' }                 | " Pandoc integration
  Plug 'Yggdroot/indentLine'                    | " Indent guides
  " Plug 'wellle/context.vim', { 'for': 'rust' }


  "
  " Tools
  "

  Plug 'junegunn/vim-easy-align'                | " Easily align text
  " Plug 'liuchengxu/vista.vim'                   | " Displays tags in a window by scope
  Plug 'mbbill/undotree'                        | " Graphical undo history
  Plug 'tpope/vim-abolish'                      | " Easily search and substitute
  Plug 'tpope/vim-commentary'                   | " Awesome commenting
  Plug 'psliwka/vim-smoothie'                   | " Smooth scrolling
  Plug 'samoshkin/vim-mergetool'                | " use vim as mergetool
  Plug 'simnalamburt/vim-mundo'                 | " Another graphical undo history
  Plug 'thinca/vim-template'                    | " Template file engine
  Plug 'tpope/vim-eunuch'                       | " Add unix commands to vim
  Plug 'tpope/vim-fugitive'                     | " Git wrapper
  " " Plug 'tpope/vim-obsession'                    | " Continuously update session files
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
  Plug 'ryanoasis/vim-devicons'                 | " Add file icons to plugins
  Plug 'lambdalisue/fern-renderer-devicons.vim' | " Add file icons to fern


  "
  " Search
  "
  Plug 'junegunn/fzf', {
        \ 'dir': '~/.local/lib/fzf',
        \ 'do': './install --all' }
  Plug 'junegunn/fzf.vim'                       | " Fuzzy searching in vim

endif
call plug#end()

" install missing plugins on startup

fu! plugins#install_missing()
  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    PlugInstall --sync | q
  endif
endfu

if has('vim_starting')
  call plugins#install_missing()
endif

let s:self = expand('%')
augroup vimrc_plug_install
  au!
  exe 'au SourcePost' s:self 'call plugins#install_missing()'
augroup END

call utils#abbr_command('pi', 'PlugInstall')
call utils#abbr_command('pud', 'PlugUpdate')
call utils#abbr_command('pug', 'PlugUpgrade')
call utils#abbr_command('ps', 'PlugStatus')
call utils#abbr_command('pc', 'PlugClean')

" vim: sw=2 sts=2 tw=0 fdm=marker