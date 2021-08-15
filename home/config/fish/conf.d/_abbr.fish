abbr ss 'sudo systemctl'
abbr se 'sudoedit'

abbr ex exit
abbr q  exit

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

if has zzz
    abbr zz sudo zzz
    abbr Z sudo zzz
    abbr zzr sudo zzz -R
    abbr ZZZ zzz -Z
end

if has kitty; alias icat 'kitty +kitten icat --align left'; end
