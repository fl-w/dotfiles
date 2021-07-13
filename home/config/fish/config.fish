# Set prompt options
set -gx LSCOLORS gxfxbEaEBxxEhEhBaDaCaD
set -g theme_prompt_symbol '' # 🢂
set -g fish_greeting ''


# Automatically install fundle (Warning: dangerous on bad connections)
if not functions -q fundle
  eval (curl -sfL https://git.io/fundle-install)
end

fundle plugin 'franciscolourenco/done'
fundle plugin 'jethrokuan/z'
fundle plugin 'fl-w/ortega'
fundle init

# Add xcursor path to env
[ -d ~/.local/share/icons ]; and set -x XCURSOR_PATH ~/.local/share/icons

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

# kitty completion
_command kitty; and kitty + complete setup fish | source

# pipenv completion
_command pipenv; and eval (pipenv --completion)

# Pipr binding
bind \ca run-pipr

# Open fish in vim-mode
fish_vi_key_bindings

