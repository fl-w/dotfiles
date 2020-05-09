"
" Configurations for plugins
"

" Ale configuration
let g:ale_fixers = {
      \ '*':          ['remove_trailing_lines', 'trim_whitespace'],
      \ 'javascript': ['prettier'],
      \ 'css':        ['prettier'],
      \ 'c':          ['clang-format'],
      \ 'json':       ['fixjson'],
      \ 'haskell':    ['brittany'],
      \ 'java':       ['google_java_format'],
      \ 'typescript': ['prettier', 'eslint'],
      \ 'python':     ['black', 'isort', 'add_blank_lines_for_python_control_statements']
      \}
let g:ale_linters = {
      \ 'python':     ['pylint', 'flake8'],
      \ 'c':          ['clang-tidy'],
      \ 'java':       ['checkstyle']
      \}

" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1
let g:ale_completion_tsserver_autoimport = 1
let g:ale_set_ballons = 1
let g:ale_sign_column_always = 1
let g:ale_change_sign_column_color = 1
let g:ale_close_preview_on_insert = 1
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_python_flake8_options = '--ignore=E501'

" Ayu configuration
"
let ayucolor="mirage"


" CamelCaseMotion configuration
"
let g:camelcasemotion_key = '<leader>'


" Deoplete configuration
"
let g:deoplete#enable_at_startup           = 1
let g:deoplete#enable_smart_case           = 1

"" Setup completetion sources
let g:deoplete#sources                     = {}

call deoplete#custom#source('LanguageClient',
            \ 'min_pattern_length',
            \ 2)
call deoplete#custom#option('camel_case', v:false)
call deoplete#custom#option('max_list', 20)

let g:deoplete#sources#jedi#show_docstring = 1
" let g:deoplete#sources.java                = [ 'jc', 'javacomplete2', 'file', 'buffer', 'ultisnips' ]
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | silent! pclose | endif

function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#manual_complete()"

inoremap <silent><expr> <CR>
      \ pumvisible() ? "\<c-y>" :
      \ "\<cr>"


" echodoc configuration
"
" set noshowmode
let g:echodoc#enable_at_startup = 0
let g:echodoc#type = 'echo'


" firenvim configuration
"
if exists('g:started_by_firenvim') && g:started_by_firenvim
    " general options

    colorscheme cosmis_latte

    highlight Normal guibg=#1b1d1e

    augroup firenvim
        autocmd!
        autocmd BufEnter *.txt setlocal filetype=markdown.pandoc
    augroup END
endif


" fzf configuration
"
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
let $FZF_DEFAULT_OPTS=' --color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse  --margin=1,4'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = float2nr(10)
  let width = float2nr(80)
  let horizontal = float2nr((&columns - width) / 2)
  let vertical = 1

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction


" indentline configuration
"
let g:indentLine_char = '┆'


" languageclient-neovim configuration
"
let g:LanguageClient_serverCommands = {
    \ 'haskell':        ['hie-wrapper', '--lsp'],
    \ 'python':         ['/usr/local/bin/pyls'],
    \ 'dart':           ['dart_language_server', '--lsp'],
    \ 'javascript':     ['javascript-typescript-stdio'],
    \ 'typescript':     ['typescript-language-server', '--stdio'],
    \ }
    " \ 'java':           ['/usr/bin/jdtls', '-data', getcwd()],
    " \ 'typescript':     ['javascript-typescript-stdio'],
let g:LanguageClient_hoverPreview = 'Never'
let g:LanguageClient_echoProjectRoot = 0


" lens.vim configuration
"
let g:lens#disabled_filetypes = ['nerdtree', 'fzf', '[ No Name ]', 'Scratch', 'NERD_tree_1', 'NERD_tree_2']
let g:lens#height_resize_min = 5
let g:lens#height_resize_max = 40
let g:lens#width_resize_max = 80
let g:lens#width_resize_min = 20


" lightline/-buffers configuration
"
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste'  ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified'  ] ],
      \   'right': [ [ 'obsession', 'lineinfo' ],
      \   [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]]
      \ }
\ }
let g:lightline.tabline = {
      \  'left': [['buffers']],
      \  'right': [['close']]
\}

