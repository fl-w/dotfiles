" vim: sw=2 sts=2 tw=0
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

let $VIM_ROOT = expand('<sfile>:h')
let $VIM_DATA_ROOT = stdpath('data')

let g:is_darwin = has('win32') || has('win64')
let g:is_linux = has('unix') && !has('macunix')
let g:is_work = !empty($WORK_MACHINE)
let g:vim_ignore_configs = ['ale']

if has('vim_starting')
  runtime settings.vim
endif

runtime maps/keys.vim

if exists('g:started_by_firenvim') && g:started_by_firenvim
  runtime clients/firenvim.vim " firenvim specific configuration

elseif exists('g:vscode')
  runtime clients/vscode.vim   " vscode specific configuration

elseif exists('g:ideavim')
  runtime clients/idea.vim     " intellij idea specific configuration

let $VIM_ROOT = expand('<sfile>:p:h')
else
  runtime plugins.vim

  runtime conf.d/events.vim
  runtime conf.d/abbr.vim
  runtime conf.d/colorscheme.vim

  runtime maps/which-key.vim

  " load plugin configs
  let g:plug_configs = map(
        \   filter( copy(g:plugs_order), { _, val -> index(g:vim_ignore_configs, val) == -1 } ),
        \   '"plugins.d/" . tolower(substitute(fnamemodify(v:val, ":r"), "\\.", "-", "")) . ".vim"'
        \)
  for s:plug in g:plug_configs
    exe 'runtime' s:plug
  endfor
endif

if exists('*utils#abbr_command')
  call utils#abbr_command('rc', 'so $MYVIMRC') " use :rc to resource this file
endif

" load external init.lua file whilst nvim is nightly
if has('nvim-0.5')
  runtime lua/init-nightly.lua
end
