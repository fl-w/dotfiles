# set LS_COLORS dxfxcxdxbxegedabagacad

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

# stop wget from storing history
alias wget 'wget --no-hsts --hsts-file'


abbr ei 'nvim ~/.config/i3'
abbr ei3 'nvim ~/.config/i3'
abbr ef 'nvim ~/.config/fish'
abbr ev 'nvim ~/.config/nvim'
abbr ep 'nvim ~/.config/polybar'

