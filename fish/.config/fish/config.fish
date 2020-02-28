## Fish config
#

# Disable fish greeting
set -gx fish_greeting ''

# Set fish colors
set -gx LSCOLORS gxfxbEaEBxxEhEhBaDaCaD

# Set default editor to nvim
set -gx EDITOR /usr/bin/nvim


# Append local bin dir to PATH
set PATH $HOME/.local/bin $HOME/.bin $PATH

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
