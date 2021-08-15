function conf -d "open directory in config home with editor" -a name
  begin
    set -q name
    and echo $conf/$name
    or echo $conf/*/ | string split ' /' | fzf -m $FZF_CTRL_T_OPTS
  end | xargs -I % $EDITOR %
end
