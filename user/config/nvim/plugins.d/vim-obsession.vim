" vim-obsession configuration
"
augroup AutomaticallySourceSession | au!
autocmd BufEnter *.*
      \ if !empty(glob(expand('%:h') . '/Session.vim'))
      \   | :so Session.vim
      \   | :Obsession!
      \ | endif
augroup end
"       \ if !empty(glob('~/.local/share/nvim/site/Session.vim'))
"       \   | :so ~/.local/share/nvim/site/Session.vim
"       \   | :Obsession! ~/.local/share/nvim/site/Session.vim
"       \ | endif
