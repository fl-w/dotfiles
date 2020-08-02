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

set background=dark                                | " set background to be dark
set synmaxcol=300                                  | " use syntax highlighting only for 300 columns

fu! s:get_color_scheme()
  return get(g:, 'colors_name', 'default')
endfu

fu! s:set_colors() abort
  let l:color_scheme = s:get_color_scheme()

  if &background == 'light' | return | endif

  call utils#color#copy_hi_group('DiffAdd', 'SignifySignAdd')
  call utils#color#copy_hi_group('DiffChange', 'SignifySignChange')
  call utils#color#copy_hi_group('DiffRemove', 'SignifySignRemove')

  hi                LineNr ctermbg=NONE  guibg=NONE                | " dont highlight line number
  hi            SignColumn ctermbg=NONE  guibg=NONE                | " dont highlight sign column
  hi                Normal ctermbg=NONE  guibg=NONE                | " stop theme from setting bg color
  hi HighlightedyankRegion ctermbg=0     guibg=#13354A             | " change yank highlight color
  hi               Comment ctermfg=239   guifg=#4E4E4E gui=italic  | " change comment color and set to italic
  hi            StatusLine guifg=#4E4E4E guibg=bg      gui=italic  | " make statusline invisible
  hi          StatusLineNC guifg=#2b2b30 guibg=bg      gui=italic  | " same with inactive statusline
  hi           EndOfBuffer guifg=#1f1f31 guibg=bg                  | " make EndOfBuffer ~ faint
  hi             VertSplit guifg=bg      guibg=bg                  | " dont highlight vertical split
  hi        SignifySignAdd               guibg=bg                  | " dont add bacground to git diff signs
  hi     SignifySignChange               guibg=bg                  | " dont add bacground to git diff signs
  hi     SignifySignRemove               guibg=bg                  | " dont add bacground to git diff signs
  hi            DiffChange ctermfg=203   guifg=#FF5270             | " make diff remove distintive red
  hi              Function cterm=bold    gui=bold
  hi               Keyword cterm=bold    gui=bold
  hi             Statement cterm=bold    gui=bold

  " #181320 bg #847d91

  " todo
  highlight default link WhichKey          Function
  highlight default link WhichKeySeperator DiffAdded
  highlight default link WhichKeyGroup     Keyword
  highlight default link WhichKeyDesc      Identifier
  highlight default link WhichKeyFloating Pmenu

  if l:color_scheme != 'ayu'
    hi          Pmenu ctermfg=243 ctermbg=237  guifg=#767676 guibg=#2b2b30
    hi       PmenuSel ctermfg=140 ctermbg=237  guifg=#a790d5 guibg=#2b2b30 gui=bold
    hi      PmenuSbar ctermfg=28  ctermbg=233  guifg=#c269fe guibg=#303030
    hi     PmenuThumb ctermfg=160 ctermbg=97   guifg=#e0211d guibg=#875faf
  endif

  if l:color_scheme == 'badwolf'
    hi DiffAdd guifg=#B8CC52
    hi DiffChange guifg=#36A3D9
  endif

  if index(['material', 'palenight', 'badwolf'] , s:get_color_scheme()) != -1
    hi         String ctermfg=140             guifg=#a790d5
  endif
endfu

augroup colorscheme_detect
  au!
  au BufRead,BufNewFile *.conf setf dosini                        | " syntax highlighting for .conf
  au BufRead,BufNewFile *.rasi setf css                           | " syntax highlighting for .rasi
  au ColorScheme        *      call <SID>set_colors()             | " set colors on color scheme change
  au BufEnter           *      syntax sync fromstart              | " accurate syntax highlighting
  au FileType           json   syntax match Comment +\/\/.\+$+    | " allow comments in json files
augroup END

if has('vim_starting')
  colo ayu
  " colo badwolf
endif
