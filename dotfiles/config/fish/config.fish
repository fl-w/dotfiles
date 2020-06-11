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

# Set fish colors
set -gx LSCOLORS gxfxbEaEBxxEhEhBaDaCaD

# Set default editor to nvim
set -gx EDITOR /usr/bin/nvim

# Append local bin dir to PATH
set PATH $HOME/.local/bin $HOME/.bin $PATH

# Append DART pub bin dir to PATH
set PATH $HOME/.pub-cache/bin $PATH

# Append android-sdk & emulator to PATH
[ -d /opt/android-sdk ]; and set -x ANDROID_HOME /opt/android-sdk
and set PATH $ANDROID_HOME/tools:$ANDROID_HOME/tools/bin $PATH
and [ -d $ANDROID_HOME/emulator ]; and set PATH $ANDROID_HOME/emulator $PATH

# Add xcursor path to env
[ -d ~/.local/share/icons ]; and set -x XCURSOR_PATH ~/.local/share/icons

# Setup kitty auto complete
[ -f /usr/bin/kitty ]; and kitty + complete setup fish | source

# Set default bat command
_command bat; and set -g BAT_DEFAULT_COMMAND "bat --color always --theme DarkNeon --style=header,grid,changes --wrap never {} "
# Set FZF to use rg
_command fzf
and set -gx FZF_PREVIEW_COMMAND "$BAT_DEFAULT_COMMAND 2>/dev/null || head -n 60 {} 2>/dev/null || tree -a -C {} 2>/dev/null"
and set -gx FZF_CTRL_T_OPTS "--min-height 30 --preview-window down:60% --preview-window noborder --preview '$FZF_PREVIEW_COMMAND'"
and _command rg
and set -gx FZF_DEFAULT_COMMAND 'rg --hidden --ignore -l -g "!{.npm,.cache,.n,node_modules,build,target,.git,plugged}" -e ""'
and set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND -g '!{.ssh,*private,*local,.bash_history}' "

# Import aliases
[ -f conf.d/aliases.fish ]; and . conf.d/aliases.fish

# Set n prefix to home
set -gx N_PREFIX $HOME/.n
[ -d $N_PREFIX/bin ]; and set PATH $N_PREFIX/bin $PATH

# pipenv completion
command -v pipenv >/dev/null && eval (pipenv --completion)

# Open fish in vim-mode
fish_vi_key_bindings