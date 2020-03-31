#!/bin/bash

# Reset
Reset='\033[0m'

# Colors
Red='\033[0;31m'
Green='\033[0;32m'
Yellow='\033[0;33m'
Cyan='\033[0;36m'

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
