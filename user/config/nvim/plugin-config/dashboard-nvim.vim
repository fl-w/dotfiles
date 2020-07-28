" dashboard-nvim configuration.
"


let g:dashboard_custom_header = [
    \ '',
    \
    \ '          ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
    \ '          ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
    \ '          ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
    \ '          ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
    \ '          ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
    \ '          ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
    \ '',
    \ '',
    \ "    .o oOOOOOOOo                                            0OOOo",
    \ "    Ob.OOOOOOOo  OOOo.      oOOo.                      .adOOOOOOO",
    \ "    OboO000000000000.OOo. .oOOOOOo.    OOOo.oOOOOOo..0000000000OO",
    \ "    OOP.oOOOOOOOOOOO 0POOOOOOOOOOOo.   `0OOOOOOOOOP,OOOOOOOOOOOB'",
    \ "    `O'OOOO'     `OOOOo\"OOOOOOOOOOO` .adOOOOOOOOO\"oOOO'    `OOOOo",
    \ "    .OOOO'            `OOOOOOOOOOOOOOOOOOOOOOOOOO'            `OO",
    \ "    OOOOO                 '\"OOOOOOOOOOOOOOOO\"`                oOO",
    \ "   oOOOOOba.                .adOOOOOOOOOOba               .adOOOOo.",
    \ "  oOOOOOOOOOOOOOba.    .adOOOOOOOOOO@^OOOOOOOba.     .adOOOOOOOOOOOO",
    \ "  OOOOOOOOOOOOOOOOO.OOOOOOOOOOOOOO\"`  '\"OOOOOOOOOOOOO.OOOOOOOOOOOOOO",
    \ "    :            .oO%OOOOOOOOOOo.OOOOOO.oOOOOOOOOOOOO?         .",
    \ "    Y           'OOOOOOOOOOOOOO: .oOOo. :OOOOOOOOOOO?'         :`",
    \ "    .            oOOP\"%OOOOOOOOoOOOOOOO?oOOOOO?OOOO\"OOo",
    \ "                 '%o  OOOO\"%OOOO%\"%OOOOO\"OOOOOO\"OOO':",
    \ "                      `$\"  `OOOO' `O\"Y ' `OOOO'  o             .",
    \ "    .                  .     OP\"          : o     .",
    \ "",
    \ ]

let g:dashboard_default_executive = 'fzf'

let g:dashboard_custom_shortcut = {
\ 'last_session'       : 'SPC s l',
\ 'find_history'       : 'SPC f h',
\ 'find_file'          : 'SPC f f',
\ 'change_colorscheme' : 'SPC . c',
\ 'find_word'          : 'SPC f a',
\ 'book_marks'         : 'SPC f b',
\ }

function! s:dashboard_init() abort
    call utils#nonwrite_buffer_init()
endfunction

augroup dashboard_init
    autocmd!
    autocmd User dashboardReady let &l:stl = ' This statusline rocks!'
augroup END
