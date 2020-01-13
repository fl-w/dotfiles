## Fish config
#

# Disable fish greeting
set -gx fish_greeting ''

# Set fish colors
set -Ux LSCOLORS gxfxbEaEBxxEhEhBaDaCaD

# Set default editor to nvim
set -Ux EDITOR /usr/bin/nvim

# Append local bin dir to PATH
set PATH $HOME/.local/bin $HOME/.bin $PATH

[ -f /usr/bin/kitty ]; and kitty + complete setup fish | source

# Import aliases
[ -f $HOME/.config/fish/aliases.fish ]; and . ~/.config/fish/aliases.fish
