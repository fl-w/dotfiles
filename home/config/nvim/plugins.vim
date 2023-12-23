" List all plugins here.
"

command! PI PlugInstall | q | " register command to plug install and quit

" Install VimPlug if not present
let s:autoload_site = $VIM_DATA_ROOT . '/site/autoload/plug.vim'
if empty(glob(s:autoload_site))
  if executable('curl')
    echomsg 'Downloading and installing vim-plug.'
    silent exe '!curl -fLo ' . s:autoload_site .
      \ ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  else
    echoerr 'curl is needed to install vim-plug and is not found in path, please install vim-plug manually.'
    finish
  endif
endif
exe 'source' s:autoload_site
unlet s:autoload_site

" Plugin List
"
call plug#begin($VIM_DATA_ROOT. '/site/plugged')
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
  Plug 'neoclide/coc.nvim',
    \ { 'branch': 'release' }                   | " Intellisense engine with lsp
  Plug 'Shougo/neco-vim', { 'for': 'vim' }      | " Vim completion source
  Plug 'lervag/vimtex', { 'for': 'tex'}         | " LaTeX support


  "
  " Colorschemes (yes i know... its alot)
  "
  Plug 'ayu-theme/ayu-vim'                      | " Modern theme for modern VIMs
  Plug 'sjl/badwolf'                            | " Bright + clean theme for vim
  Plug 'morhetz/gruvbox'                        | " sometimes i like to hurt myself
  Plug 'lifepillar/vim-gruvbox8'                | " alternative ways to hurt myself
  Plug 'cormacrelf/vim-colors-github'
  Plug 'mvpopuk/inspired-github.vim'
  Plug 'NLKNguyen/papercolor-theme'             | " Light theme with sane background
  Plug 'mvanderkamp/cocoa.vim'
  Plug 'adigitoleo/vim-mellow'

  "
  " Syntax highlighting
  "
  Plug 'arzg/vim-rust-syntax-ext',
        \ { 'for': 'rust'}                      | " Extra syntax for rust
  Plug 'dag/vim-fish', { 'for': 'fish' }        | " Glorious fish syntax
  Plug 'fladson/vim-kitty',
        \ { 'for': 'kitty' }                    | " MIPS Syntax
  Plug 'vim-pandoc/vim-pandoc-syntax',
        \ { 'for': 'pandoc' }                   | " Pandoc syntax
  Plug 'elkowar/yuck.vim', { 'for': 'yuck' }    | " Yuck syntax
  Plug 'hashivim/vim-terraform'                 | " Terraform syntax
  Plug 'peitalin/vim-jsx-typescript'            | " JSX|TSX syntax

  "
  " Editor
  "
  Plug 'andymass/vim-matchup'
  Plug 'dhruvasagar/vim-table-mode',
        \ { 'for': 'markdown' }                 | " Easily create tables in vim
  Plug 'jiangmiao/auto-pairs'                   | " Add brackets automatically
  Plug 'psliwka/vim-smoothie'                   | " Smooth scrolling
  Plug 'liuchengxu/vim-which-key'               | " Show keybindings in a popup
  Plug 'rhysd/clever-f.vim'                     | " Quick f,t vim motions
  Plug 'tpope/vim-surround'                     | " Change your surroundings
  Plug 'vim-pandoc/vim-pandoc',
        \ { 'for': 'markdown' }                 | " Pandoc integration
  Plug 'Yggdroot/indentLine'                    | " Indent guides


  "
  " Tools
  "
  Plug 'junegunn/vim-easy-align'                | " Easily align text
  Plug 'tpope/vim-abolish'                      | " Easily search and substitute
  Plug 'tpope/vim-commentary'                   | " Awesome commenting
  Plug 'tpope/vim-sleuth'                       | " Autodetect file spacing
  Plug 'vim-scripts/autoswap.vim'               | " Handle swap files intelligently
  Plug 'zefei/vim-wintabs'                      | " Manage buffers per window
  Plug 'tweekmonster/startuptime.vim'           | " Profile vim startup


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
  Plug 'lambdalisue/nerdfont.vim'               | " Add file icons to plugins
  Plug 'lambdalisue/fern-renderer-nerdfont.vim' | " Add file icons to fern


  "
  " Search
  "
  Plug 'junegunn/fzf', {
        \ 'dir': (exists('$data') ? '$data' : '~/.local/share') . '/lib/fzf',
        \ 'do': './install --bin' }
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
  let s:self = expand('<sfile>')
  augroup vimrc_plug_install
    au!
    exe 'au SourcePost' s:self 'call plugins#install_missing()'
    exe 'au BufWritePost' s:self 'source' s:self
  augroup END

  call utils#abbr_command('pi', 'PlugInstall')
  call utils#abbr_command('pud', 'PlugUpdate')
  call utils#abbr_command('pug', 'PlugUpgrade')
  call utils#abbr_command('ps', 'PlugStatus')
  call utils#abbr_command('pc', 'PlugClean')
endif

" load plugin configs
let g:plug_configs = map(
      \   filter( copy(g:plugs_order), { _, val -> index(g:vim_ignore_configs, val) == -1 } ),
      \   '"plugins.d/" . tolower(substitute(fnamemodify(v:val, ":r"), "\\.", "-", "")) . ".vim"'
      \)
for s:plug in g:plug_configs
  exe 'runtime' s:plug
endfor

" vim: sw=2 sts=2 tw=0 fdm=marker
