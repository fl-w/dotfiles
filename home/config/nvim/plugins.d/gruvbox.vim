" gruvbox config file
"

augroup gruv_color
    autocmd ColorScheme gruvbox call s:set_colors()
augroup end

fun s:set_colors() 
    hi CursorLineNr guibg=bg ctermbg=NONE
    hi! link LineNr EndOfBuffer
    call utils#color#copy_hi_group("GruvboxRedSign", "CocErrorSign")
    hi CocErrorSign guibg=bg ctermbg=NONE
endfu
