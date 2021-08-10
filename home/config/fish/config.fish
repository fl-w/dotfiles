# fish init script
# @fl-w

# Automatically install fundle (Warning: dangerous on bad connections)
if not functions -q fundle
  eval (curl -sfL https://git.io/fundle-install)
end

fundle plugin 'fl-w/ortega'
fundle plugin 'franciscolourenco/done'
fundle plugin 'jethrokuan/z'
fundle plugin 'oh-my-fish/plugin-await'
fundle plugin 'oh-my-fish/plugin-license'
fundle plugin 'edc/bass'

# auto install fundle plugins
for plugin in (fundle list -s)
  if not test -d (__fundle_plugins_dir)/$plugin
    fundle install
    break
  end
end

fundle init
# source bash profile
function bsource -a file
  test -x $file && bass source $file
end

if status --is-login
  bsource /etc/profile
  bsource ~/.env
  bsource ~/.profile
  set -q conf || set -l conf $HOME/.config
  bsource $conf/sh/profile
end

contains ~/.local/bin $fish_user_paths
  or set -Up fish_user_paths ~/.local/bin

function _command --description "check if command is a command" --argument c
  command -v $c >/dev/null
  return $fish_status
end

# replace cat with bat command
_command bat; and alias cat bat

# replace grep with ripgrep command
_command rg; and alias grep rg

# Set FZF to use rg
if _command fzf
  set -g FZF_PREVIEW_COMMAND "cat {} || head -n 60 {} || tree -a -C {}"

  # Set fzf to use preview in ctrl-t
  set -gx FZF_DEFAULT_OPTS --layout=default
  set -gx FZF_CTRL_T_OPTS $FZF_DEFAULT_OPTS \
     --min-height 30 \
     --preview-window down:60% \
     --preview-window noborder \
     --preview "'begin; $FZF_PREVIEW_COMMAND; end 2>/dev/null'"

  # set fzf to use ripgrep by default
  _command rg
    and set -gx FZF_DEFAULT_COMMAND rg --files --no-ignore-vcs --hidden #
    and set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND 2>/dev/null
end

# kitty completion
_command kitty; and kitty + complete setup fish | source

# pipenv completion
_command pipenv; and eval (pipenv --completion)

# Pipr binding
_command pipr; and bind \ca run-pipr

# Set prompt options
set -gx LSCOLORS gxfxbEaEBxxEhEhBaDaCaD
set -g theme_prompt_symbol '' # 🢂

if status --is-interactive && not test -z "$IS_WORK"
  echo 'Hang in there! @fl-w'
else
  set -g fish_greeting ''
end

# finally open fish in vim-mode
fish_vi_key_bindings

[ -f $__fish_config_dir/config.fish.local ]
  and . $__fish_config_dir/config.fish.local
