#!/bin/bash
. utils.sh


#######################################
# Edit array ...
PACKAGES=(
  bash
  fish

  i3
  picom

  kitty

  dunst
  polybar
  rofi
  wal
  flashfocus
  firefox
  doom-emacs
  kitty
  wallpapers
)

PACMAN='/usr/bin/pacman -S --needed' # can be replaced with apt or package man or distro.
PKG_PIP='python-pip'
PKG_PIP2='python2-pip'

#######################################

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &>/dev/null && pwd )"
if [[ "$1" != "" ]]; then
    PACMAN="$1"
fi

install_pkgs() {
  sudo $PACMAN $pkgs &>/dev/null
}

install_deps() {
  pkg=$1
  deps=$2

  pkgs=${deps[pkgs]}
  py_pkgs=${deps[py_pkgs]}


  [ ! -z $pkgs ] && install_pkgs $pkgs
  [ ! -z $py_pkgs ] && ( [ ! -f /usr/bin/pip ] || install_pkgs $PKG_PIP ) && pip install --user $py_pkgs &>/dev/null

  print_success "i3 dependencies installed" $pkg
}

main() {
  typeset -A deps

  for pkg in ${PACKAGES[@]}; do
    if [ ! -f $ROOT_DIR/$pkg/deps ]
    then
      print_info '%s has no deps -- skipping' $pkg
      continue
    fi

    deps=(
      [pkgs]=""
      [py_pkgs]=""
      [alt_pkgs]=""
    )

    while read line
    do
      if echo $line | grep -F = &>/dev/null
      then
        deps[$(echo "$line" | cut -d '=' -f 1)]=$(echo "$line" | cut -d '=' -f 2-)
      fi
    done < $ROOT_DIR/$pkg/deps

    install_deps $pkg $deps

    stow -v -R $pkg -d $ROOT_DIR 3>&1 1>&2 2>&3 3>&- | grep -- '=' && print_success 'stowed i3 files.'
  done
}

main
