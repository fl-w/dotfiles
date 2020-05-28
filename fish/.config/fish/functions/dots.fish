function dots --description "Open a rofi menu if all dots in ~/.dotfiles"
  for d in ~/.dotfiles/*/
    echo $d
  end \
  # rofi -dmenu -location 2 -yoffset 30 -width 200 -auto-select
  | fzf -m --preview="$FZF_PREVIEW_COMMAND 2> /dev/null" --preview-window noborder --reverse --preview-window=right:50% | xargs -I % $EDITOR %
end
