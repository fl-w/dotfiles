" vim-startify configuration
"

let g:startify_change_to_dir       = 0
let g:startify_custom_header       = 'startify#pad(startify#fortune#boxed())'
let g:startify_enable_special      = 0
let g:startify_fortune_use_unicode = 1
let g:startify_update_oldfiles     = 1
let g:startify_use_env             = 1

let g:startify_custom_footer =
      \ startify#center(['', "   Vim is charityware. Please read ':help uganda'.", ''])
function! s:list_commits()
let git = 'git -C ~/repo'
let commits = systemlist(git .' log --oneline | head -n10')
let git = 'G'. git[1:]
return map(commits, '{"line": matchstr(v:val, "\\s\\zs.*"), "cmd": "'. git .' show ". matchstr(v:val, "^\\x\\+") }')
endfunction

let g:startify_lists = [
      \ { 'header': ['   MRU'],            'type': 'files' },
      \ { 'header': ['   MRU '. getcwd()], 'type': 'dir' },
      \ { 'header': ['   Sessions'],       'type': 'sessions' },
      \ { 'header': ['   Commits'],        'type': function('s:list_commits') },
      \ ]

let g:startify_custom_header = startify#center([
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
    \ ])

" vim: sw=2 sts=2 tw=0 fdm=marker
