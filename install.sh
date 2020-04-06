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
  nvim

  dunst
  polybar
  rofi
  wal
  flashfocus
  firefox
  doom-emacs

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

require_node() {
  if which npm >/dev/null 2>&1 || [ ! -f /usr/bin/npm ] || install_node
    then
      return 1
    else
      return 0
  fi
}

install_node() {
  if curl -L https://raw.githubusercontent.com/tj/n/master/bin/n -o n && bash n lts
  then
    return 1
  else
    return 0
  fi
}

require_pip() {
  [ ! -f /usr/bin/pip ] || install_pkgs $PKG_PIP
}

install_deps() {
  pkg=$1
  deps=$2

  pkgs=${deps[pkgs]}
  py_pkgs=${deps[py]}
  node=${deps[node]}

  success=true

  [ ! -z "$pkgs" ] && install_pkgs $pkgs || success=false
  [ ! -z "$py_pkgs" ] && require_pip && pip install --user $py_pkgs &>/dev/null || success=false
  [ ! -z "$node" ] && require_node && npm install -g i $node || success=false

  $success && print_success "%s dependencies installed" $pkg && return 0 || return 1
}

main() {
  sudo -k

  typeset -A deps

  for pkg in ${PACKAGES[@]}; do
    if [ -f $ROOT_DIR/$pkg/deps ]
    then
      deps=(
        [pkgs]=""
        [py]=""
        [node]=""
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
    else
      print_info '%s has no deps -- skipping' $pkg
      continue
    fi

    echo ""
    stow -v --ignore deps --ignore post-install --dotfiles -d $ROOT_DIR -R $pkg 3>&1 1>&2 2>&3 3>&- | grep -- '=' && print_success 'stowed %s files.' $pkg

    if [ -f $ROOT_DIR/$pkg/post-install ]
    then
      $ROOT_DIR/$pkg/post-install
    fi
  done
}

main
