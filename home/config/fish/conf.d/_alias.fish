# set LS_COLORS dxfxcxdxbxegedabagacad

[ -f "$XDG_CONFIG_HOME/sh/alias" ]
    and . "$XDG_CONFIG_HOME/sh/alias"


alias df 'df -m'
alias ll 'ls -gaG'
alias ls 'ls -h --color=auto --group-directories-first'
alias su 'su -m'
alias grep 'grep --color=auto'
# alias yay 'yay -noupgrademenu --noeditmenu --nodiffmenu --nocleanmenu'

abbr ss 'sudo systemctl'
abbr se 'sudoedit'


abbr j jobs
abbr c clear; abbr cl clear
abbr v nvim; abbr nv nvim
abbr g git
abbr h history

abbr gs git s
abbr gp git push
abbr gd git diff
abbr gb git branch

abbr cd.. 'cd ..'
abbr .. 'cd ..'
abbr ... 'cd ../..'
abbr .... 'cd ../../..'
abbr ..... 'cd ../../../..'

abbr home 'cd $HOME'

abbr cx 'chmod +x'
abbr 'c-x' 'chmod -x'

abbr ex 'exit'
abbr q  'exit'

abbr slblk 'sudo lsblk -o name,mountpoint,label,size,uuid'

abbr ei 'nvim $conf/i3'
abbr ef 'nvim $conf/fish'
abbr ek 'nvim $conf/kitty'
abbr ev 'nvim $conf/nvim'
abbr ep 'nvim $conf/polybar'

if has zzz; abbr ZZZ 'zzz -Z'; end

if has kitty; alias icat 'kitty +kitten icat --align left'; end

if has xclip
    alias clip 'xclip -selection c'
    alias clop 'xclip -selection clipboard -o'
end
