function kheme -a theme --description "set kitty theme"
    if test -z $theme
        pushd $conf/kitty/themes
        if ! fzf --preview 'head -n 40 {} && kitty @ set-colors -a -c {}'
            kitty @ set-colors --reset
        end
        popd
    else
        kitty @ set-colors -a -c $conf/kitty/themes/$theme.conf
    end


end
