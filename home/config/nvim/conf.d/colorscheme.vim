" colorscheme.vim
"

if has('termguicolors')
  set termguicolors                                | " enable true colors
endif

if !has('gui_running')
  set t_Co=256                                     | " support 256 colors
endif

if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1                | " use 24-bit (true-color) mode in Neovim
endif

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^Eterm'
  set t_Co=16
endif

if has('syntax') && !exists('g:syntax_on')
  syntax enable                                    | " enables syntax highlighting
endif

" set background=dark                                | " set background to be dark
set synmaxcol=300                                  | " use syntax highlighting only for 300 columns

fu! s:get_color_scheme()
  return get(g:, 'colors_name', 'default')
endfu

fu! colorscheme#set() abort
  let l:color_scheme = s:get_color_scheme()

  hi MatchParen cterm=italic gui=italic
  hi! link MatchParen Keyword
  if &background == 'light' | return | endif

  call utils#color#copy_hi_group('DiffAdd', 'SignifySignAdd')
  call utils#color#copy_hi_group('DiffChange', 'SignifySignChange')
  call utils#color#copy_hi_group('DiffRemove', 'SignifySignRemove')
  call utils#color#copy_hi_group('DiffAdd', 'GitGutterAdd')
  call utils#color#copy_hi_group('DiffChange', 'GitGutterChange')
  call utils#color#copy_hi_group('DiffRemove', 'GitGutterRemove')


  hi                LineNr ctermbg=NONE  guibg=NONE                | " dont highlight line number
  hi            SignColumn ctermbg=NONE  guibg=NONE                | " dont highlight sign column
  hi                Normal ctermbg=NONE  guibg=NONE                | " stop theme from setting bg color
  hi HighlightedyankRegion ctermbg=0     guibg=#13354A             | " change yank highlight color
  " hi               Comment ctermfg=239   guifg=#36323d gui=italic  | " change comment color and set to italic
  hi            StatusLine guifg=#4E4E4E guibg=bg      gui=italic  | " make statusline invisible
  hi          StatusLineNC guifg=#2b2b30 guibg=bg      gui=italic  | " same with inactive statusline
  hi         StatusLineINC guifg=#2b2b30 guibg=#181320 gui=italic  | " add background to statusline if has neighboring window below
  hi           EndOfBuffer guifg=#1f1f31 guibg=bg                  | " make EndOfBuffer ('~' char) faint
  " hi            CursorLine ctermfg=12    guibg=#181320 guifg=NONE  | " change the color of the cursor line to suit my chosen bg color
  " hi          CursorLineNr guifg=#767676                           | " change the color of the cursor line to suit my chosen bg color
  hi             VertSplit guifg=bg      guibg=bg      gui=NONE    | " dont highlight vertical split
  hi            CursorLine guifg=NONE                              | " don't highlight current line
  hi        SignifySignAdd               guibg=bg                  | " dont add bacground to git diff signs
  hi     SignifySignChange               guibg=bg                  | " dont add bacground to git diff signs
  hi     SignifySignRemove               guibg=bg                  | " dont add bacground to git diff signs
  hi          GitGutterAdd               guibg=bg                  | " dont add bacground to git diff signs
  hi       GitGutterChange               guibg=bg                  | " dont add bacground to git diff signs
  hi       GitGutterRemove               guibg=bg                  | " dont add bacground to git diff signs
  hi            DiffChange ctermfg=203   guifg=#9FC267
  hi              Function cterm=bold    gui=bold
  hi             Statement cterm=bold    gui=bold
  hi                String                             gui=italic

  " tabline
  hi           TabLineFill guifg=#39373b guibg=bg gui=none
  call utils#color#copy_hi_group('Statement', 'TablineSel')
  hi            TabLineSel guibg=#181320            gui=bold

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
  let _theme = getenv("_THEME")
  exe 'set bg=' . (_theme != v:null ? _theme : 'dark')
endif

" vim: sw=2 sts=2 tw=0 fdm=marker
