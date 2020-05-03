function dots --description "Open a rofi menu if all dots in ~/.dotfiles"
  for d in ~/.dotfiles/*/
    echo $d
  end \
  # rofi -dmenu -location 2 -yoffset 30 -width 200 -auto-select
  | fzf -m | xargs -I % $EDITOR %
end
