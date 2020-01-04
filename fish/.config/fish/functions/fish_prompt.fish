function fish_prompt
    set last_status $status

    if test $last_status -ne 0
        set_color $fish_color_error
        printf '[%d] ' $last_status
        set_color normal
    end

    set_color magenta
    printf '🢂 '
    set_color normal
end
