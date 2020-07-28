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
