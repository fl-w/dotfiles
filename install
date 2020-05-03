#!/bin/bash

#######################################
PACMAN='/usr/bin/pacman -S --needed' # can be replaced with apt or package man or distro.
PKG_PIP='python-pip'
PKG_PIP2='python2-pip'

#######################################
# Do not edit after this line unless you know what you are doing

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &>/dev/null && pwd )"
if [[ "$1" != "" ]]; then
    PACMAN="$1"
fi

PROGRAM_NAME=$(basename "$0")
VERBOSE=0

# Colors
Red='\033[0;31m'
Green='\033[0;32m'
Yellow='\033[0;33m'
Cyan='\033[0;36m'
# Reset
Reset='\033[0m'


function print_info() {
  message=$1 && shift
  printf "\n$Cyan$message$Reset\n" "$@"
}

function print_warning() {
  message=$1 && shift
  printf "\n${Yellow}WARN:$Reset $message\n" "$@"
}

function print_success() {
  message=$1 && shift
  printf "\n${Green}SUCCESS:$Reset $message\n" "$@"
}

function print_err() {
  message=$1 && shift
  printf "\n${Red}ERROR:$Reset $message\n" "$@"
}

function bool_of() {
  if $1
  then
    return 0
  else
    return 1
  fi
}

function require_yay() {
  [ ! -f "/usr/bin/yay" ] && {
    $temp=$(pwd)
    cd /tmp
    git clone https://aur.archlinux.org/yay.git && cd yay
    makepkg -si
    cd $temp
  } || {
    printf ''
  }
}

[ "${1:-}" = "--" ] && shift

function show_help() {
  if [ -n "$1" ]; then
    print_err "$1"
  fi

   # Display Help
   echo "Install and stow dots in home directory" >&2
   echo
   echo "Usage: $PROGRAM_NAME [ options ... ] [ ALL|PACKAGES ... ]"
   echo "options:"
   echo " -h, --help             show this help text"
   echo " -v  --verbose          run in verbose mode."
   echo
}

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
  local pkg=$1
  local deps=$2

  local pkgs=${deps[pkgs]}
  local py_pkgs=${deps[py]}
  local node=${deps[node]}

  success=true

  [ ! -z "$pkgs" ] && install_pkgs $pkgs || success=false
  [ ! -z "$py_pkgs" ] && require_pip && pip install --user $py_pkgs &>/dev/null || success=false
  [ ! -z "$node" ] && require_node && npm install -g i $node || success=false

  $success && print_success "%s dependencies installed" $pkg && return 0 || return 1
}

parse_args() {
  while [[ "$#" > 0 ]]; do case $1 in


    -v|--verbose) VERBOSE=1;;
    -h|--help) show_help; exit 0;;
    *) show_help "Unknown parameter: $1"; exit 1;;

  esac; shift; done
}

main() {
  trap "exit" INT
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

parse_args "$@"
main
