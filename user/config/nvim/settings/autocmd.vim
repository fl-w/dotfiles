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
  au InsertEnter * let b:icul = &cul | set nocul                      " Remove cursorline on insertmode
  au InsertLeave * if utils#boolexists('b:icul') | set cul            " Replace prev cursorline
  au FocusLost   * if &nu | let b:irnu = &rnu | set nornu | endif     " Remove relative number on focus lost
  au FocusGained * if utils#boolexists('b:irnu') | set rnu | endif    " Replace relative number
augroup END

augroup auto_read
    autocmd!
    " autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
    "             \ if mode() == 'n' && getcmdwintype() == '' | checktime | endif
    autocmd FileChangedShellPost * echohl WarningMsg
                \ | echo "File changed on disk. Buffer reloaded!" | echohl None
augroup END

" Return to last edit position when opening a file
augroup resume_edit_position
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ | execute "normal! g`\"zvzz"
        \ | endif
augroup END
