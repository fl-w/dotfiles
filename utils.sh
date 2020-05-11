#!/bash/bin

# Colors {{{
COLOR_RED='\033[0;31m'

COLOR_GREEN='\033[0;32m'

COLOR_YELLOW='\033[0;33m'

COLOR_CYAN='\033[0;36m'

COLOR_RESET='\033[0m'
# }}}

# +++++++++++++++++++++++++++++++++++++++++++ {{{
# + helper functions
# +

function prompt () {
  local prompt=$1
  local default=${2:0:1}

  if [[ ! -z "$default" ]] && ! [[ $default =~ [YNyn] ]]; then
    default=
  fi

  while true; do
      read -p "$prompt [Y/n]: " yn
      if [[ -z "$yn" ]]; then yn=$default; fi

      case $yn in
          [Yy]* ) return 0;;
          [Nn]* ) return 1;;
          *) echo "Please answer yes or no.";;
      esac
  done
}

function require() {
  if command -v $1 >/dev/null; then
    print_debug "$1 found in %s" $(command -v $1)
  else
    print_warning "$1 is required to continue."

    if ! test -z $2 && prompt "Would you like to install $1?" "y"; then
      shift; $@ || return 1
    else
      return 1
    fi
  fi
}

function join_by { local IFS="$1"; shift; echo "$*"; }

function print_info() { local message=$1 && shift; printf "$COLOR_CYAN[*] $message$COLOR_RESET\n" "$@"; }

function print_warning() { local message=$1 && shift; printf "${COLOR_YELLOW}WARN:$COLOR_RESET $message\n" "$@";  }

function print_success() { local message=$1 && shift; printf "${COLOR_GREEN}SUCCESS:$COLOR_RESET $message\n" "$@"; }

function print_err() { local message=$1 && shift; printf "${COLOR_RED}ERROR:$COLOR_RESET $message\n" "$@"; }

function print_debug() {
  if [[ "$VERBOSE" -gt 1 ]]; then
    message=$1 && shift; printf "$COLOR_YELLOW[*] $message$COLOR_RESET\n" $@
  fi
}

function verbose_command() {
  if [ $VERBOSE -eq 2 ]; then
    "$@"
  else
    "$@" >/dev/null 2>&1
  fi
  return $?
}

install_node() {
  if curl -L https://raw.githubusercontent.com/tj/n/master/bin/n -o $TEMP_DIR/n && bash $TEMP_DIR/n lts
  then
    return 1
  else
    return 0
  fi
}

install_pip() {
  require curl || return 1

  if is_using_arch; then
    sudo $installer python-pip
  else
    curl https://bootstrap.pypa.io/get-pip.py -o $TEMP_DIR/get-pip.py && python get-pip.py && \
        print_success "installed python"
  fi
  return $?
}

install_yay() {
  require tar || return 1
  require curl || return 1

  verbose_command curl https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz --output $TEMP_DIR/package || { print_warning "could not clone yay repo"; }
  tar -xf $TEMP_DIR/package -C $TEMP_DIR

  pushd $TEMP_DIR/yay >/dev/null
  makepkg -si

  popd >/dev/null
}

select_options() {
  checked_char="●"
  unchecked_char="○"
  prompt="${1-'Check an option'} (again to uncheck, ENTER when done): "; shift

  [[ "$1" -eq 1 ]] && { x=${#@}; for i in $(seq 0 $((x - 1))); do choices[i]=$checked_char; done; shift; }
  options=("$@")

  menu() {
      echo "Avaliable options:  $checked_char-checked   $unchecked_char-unchecked"
      for i in ${!options[@]}; do
          printf "%3d) %s %s\n" $((i+1)) "${choices[i]:-$unchecked_char}" "${options[i]}"
      done
      [[ "$msg" ]] && echo "$msg"; :
  }

    if [[ ${#options[@]} -gt 0 ]]; then
    while menu && read -rp "$prompt" num && [[ "$num" ]]; do
        [[ "$num" != *[![:digit:]]* ]] &&
        (( num > 0 && num <= ${#options[@]} )) ||
        { msg="Invalid option: $num"; continue; }
        ((num--)); msg="${options[num]} was ${choices[num]:+un}checked"
        [[ "${choices[num]}" ]] && choices[num]="" || choices[num]=$checked_char
    done
  fi

  selected=()
  for i in ${!options[@]}; do
      [[ "${choices[i]}" ]] && { msg="$msg ${options[i]}"; selected+=(${options[i]}); }
  done

  print_debug "You selected${msg-" nothing"}"
}

function get_list_opt() {
  local opt=$1
  local delimiter=${2-,}

  echo $opt | tr "${delimiter:0:1}" ' '
}

# +
# +
# }}}
