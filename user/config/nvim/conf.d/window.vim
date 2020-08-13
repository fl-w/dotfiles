" window.vim
"

" check if the animate manager plugin is loaded
if utils#is_plug_loaded('animate.vim')
  let s:ft_winsize = {}

  augroup sliding_window_ftdetect
    au WinNew * call s:on_new_win(winnr())
  augroup end

  fun! s:on_new_win(n)
    let ft = getwinvar(a:n, '&ft')
    if has_key(s:ft_winsize, ft)
      if winheight(a:n) + &cmdheight  + 1 != &lines
        let resize = ''
      elseif winwidth(a:n) != &columns
        echo
      else
        echohl WarningMsg | echo 'cannot slide, window is not in a valid split' | echohl NONE
    endif
  endif
  endf
endif
