# fish init script
# @fl-w

dotenv -x ~/.env

if status --is-login
  # for now don't source /etc/profile - this is handled by lightdm
  # look into this for future; for now this will break ssh login
  # (which i don't do often)
  source $__fish_config_dir/profile.fish
end

function add_path -a path
  fish_add_path -P $path
end

# Prepend Go bin dir to PATH
add_path $GOPATH/bin

# Prepend n directory to PATH
add_path $N_PREFIX/bin

# Prepend DART pub bin dir to PATH
add_path $HOME/.pub-cache/bin

# Prepend RUST cargo bin dir to PATH
add_path $CARGO_HOME/bin

# Add private bin to path
add_path $BIN_DIR; add_path ~/.local/bin

# Prepend android-sdk & emulator to PATH
set -x ANDROID_HOME $apps/android-sdk
  and add_path $ANDROID_HOME/tools
  and add_path $ANDROID_HOME/emulator
  and add_path $ANDROID_HOME/tools/bin


if status --is-interactive
  test -f $conf/sh/aliases; and . $conf/sh/aliases

  # Set FZF to use rg
  if has fzf
    set -g FZF_PREVIEW_COMMAND "cat {} || head -n 60 {} || tree -a -C {}"

    # Set fzf to use preview in ctrl-t
    set -gx FZF_DEFAULT_OPTS --layout=default
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

  has jenv; 
    and jenv init - --no-rehash | source
    # and jenv rehash 2>/dev/null &

  # # replace grep with ripgrep command
  # has rg; and alias grep rg

  # kitty completion
  has kitty; and kitty + complete setup fish | source

  # set custom greeting when at work
  set -q WORK_MACHINE
  and set -g fish_greeting 'Hang in there! @fl-w'
  or set -g fish_greeting ''

  # Set prompt options
  set -gx LSCOLORS gxfxbEaEBxxEhEhBaDaCaD
  set -g theme_prompt_symbol '🢂' # 🢂

  # finally open fish in vim-mode
  fish_vi_key_bindings
end

ssh_agent_init &>/dev/null

for file in $__fish_config_dir/config.fish.local $opt/config.fish.local ~/.fish.local
  [ -f $file -a -r $file ]; and source $file
end
