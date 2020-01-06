" List all plugins here.
"

" Install VimPlug if not present
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin()
" Visuals
"
Plug 'dylanaraps/wal.vim'               " Pywal for vim
Plug 'ayu-theme/ayu-vim'                " Modern theme for vim
Plug 'junegunn/seoul256.vim'            " Hyperfocus-writing in Vim
Plug 'nightsense/cosmic_latte'          " Theme that's easy on the eyes
Plug 'manasthakur/vim-commentor'        " Easy comment toggle
Plug 'godlygeek/tabular' |
    Plug 'godlygeek/vim-markdown'       " Syntax highlighting for markdown (depends: tabular)
Plug 'tpope/vim-sensible'               " Some sensible settings
Plug 'junegunn/goyo.vim'                " Distraction-free writing in Vim
Plug 'tpope/vim-sleuth'                 " Autodetect file spacing
Plug 'scrooloose/nerdcommenter'         " Awesome Commenting
Plug 'vim-scripts/auto-pairs-gentle'    " Add brackets automatically
Plug 'vim-scripts/autoswap.vim'         " Handle swap files intelligently
Plug 'sheerun/vim-polyglot'             " Mega language support pack
Plug 'drewtempelmeyer/palenight.vim'    " Fantastic colors
Plug 'tpope/vim-fugitive'               " Git wrapper
Plug 'itchyny/lightline.vim'            " Awesome status bar
Plug 'neomake/neomake'                  " Syntax checking
Plug 'junegunn/fzf', { 'dir': '~/.local/lib/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'editorconfig/editorconfig-vim'    " .editorconfig support
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Keyword completion
Plug 'tpope/vim-surround'               " Change your surroundings
Plug 'terryma/vim-multiple-cursors'     " Multiple cursors
Plug 'Yggdroot/indentLine'              " Indent guides
Plug 'easymotion/vim-easymotion'        " Navigate files with ease
Plug 'scrooloose/nerdtree'              " File tree view
Plug 'janko-m/vim-test'                 " Running tests
Plug 'airblade/vim-gitgutter'           " Git gutter
Plug 'junegunn/vim-easy-align'          " Align things
Plug 'mhinz/vim-startify'               " Lovely, informative start screen
Plug 'majutsushi/tagbar'
Plug 'deoplete-plugins/deoplete-jedi'   " Python auto completion
Plug 'davidhalter/jedi-vim'
Plug 'SirVer/ultisnips'                 " Snippets engine
Plug 'honza/vim-snippets'               " Snippets


call plug#end()

"
" Configurations for plugins
"

" Ayu configuration
let ayucolor="mirage"

""" Custom Javascript configuration
let g:javascript_plugin_jsdoc = 1    " Highlight JSDoc


""" editorconfig
let g:EditorConfig_core_mode = 'external_command'


""" fzf config
nnoremap <silent> <leader>t :Files<CR>
nnoremap <silent> <leader>f :Buffers<CR>


""" Indent guides
let g:indentLine_char = '┆'


""" neomake configuration
" Use <leader>e to go to the next error
nnoremap <leader>e :call LocationNext()<cr>


""" deoplete configuration
let g:deoplete#enable_at_startup = 1
" Improve ultisnips and deoplete integration
call deoplete#custom#source('ultisnips', 'matchers', ['matcher_fuzzy'])

""" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

""" NERDCommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1


""" NERDTree
let NERDTreeIgnore = ['node_modules', 'tmp', 'bower_components']
" Don't want to see the extra text
let NERDTreeMinimalUI = 1
" Close NERDTree after reading file
" autocmd BufReadPre,FileReadPre * :NERDTreeClose
let g:NERDTreeHijackNetrw = 1
au VimEnter NERD_tree_1 enew | execute 'NERDTree '.argv()[0]
" Get colors from color scheme
let s:colors = palenight#GetColors()
" stop theme from setting bg color
autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
call NERDTreeHighlightFile('md', 'blue', 'none', s:colors.blue.gui, 'none')
call NERDTreeHighlightFile('yml', 'magenta', 'none', s:colors.purple.gui, 'none')
call NERDTreeHighlightFile('json', 'yellow', 'none', s:colors.yellow.gui, 'none')
call NERDTreeHighlightFile('html', 'blue', 'none', s:colors.blue.gui, 'none')
call NERDTreeHighlightFile('css', 'cyan', 'none', s:colors.cyan.gui, 'none')
call NERDTreeHighlightFile('scss', 'cyan', 'none', s:colors.cyan.gui, 'none')
call NERDTreeHighlightFile('coffee', 'yellow', 'none', s:colors.dark_yellow.gui, 'none')
call NERDTreeHighlightFile('js', 'yellow', 'none', s:colors.yellow.gui, 'none')
call NERDTreeHighlightFile('rb', 'red', 'none', s:colors.red.gui, 'none')


""" vim-test configuration
let test#strategy = "neovim"

nmap <silent> <leader>o :TestNearest<CR>
nmap <silent> <leader>O :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

let g:lightline = {
      \ 'colorscheme': 'palenight',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste'  ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified'  ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

""" Goyo configuration
let g:goyo_width = 88
let g:goyo_linenr = 1
autocmd! User GoyoLeave nested :highlight LineNr guibg=NONE gui=NONE
