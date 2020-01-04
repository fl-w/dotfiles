function fish_right_prompt --description 'Write out the right side of prompt'
    set_color $fish_color_cwd
    printf '%s' (echo $PWD | sed -e "s|^$HOME|~|" -e 's|^/private||' -e 's|~/src/||')
    set_color normal

    git_prompt

    if set -q fish_prompt_timestamp_shown
      _show_timestamp
    end

end

function _show_timestamp -d 'Prints a human-readable timestamp in fish_color_cwd'
    set_color $fish_color_cwd
    printf ' %s' (date +%H:%M:%S)
    echo
end


function git_current_branch -d 'Prints a human-readable representation of the current branch'
  set -l ref (git symbolic-ref HEAD 2>/dev/null; or git rev-parse --short HEAD 2>/dev/null)
  if test -n "$ref"
    echo $ref | sed -e s,refs/heads/,,
    return 0
  end
end

function git_prompt
    if git rev-parse --show-toplevel >/dev/null 2>&1
        set_color normal
        printf ' on '
        set_color yellow
        printf '%s' (git_current_branch)
        set_color green
        #git_prompt_status
        set_color normal
    end
end
