" terminal configuration.
"

if !has('terminal') || exists('g:vscode')
 " TODO: support terminal in vscode
 finish
endif

" Leave insert mode with escape in a term buffer
tnoremap <Esc> <C-\><C-n><CR>

" Q to hide terminal
" tnoremap <expr> Q if &buftype == 'terminal' | echo noo | endif

fu! s:term_init()
  setl nonumber       " remove line numbering
  setl nobuflisted    " hide term buffers
  set bufhidden=hide
endfu

augroup term_btdetect
  au!
  " auto insert on terminal buffers
  au BufEnter * if &buftype == 'terminal' | :startinsert | endif
  au BufEnter term://* startinsert
  au TermOpen * call <SID>term_init()
augroup END

function! ChooseTerm(termname, slider)
    let pane = bufwinnr(a:termname)
    let buf = bufexists(a:termname)
    if pane > 0
        " pane is visible
        if a:slider > 0
            :exe pane . "wincmd c"
        else
            :exe "e #"
        endif
    elseif buf > 0
        " buffer is not in pane
        if a:slider
            :exe "topleft split"
        endif
        :exe "buffer " . a:termname
    else
        " buffer is not loaded, create
        if a:slider
            :exe "topleft split"
        endif
        :terminal
        :exe "f " a:termname
    endif
endfunction
" TODO: split term
