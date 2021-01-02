" vim: sw=2 sts=2 tw=0 fdm=marker
"
"    .o oOOOOOOOo                                            0OOOo
"    Ob.OOOOOOOo  OOOo.      oOOo.                      .adOOOOOOO
"    OboO000000000000.OOo. .oOOOOOo.    OOOo.oOOOOOo..0000000000OO
"    OOP.oOOOOOOOOOOO 0POOOOOOOOOOOo.   `0OOOOOOOOOP,OOOOOOOOOOOB'
"    `O'OOOO'     `OOOOo"OOOOOOOOOOO` .adOOOOOOOOO"oOOO'    `OOOOo
"    .OOOO'            `OOOOOOOOOOOOOOOOOOOOOOOOOO'            `OO
"    OOOOO                 '"OOOOOOOOOOOOOOOO"`                oOO
"   oOOOOOba.                .adOOOOOOOOOOba               .adOOOOo.
"  oOOOOOOOOOOOOOba.    .adOOOOOOOOOO@^OOOOOOOba.     .adOOOOOOOOOOOO
"  OOOOOOOOOOOOOOOOO.OOOOOOOOOOOOOO"`  '"OOOOOOOOOOOOO.OOOOOOOOOOOOOO
"    :            .oO%OOOOOOOOOOo.OOOOOO.oOOOOOOOOOOOO?         .
"    Y           'OOOOOOOOOOOOOO: .oOOo. :OOOOOOOOOOO?'         :`
"    .            oOOP"%OOOOOOOOoOOOOOOO?oOOOOO?OOOO"OOo
"                 '%o  OOOO"%OOOO%"%OOOOO"OOOOOO"OOO':
"                      `$"  `OOOO' `O"Y ' `OOOO'  o             .
"    .                  .     OP"          : o     .
"

let $VIM_ROOT = expand('<sfile>:p:h')
let $VIM_DATA_ROOT = expand(stdpath('data')) 

let g:vim_ignore_configs_list = ['ale']
let g:is_darwin = has('win32') || has('win64')
let g:is_linux = has('unix') && !has('macunix')

if has('vim_starting')
  runtime general.vim
endif

runtime! plugins.vim
runtime! maps/*.vim

if exists('g:started_by_firenvim') && g:started_by_firenvim
  runtime clients/firenvim.vim " firenvim specific configuration

elseif exists('g:vscode')
  runtime clients/vscode.vim   " vscode specific configuration

else
  runtime! conf.d/*.vim

  " load plugin configs
  let g:plug_configs = map(filter(copy(g:plugs_order), {_, val -> index(g:vim_ignore_configs_list, val) == -1}),
        \ '"plugins.d/" . tolower(fnamemodify(v:val, ":r")) . ".vim"')
  for s:plug in g:plug_configs
    exe 'runtime' s:plug
  endfor
endif

if exists('*utils#abbr_command')
  call utils#abbr_command('rc', 'so $MYVIMRC') " use :rc to resource this file
endif
