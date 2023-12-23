# fish init script
# @fl-w

test -f ~/.env; and dotenv -x ~/.env

if status --is-login
  # for now don't source /etc/profile - this is handled by lightdm
  # look into this for future; for now this will break ssh login
  # (which i don't do often)
  source $__fish_config_dir/profile.fish
end

function add_path -a path
  fish_add_path -P $path
end

# Prepend pyenv bin dir to PATH
add_path $PYENV_ROOT/bin

# Prepend Go bin dir to PATH
add_path $GOPATH/bin

# Prepend n directory to PATH
add_path $N_PREFIX/bin

# Prepend PNPM directory to PATH
add_path $PNPM_HOME

# Prepend DART pub bin dir to PATH
add_path $HOME/.pub-cache/bin

# Prepend RUST cargo bin dir to PATH
add_path $CARGO_HOME/bin

# Add private bin to path
add_path $BIN_DIR; add_path ~/.local/bin

# Prepend android-sdk & emulator to PATH
set -x ANDROID_HOME /opt/android-sdk
  and begin
    add_path $ANDROID_HOME/tools;
    add_path $ANDROID_HOME/emulator
    add_path $ANDROID_HOME/platform-tools
    add_path $ANDROID_HOME/tools/bin
  end

if status --is-interactive
  test -f $conf/sh/aliases; and . $conf/sh/aliases

  # Set FZF to use rg
  if has fzf
    set -gx FZF_PREVIEW_COMMAND "bat {} || cat {} || tree -a -C {}"

    # Set fzf to use preview in ctrl-t
    set -gx FZF_DEFAULT_OPTS --layout=reverse --inline-info
    set -gx FZF_CTRL_T_OPTS $FZF_DEFAULT_OPTS \
      --min-height 30 \
      --preview-window down:60% \
      --preview-window noborder

    # set fzf to use ripgrep by default
    has rg
      and set -gx FZF_DEFAULT_COMMAND rg --files
      and set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND" 2>/dev/null
  end

  # replace cat with bat command
  has bat; and alias cat bat

  # kitty completion
  has kitty; and kitty + complete setup fish | source

  # Set prompt options
  set -gx LSCOLORS gxfxbEaEBxxEhEhBaDaCaD
  set -q theme_prompt_symbol; or set -g theme_prompt_symbol '🢂' # 🢂

  # finally open fish in vim-mode
  fish_vi_key_bindings
end

for file in $__fish_config_dir/config.fish.local $apps/config.fish.local ~/.fish.local
  [ -f $file -a -r $file ]; and source $file
end

has pyenv;
  and pyenv init - | source

has ssh_agent_init
  and ssh_agent_init &>/dev/null
