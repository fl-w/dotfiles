" markdown ft configuration
"

set concealcursor=c
set synmaxcol=3000  " For long paragraphs

if exists('g:loaded_ftmarkdown')
  finish
endif

let g:md_auto_compile = 1
let g:md_auto_compile_outdir = "~/.cache/"
let g:loaded_ftmarkdown = 1

function! CompileMarkdown()
    silent execute ":Start! pandoc " . expand("%") . " -o " . g:md_auto_compile_outdir . expand("%:r") .
        \ ".pdf --toc --toc-depth=3 --number-sections"
endfunction

function! InsertMarkdownScreenShot()
  let l:scr_dir = expand('%:h') . '/.screenshots'
  silent! execute "!mkdir -p " . l:scr_dir
  let l:path = system('SCR_DIR=' . l:scr_dir . ' SCR_PREFIX=' . expand('%:t:r') . '_ scr -s')

  if strlen(l:path) != 0
    silent! execute "normal! i![" . fnamemodify(l:path, ':t:r') . "](" . fnamemodify(l:path, ':.') . ")\<Esc>"
  endif
endfunction

autocmd! BufWritePost *.md if g:md_auto_compile | call CompileMarkdown() | endif