let g:lightline.component_function = {
      \  'gitbranch': 'fugitive#head'
\}
function LightlineObsession()
    return '%{ObsessionStatus()}'
endfunction
let g:lightline.component_expand = {
      \ 'buffers':          'lightline#bufferline#buffers',
      \ 'linter_checking':  'lightline#ale#checking',
      \ 'obsession':        'LightlineObsession',
      \ 'linter_warnings':  'lightline#ale#warnings',
      \ 'linter_errors':    'lightline#ale#errors',
      \ 'linter_ok':        'lightline#ale#ok',
\}
let g:lightline.component_type = {
      \     'buffers':         'tabsel',
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors':   'error',
      \     'linter_ok':       'left',
      \ }

let g:lightline#bufferline#enable_devicons   = 1
let g:lightline#bufferline#unicode_symbols   = 1
let g:lightline#bufferline#min_buffer_count  = 2
let g:lightline#bufferline#show_number       = 2
let g:lightline#bufferline#unnamed           = '[ No Name ]'
" let g:lightline#bufferline#reverse_buffers   = 1
let g:lightline#bufferline#filename_modifier = ':t'

let g:lightline#bufferline#number_map = {
\ 0: '⁰', 1: '¹', 2: '²', 3: '³', 4: '⁴',
\ 5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'}


" markdown-preview configuration
"
let g:mkdp_auto_start = 1


" ncm2 configuration
"
" autocmd BufEnter * call ncm2#enable_for_buffer()
"
" au User Ncm2Plugin call ncm2#register_source({
"         \ 'name' : 'vimtex',
"         \ 'priority': 9,
"         \ 'subscope_enable': 1,
"         \ 'complete_length': 1,
"         \ 'scope': ['tex'],
"         \ 'mark': 'tex',
"         \ 'word_pattern': '\w+',
"         \ 'complete_pattern': g:vimtex#re#ncm,
"         \ 'on_complete': ['ncm2#on_complete#omni'],
"         \ })


" NERDCommenter configuration
"

"" Add spaces after comment delimiters by default
let g:NERDSpaceDelims            = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs        = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines      = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign           = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines      = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines    = 1


" NERDTree
"
let NERDTreeIgnore               = ['node_modules', 'tmp', 'bower_components']
let NERDTreeMinimalUI            = 1
let NERDTreeDirArrows            = 1
let NERDTreeShowHidden           = 1
let g:NERDTreeHijackNetrw        = 1
let g:NERDTreeQuitOnOpen         = 1

"" Open nerd tree on start
au VimEnter NERD_tree_1 enew | execute 'NERDTree '.argv()[0]

" If NERDTree is open in the current buffer
function! NERDTreeToggleInCurDir()
  if exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1
     exe ":NERDTreeClose"
  else
     if (expand("%:t") != '')
        exe ":NERDTreeFind"
     else
        exe ":NERDTreeToggle"
     endif
  endif
endfunction

" NERDTrees File highlighting
let s:colors = palenight#GetColors()

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


" tagbar configuration
"
" autocmd VimEnter * :unmap <space>


" vim-easy-align configuration
"
"' mappings: maps.vim


" vim-easy-motion configuration
"
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase  = 1


" vim-javacomplete2 configuration

autocmd filetype java setlocal omnifunc=javacomplete#complete
" autocmd filetype java jcenable


" vim-mergetool configuration

let g:mergetool_layout = 'mr'
let g:mergetool_prefer_revision = 'local'


" vim-rooter configuration
"
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_patterns = [ '.project-root', 'package.json', 'README.*', '.git/' ]
" let g:rooter_targets = '*'

" vim-obsession configuration
"
augroup AutomaticallySourceSession | au!
autocmd BufEnter *.*
      \ if !empty(glob('./Session.vim'))
      \   | :so Session.vim
      \   | :Obsession!
      \ | endif
augroup end

" vim-smoothie configuration
"
let g:smoothie_no_default_mappings = 0


" vim-test configuration
"
let test#strategy = "neovim"

" ultisnips configuration
"
let g:UltiSnipsExpandTrigger='<c-j>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'
