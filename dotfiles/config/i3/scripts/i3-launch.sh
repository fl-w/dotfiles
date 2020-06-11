#!/usr/bin/env sh

COLOR_RED='\033[0;31m'
print_err() { local message=$1 && shift; printf "${COLOR_RED}ERROR:$COLOR_RESET $message\n" "$@"; }

if [[ -z "$1" ]]; then
  echo "Usage: $0 <dot>"
  exit 1
fi

dot="$1" && shift;
search_in=($HOME/. $HOME/.config/ $HOME/.local/share/)

dot_dir=
for dir in ${search_in[@]}; do
  if [[ -d $dir$dot ]]; then dot_dir=$dir$dot; break; fi
done

[[ -z "$dot_dir" ]] && print_err "no config dir found for $dot" && exit 1
[[ -z "$dot_dir/launch.sh" ]] && print_err "no launch.sh found in $dot_dir" && exit 1

echo "launching $dot" && $dot_dir/launch.sh $@ >/dev/null 2>&1
