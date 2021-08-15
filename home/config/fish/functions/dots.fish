function dots --description "Open a rofi menu if all dots in ~/.dotfiles"
  set -l dothome ~/opt/dotfiles
  for d in $dothome/home/*/*/  $dothome/root/*/*/
    echo $d
  end \
  | fzf -m --preview="$FZF_PREVIEW_COMMAND 2> /dev/null" --preview-window noborder --reverse --preview-window=right:50% | xargs -I % $EDITOR %
end
