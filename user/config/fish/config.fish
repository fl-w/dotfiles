## Fish config
#

# Start X at login
if status --is-login
  if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
    exec startx
  end
end

function _command --description "check if command is a command" --argument c
  command -v $c >/dev/null
  return $fish_status
end

# Disable fish greeting
set -gx fish_greeting ''

# Open fish in vim-mode
fish_vi_key_bindings

# Set env vars
set -gx GOPATH $HOME/.go
set -gx N_PREFIX $HOME/.n

# Set fish colors
set -gx LSCOLORS gxfxbEaEBxxEhEhBaDaCaD

# Set default editor to nvim
set -gx EDITOR /usr/bin/nvim

set -gx BROWSER /usr/bin/firefox

# Append local bin dir to PATH
set PATH $HOME/.local/bin $HOME/.bin $PATH

# Append DART pub bin dir to PATH
set PATH $HOME/.pub-cache/bin $PATH

# Append RUST cargo bin dir to PATH
set PATH $HOME/.cargo/bin $PATH

# Append Go bin dir to PATH
set PATH $GOPATH/bin $PATH

# Set n prefix to home
[ -d $N_PREFIX/bin ]; and set PATH $N_PREFIX/bin $PATH

# Append android-sdk & emulator to PATH
[ -d /opt/android-sdk ]; and set -gx ANDROID_HOME /opt/android-sdk
and set PATH $ANDROID_HOME/tools:$ANDROID_HOME/tools/bin $PATH
and [ -d $ANDROID_HOME/emulator ]; and set PATH $ANDROID_HOME/emulator $PATH

# Add xcursor path to env
[ -d ~/.local/share/icons ]; and set -x XCURSOR_PATH ~/.local/share/icons

# Setup kitty auto complete
[ -f /usr/bin/kitty ]; and kitty + complete setup fish | source

# Set default bat command
_command bat; and set -g BAT_DEFAULT_COMMAND bat --color always --theme dracula --style=header,changes --wrap never {}

# Set default ripgrep command
_command rg; and set -g RG_DEFAULT_COMMAND rg --files --hidden --ignore --follow -l -g '!{.npm,.cache,.n,node_modules,build,target,.git}'

# Set FZF to use rg
if _command fzf
  # Set fzf preview to use bat if available, otherwise cat
  set -q BAT_DEFAULT_COMMAND
    and set _CAT "$BAT_DEFAULT_COMMAND;" or set _CAT cat

  set -gx FZF_PREVIEW_COMMAND "$_CAT" 2>/dev/null || head -n 60 {} 2>/dev/null || tree -a -C {} 2>/dev/null

  # Set fzf to use preview in ctrl-t
  set -gx FZF_CTRL_T_OPTS --min-height 30 --preview-window down:60% --preview-window --noborder --preview "$FZF_PREVIEW_COMMAND"

  set -q RG_DEFAULT_COMMAND
    and set -gx FZF_DEFAULT_COMMAND $RG_DEFAULT_COMMAND
    and set -gx FZF_CTRL_T_COMMAND "$RG_DEFAULT_COMMAND" -g '!{.ssh,*private,*local,.bash_history}'
end

# Import aliases
[ -f conf.d/aliases.fish ]; and . conf.d/aliases.fish

# pipenv completion
command -v pipenv >/dev/null && eval (pipenv --completion)

# Pipr binding
bind \ca run-pipr

# set pywal colors
[ -f ~/.cache/wal/sequences ]
# and cat ~/.cache/wal/sequences &
# todo: write pywal colors.fish and source
