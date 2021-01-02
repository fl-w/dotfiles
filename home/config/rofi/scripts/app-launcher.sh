#!/usr/bin/env bash

PROGRAM_NAME=$(basename "$0")

# options
DEFAULT_MODI=drun
RELATIVE_PATH=themes

VARIANT=
SIDEBAR_MODE=
THEME=main
SIDE=
FULLSCREEN=
ICONS=
MODI=

print_help() {
  echo "Show a menu in rofi"
  echo
  echo "Usage: $0 [ options ... ]"
  echo "optional arguments:"
  echo " -h, --help                   show this help text"
  echo " -m, --show-mode              select all packages."
  echo " -b, --sidebar                sidebar variant."
  echo " -s, --switcher               add the window modi."
  echo " -r, --right                  show the menu on the right."
  echo " -l, --left                   show the menu on the left."
  echo " -v, --variant \"name\"         run variant of theme."
  echo " -p, --path \"path\"            relative path to theme directory."
  echo " -f, --fullscreen             show menu in fullscreen."
  echo

  exit
}

# if [ $# -eq 0 ]; then
#   print_help
# fi
print_err() { local m=$1 && shift; printf "\033[0;31mERROR:\033[0m $m\n" "$@"; exit 1; }

set_opt() {
  if [ "$2" ]; then
    eval $1="$2"
  else
    print_err "No argument supplied for $1. (default: ${!1})"
  fi
}

add_modi() {
  if [ "$MODI" ]; then
    MODI="$MODI,$1"
  else
    MODI="$1"
  fi
}

check() {
  [ ! "$THEME_NAME" ] && THEME_NAME="$THEME"

  for f in $HOME/.config/rofi/$RELATIVE_PATH/"$THEME_NAME$1"*.rasi ; do
    [ -e "$f" ] && THEME_NAME="$THEME_NAME$1" && return || break
  done
  return 1
}

while [ "$1" ]; do
  case "$1" in
    -h|--help)
      print_help;;
    -m|--modes|--tabs) SIDEBAR_MODE="-sidebar-mode";;
    -f|--fullscreen) FULLSCREEN="-fullscreen";;
    -i|--icons) ICONS="-show-icons";;
    -r|--right) SIDE="-r";;
    -l|--left) SIDE= ;;
    -b|--sidebar) VARIANT="sb";;
    -s|--switcher|--window) add_modi window;;
    -k|--keys) add_modi keys;;
    -d|--drun) add_modi drun;;
    -s|--ssh) add_modi ssh;;
    -c|--combi) add_modi combi;;
    --show) set_opt SHOW $2 && shift;;
    -v|--variant)
      set_opt VARIANT $2 && shift;;
    -p|--path)
      set_opt RELATIVE_PATH $2 && shift;;
    -t|--theme)
      set_opt THEME $2 && shift;;
  esac; shift
done

type rofi > /dev/null || { echo "Executable \"rofi\" not in PATH or installed, aborting." && exit 1; }

[ "$VARIANT" ] && VARIANT=.$VARIANT
check $VARIANT || { echo "Variant \"${VARIANT#?}\" doesn't exist." && exit 1; }

[ "$SIDE" ] && SIDE_NAME="right" || SIDE_NAME="left"; \
  check $SIDE || { echo "Theme side $SIDE_NAME doesn't exist for theme $THEME:${VARIANT:-default}." && exit 1; }

if [ ! "$MODI" ]; then
  MODI=$DEFAULT_MODI
fi

rofi -theme "$RELATIVE_PATH/$THEME_NAME" -modi $MODI -show ${SHOW:-${MODI##*,}} $SIDEBAR_MODE $FULLSCREEN $ICONS

    # elif [ "$1" = "-f" ]; then
    #   rofi -show combi -hide-scrollbar -line-margin 15 \
    #     -columns 3 -bw 0 -eh 2 -show-icons -fullscreen
    # else
    #   echo "syntax: launcher [-f]"
# fi
