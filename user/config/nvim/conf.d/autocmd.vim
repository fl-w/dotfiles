" Filetype specific settings
"
autocmd! filetype *commit*,markdown setlocal spell         | " Spell Check
autocmd! filetype *commit*,markdown setlocal textwidth=72  | " Looks good
autocmd! filetype make setlocal noexpandtab                | " In Makefiles DO NOT use spaces instead of tabs

augroup window_size
  au! VimResized * wincmd =
augroup END

augroup vimrc
  au!

  au BufWritePre * call utils#trim_whitespace()                       " Remove trailing whitespace when saving
  au BufWritePre *
        \ call utils#auto_mkdir(expand('<afile>:p:h'), v:cmdbang)     " auto create missing directories
  au InsertEnter * let b:icul = &cul | set nocul                      " Remove cursorline on insertmode
  au InsertLeave * if utils#boolexists('b:icul') | set cul | endif    " Replace prev cursorline
  au BufEnter *.txt if &buftype == 'help' && winnr('$') > 1 | wincmd T | nnoremap <buffer> q :q<cr> | endif
  au WinLeave * if &cursorline | let w:cur = 1 | setl nocursorline | endif
  au WinEnter * if utils#boolexists('w:cur') | unlet w:cur | setl cursorline | endif
augroup END

fun! s:on_focus_lost()
  " Remove relative number on focus lost
  if &nu
    let b:irnu = 1
    setl nornu
  endif
endf

fun! s:on_focus_enter()
  " Restore relative number
  if utils#boolexists('b:irnu')
    unlet b:irnu
    setl rnu
  endif
endf

au vimrc FocusLost * call s:on_focus_lost()
au vimrc FocusGained *  call s:on_focus_enter()

" augroup auto_read
"     autocmd!
"     autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
"                 \ if mode() == 'n' && getcmdwintype() == '' | checktime | endif
"     autocmd FileChangedShellPost * echohl WarningMsg
"                 \ | echo "File changed on disk. Buffer reloaded!" | echohl None
" augroup END

" Return to last edit position when opening a file
augroup resume_edit_position
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ | execute "normal! g`\"zvzz"
        \ | endif
augroup END
