" colorscheme.vim
"

let s:preferred_themes = #{
      \ dark: [ 'ayu', 'gruvbox' ],
      \ light: [ 'inspired-github' ],
    \ }

fu! colorscheme#refresh_theme() abort 
  " set color scheme based on background
  exe 'silent! colorscheme ' .. s:preferred_themes[&bg][0]
endfu

fu! colorscheme#togglebg() abort
  let &background = ( &background ==# 'dark'? 'light' : 'dark' )
  if exists('g:colors_name')
    exe 'colorscheme' g:colors_name
  endif
endfu

fu! colorscheme#set() abort
  hi MatchParen cterm=italic gui=italic
  hi! link MatchParen Keyword

  hi! def          Function cterm=bold    gui=bold
  hi! def         Statement cterm=bold    gui=bold

  hi        SignifySignAdd               guibg=bg                  | " dont add bacground to git diff signs
  hi     SignifySignChange               guibg=bg                  | " dont add bacground to git diff signs
  hi     SignifySignRemove               guibg=bg                  | " dont add bacground to git diff signs
  hi          GitGutterAdd               guibg=bg                  | " dont add bacground to git diff signs
  hi       GitGutterChange               guibg=bg                  | " dont add bacground to git diff signs
  hi       GitGutterRemove               guibg=bg                  | " dont add bacground to git diff signs

  if &background == 'light' | return | endif

  call utils#color#copy_hi_group('DiffAdd', 'SignifySignAdd')
  call utils#color#copy_hi_group('DiffChange', 'SignifySignChange')
  call utils#color#copy_hi_group('DiffRemove', 'SignifySignRemove')
  " call utils#color#copy_hi_group('DiffAdd', 'GitGutterAdd')
  " call utils#color#copy_hi_group('DiffChange', 'GitGutterChange')
  " call utils#color#copy_hi_group('DiffRemove', 'GitGutterRemove')


  hi                LineNr ctermbg=NONE  guibg=NONE                | " dont highlight line number
  hi            SignColumn ctermbg=NONE  guibg=NONE                | " dont highlight sign column
  hi                Normal ctermbg=NONE  guibg=NONE                | " stop theme from setting bg color
  hi HighlightedyankRegion ctermbg=0     guibg=#13354A             | " change yank highlight color
  hi            StatusLine guifg=#4E4E4E guibg=bg      gui=italic  | " make statusline invisible
  hi          StatusLineNC guifg=#2b2b30 guibg=bg      gui=italic  | " same with inactive statusline
  hi         StatusLineINC guifg=#2b2b30 guibg=#181320 gui=italic  | " add background to statusline if has neighboring window below
  hi           EndOfBuffer guifg=#1f1f31 guibg=bg                  | " make EndOfBuffer ('~' char) faint
  " hi               Comment ctermfg=239   guifg=#36323d gui=italic  | " change comment color and set to italic
  " hi            CursorLine ctermfg=12    guibg=#181320 guifg=NONE  | " change the color of the cursor line to suit my chosen bg color
  " hi          CursorLineNr guifg=#767676                           | " change the color of the cursor line to suit my chosen bg color
  hi             VertSplit guifg=bg      guibg=bg      gui=NONE    | " dont highlight vertical split
  hi            CursorLine guifg=NONE                              | " don't highlight current line
  hi            DiffChange ctermfg=203   guifg=#9FC267
  hi                String                             gui=italic

  " tabline
  hi           TabLineFill guifg=#39373b guibg=bg gui=none
  call utils#color#copy_hi_group('Statement', 'TablineSel')
  hi            TabLineSel guibg=#a790d5            gui=bold

  " #181320 bg #847d91

  hi          Pmenu ctermfg=243 ctermbg=237  guifg=#767676 guibg=#0B0712
  hi       PmenuSel ctermfg=140 ctermbg=237  guifg=#8569B3 guibg=#0B0712 gui=bold
  hi      PmenuSbar ctermfg=28  ctermbg=233  guifg=#c269fe guibg=#303030
  hi     PmenuThumb ctermfg=160 ctermbg=97   guifg=#ff2c4b guibg=#875faf
  hi          Error ctermfg=204 ctermbg=NONE guifg=#ff3333 guibg=NONE    gui=none
  " alt error color:  #ff5370

endfu

augroup colorscheme_detect
  au!
  au BufRead,BufNewFile *.conf setf dosini                        | " syntax highlighting for .conf
  au BufRead,BufNewFile *.rasi setf css                           | " syntax highlighting for .rasi
  au ColorScheme        *      call colorscheme#set()             | " set colors on color scheme change
  au BufEnter           *      syntax sync fromstart              | " accurate syntax highlighting
  au FileType           json   syntax match Comment +\/\/.\+$+    | " allow comments in json files
augroup END

if has('vim_starting')
  call colorscheme#refresh_theme()
endif

silent! nnoremap <silent> <unique> <F5> :call colorscheme#togglebg()<cr>
silent! inoremap <silent> <unique> <F5> <ESC>:call colorscheme#togglebg()<cr>a
silent! vnoremap <silent> <unique> <F5> <ESC>:call colorscheme#togglebg()<cr>gv

set synmaxcol=300                                                                      | " use syntax highlighting only for 300 columns

if has('termguicolors')                    | set termguicolors                 | endif | " enable true colors
if has('nvim')                             | let $NVIM_TUI_ENABLE_TRUE_COLOR=1 | endif | " use 24-bit (true-color) mode in Neovim
if has('syntax') && !exists('g:syntax_on') | syntax enable                     | endif | " enables syntax highlighting
if !has('gui_running')                     | set t_Co=256                      | endif | " support 256 colors
if !has('gui_running')                     | let &t_ut=''                      | endif | " support 256 colors

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^Eterm'        | set t_Co=16                       | endif

" vim: sw=2 sts=2 tw=0 fdm=marker
