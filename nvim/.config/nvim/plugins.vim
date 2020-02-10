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
  Plug 'drewtempelmeyer/palenight.vim'    " Fantastic colors
  Plug 'nightsense/cosmic_latte'          " Theme that's easy on the eyes
  Plug 'dylanaraps/wal.vim'               " Pywal for vim

  Plug 'dominikduda/vim_current_word'     " Highlighting word under cursor
  Plug 'junegunn/goyo.vim'                " Distraction-free writing in Vim
  " Plug 'godlygeek/tabular' |
  "    Plug 'godlygeek/vim-markdown'       " Syntax highlighting for markdown (depends: tabular)

  "
  "  Syntax check
  "
  Plug 'dense-analysis/ale'               " Async Lint Engine
  Plug 'tpope/vim-sensible'               " Some sensible settings

  Plug 'itchyny/lightline.vim'            " Awesome status bar
  Plug 'maximbaz/lightline-ale'           " ALE indicator for lightline
  Plug 'mengelbrecht/lightline-bufferline' " A buffer plugin for lightline

  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'deoplete-plugins/deoplete-jedi'   " Deoplete source for python

  Plug 'haya14busa/incsearch.vim'         " Incremental searching
  Plug 'haya14busa/incsearch-fuzzy.vim'
  Plug 'haya14busa/incsearch-easymotion.vim'

  Plug 'majutsushi/tagbar'                " Display tags in a window by scope.
  Plug 'tpope/vim-sleuth'                 " Autodetect file spacing
  Plug 'scrooloose/nerdcommenter'         " Awesome Commenting
  " Plug 'vim-scripts/auto-pairs-gentle'    " Add brackets automatically
  Plug 'vim-scripts/autoswap.vim'         " Handle swap files intelligently
  Plug 'sheerun/vim-polyglot'             " Mega language support pack
  Plug 'tpope/vim-fugitive'               " Git wrapper
  Plug 'junegunn/fzf', { 'dir': '~/.local/lib/fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'editorconfig/editorconfig-vim'    " .editorconfig support
  Plug 'tpope/vim-surround'               " Change your surroundings
  Plug 'Yggdroot/indentLine'              " Indent guides
  Plug 'easymotion/vim-easymotion'        " Navigate files with ease
  Plug 'scrooloose/nerdtree'              " File tree view
  Plug 'Xuyuanp/nerdtree-git-plugin'      " Git indicators for nerdtree.
  Plug 'ryanoasis/vim-devicons'           " Add file icons to vim plugins
  Plug 'airblade/vim-gitgutter'           " Git gutter
  Plug 'junegunn/vim-easy-align'          " Align things
  Plug 'majutsushi/tagbar'
  Plug 'SirVer/ultisnips'                 " Snippets engine
  Plug 'honza/vim-snippets'               " Snippets


call plug#end()

"
" Configurations for plugins
"

" Ale configuration
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'javascript' : ['eslint'],
      \ 'python': ['black', 'isort', 'add_blank_lines_for_python_control_statements']
      \}
let g:ale_linters = {'python': ['pylint', 'flake8']}

" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1
let g:ale_completion_tsserver_autoimport = 1
let g:ale_set_ballons = 1
let g:ale_sign_column_always = 1
let g:ale_change_sign_column_color = 1
let g:ale_close_preview_on_insert = 1

" Use <leader>e to go to the next error
nnoremap <leader>e :call LocationNext()<cr>


" Ayu configuration
let ayucolor="mirage"

""" Custom Javascript configuration
let g:javascript_plugin_jsdoc = 1    " Highlight JSDoc

"" Deoplete configuration
let g:deoplete#enable_at_startup = 1

""" editorconfig
" let g:EditorConfig_core_mode = 'external_command'


""" Indent guides
let g:indentLine_char = '┆'

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
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1


""" NERDTree
let NERDTreeIgnore = ['node_modules', 'tmp', 'bower_components']
" Don't want to see the extra text
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeHijackNetrw = 1
let g:NERDTreeQuitOnOpen = 1

au VimEnter NERD_tree_1 enew | execute 'NERDTree '.argv()[0]

" Get colors from color scheme
let s:colors = palenight#GetColors()
" NERDTres File highlighting
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

""" lightline/-buffers configuration
let g:lightline = {
      \ 'colorscheme': 'cosmic_latte',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste'  ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified'  ] ],
      \   'right': [ [ 'kite', 'lineinfo' ],
      \   [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]]
      \ }
\ }
let g:lightline.tabline = {
      \  'left': [['buffers']],
      \  'right': [['close']]
\}

let g:lightline.component_function = {
      \  'gitbranch': 'fugitive#head',
      \   'kite': 'kite#statusline'
\}
let g:lightline.component_expand = {
      \ 'buffers': 'lightline#bufferline#buffers',
      \ 'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
\}
let g:lightline.component_type = {
      \     'buffers': 'tabsel',
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }

let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#unicode_symbols = 1
let g:lightline#bufferline#min_buffer_count = 2
let g:lightline#bufferline#show_number = 2
let g:lightline#bufferline#unnamed = '[ No Name ]'
let g:lightline#bufferline#reverse_buffers = 1

let g:lightline#bufferline#number_map = {
\ 0: '⁰', 1: '¹', 2: '²', 3: '³', 4: '⁴',
\ 5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'}

""" Goyo configuration
let g:goyo_width = 100
" let g:goyo_linenr = 1
autocmd! User GoyoLeave nested :highlight LineNr guibg=NONE gui=NONE

""" Kite configuration
let g:kite_auto_complete=1

""" UtilSnips configuration
let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
