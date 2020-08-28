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
      \ 'toggle_drawer'      : 'SPC d',
      \ 'find_history'       : 'SPC f h',
      \ 'find_file'          : 'SPC f f',
      \ 'find_word'          : 'SPC f w',
      \ 'last_session'       : 'SPC s l',
      \ 'change_colorscheme' : 'SPC . c',
      \ 'book_marks'         : 'SPC f b',
      \ }

let g:dashboard_custom_section = {
      \ 'buffer_list': [' Recently lase session                 SPC b b'],
      \ 'find_file': []
      \}

function! s:dashboard_init() abort
  call utils#nonwrite_buffer_init()
endfunction

augroup dashboard_init
  autocmd!
  autocmd User dashboardReady let &l:stl = ' This statusline rocks!'
  " I like the dashboard commands over my fzf bindings
  " 20/8/2020: the :DashboardFind commands use override global
  " fzf vars hence my config
  autocmd filetype dashboard call utils#init_minimal_window()
        \| nnoremap <buffer> <esc> :bd
  " \| nnoremap <buffer> <space>fw :DashboardFindWord<cr>
  " \| nnoremap <buffer> <space>fh :DashboardFindHistory<cr>
  " \| nnoremap <buffer> <space>ff :DashboardFindFile<cr>
  " \| nnoremap <buffer> <space>fb :DashboardJumpMarks<cr>
  autocmd VimEnter * if !argc() | Dashboard | endif
augroup END

" vim: sw=2 sts=2 tw=0 fdm=marker
