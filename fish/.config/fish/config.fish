## Fish config
#

# Start X at login
if status --is-login
  if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
    exec startx
  end
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
[ -d /opt/android-sdk ]; and set -x ANDROID_HOME /opt/android-sdk \

; and set PATH $ANDROID_HOME/tools:$ANDROID_HOME/tools/bin $PATH \

; and [ -d $ANDROID_HOME/emulator ]; and set PATH $ANDROID_HOME/emulator $PATH

# Add xcursor path to env
[ -d ~/.local/share/icons ]; and set -x XCURSOR_PATH ~/.local/share/icons

# Setup kitty auto complete
[ -f /usr/bin/kitty ]; and kitty + complete setup fish | source

# Set FZF to use ag
[ -f /usr/bin/fzf ]; and [ -f /usr/bin/ag ]; and set -gx FZF_DEFAULT_COMMAND 'ag --hidden --ignore .git -l -g ""'

# Import aliases
[ -f conf.d/aliases.fish ]; and . conf.d/aliases.fish

# Set n prefix to home
set -gx N_PREFIX $HOME/.n
[ -d $N_PREFIX/bin ]; and set PATH $N_PREFIX/bin $PATH

# Open fish in vim-mode
fish_vi_key_bindings
