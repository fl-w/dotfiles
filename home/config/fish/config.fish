# Disable fish greeting
set -g fish_greeting ''

# Open fish in vim-mode
fish_vi_key_bindings

# Set ls colors
set -gx LSCOLORS gxfxbEaEBxxEhEhBaDaCaD

set -gx theme_prompt_symbol 🢂

# Automatically install fundle (Warning: dangerous on bad connections)
if not functions -q fundle
  eval (curl -sfL https://git.io/fundle-install)
end

fundle plugin 'franciscolourenco/done'
fundle plugin 'fl-w/ortega'
fundle plugin 'jethrokuan/z'

fundle init

function add_path --argument bin
  [ -d $bin ]; and set --prepend PATH $bin
end

# Append Go bin dir to PATH
add_path $GOPATH/bin

# Append n directory to PATH
add_path $N_PREFIX/bin 

# Append bin dir to PATH
add_path $HOME/bin

# Append DART pub bin dir to PATH
add_path $HOME/.pub-cache/bin

# Append RUST cargo bin dir to PATH
add_path $CARGO_HOME/bin

# # Append the current directory to path
add_path .

# Append android-sdk & emulator to PATH
[ -d /opt/android-sdk ]
  and set -gx ANDROID_HOME /opt/android-sdk
  and set PATH $ANDROID_HOME/tools:$ANDROID_HOME/tools/bin $PATH
  and [ -d $ANDROID_HOME/emulator ]
    and set PATH $ANDROID_HOME/emulator $PATH

# Add xcursor path to env
[ -d ~/.local/share/icons ]; and set -x XCURSOR_PATH ~/.local/share/icons

# Setup kitty auto complete
[ -f /usr/bin/kitty ]; and kitty + complete setup fish | source

function _command --description "check if command is a command" --argument c
  command -v $c >/dev/null
  return $fish_status
end

# Set default bat command
_command bat; and set -g BAT_DEFAULT_COMMAND bat --color always --theme Dracula --style=header,changes --wrap never

# Set default ripgrep command
_command rg; and set -g RG_DEFAULT_COMMAND "rg --files --hidden -g '!.git/**' -g '!target/' -g '!Cargo.{toml,lock}' --ignore -l"

# Set FZF to use rg
if _command fzf
  # Set fzf preview to use bat if available, otherwise cat
  set -q BAT_DEFAULT_COMMAND
    and set _CAT $BAT_DEFAULT_COMMAND; or set _CAT cat

  set -g FZF_PREVIEW_COMMAND "$_CAT {} || head -n 60 {} || tree -a -C {}"

  # Set fzf to use preview in ctrl-t

  set -gx FZF_DEFAULT_OPTS --layout=default
  set -gx FZF_CTRL_T_OPTS $FZF_DEFAULT_OPTS --min-height 30 --preview-window down:60% --preview-window noborder --preview "'$FZF_PREVIEW_COMMAND 2>/dev/null'"

  set -q RG_DEFAULT_COMMAND
    and set -gx FZF_DEFAULT_COMMAND $RG_DEFAULT_COMMAND
    and set -gx FZF_CTRL_T_COMMAND "$RG_DEFAULT_COMMAND 2>/dev/null"
end

# pipenv completion
command -v pipenv >/dev/null && eval (pipenv --completion)

# Pipr binding
bind \ca run-pipr
