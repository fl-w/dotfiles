set -q conf;  or set -gx conf  $HOME/etc
set -q data;  or set -gx data  $HOME/usr
set -q cache; or set -gx cache $HOME/usr/cache
set -q apps;  or set -gx apps  $HOME/opt

# Set XDG directories to custom dirs
set -x XDG_CONFIG_HOME $conf
set -x XDG_DATA_HOME $data
set -x XDG_CACHE_HOME $cache

# Set env vars for other locations
set -q SCR_DIR; or set -x SCR_DIR $HOME/media/scr
set -q BIN_DIR; or set -x BIN_DIR $HOME/bin


function move_sym -a from -a to
  if [ -d "$from" -a ! -L "$from" ]
    echo "move symlink $from --> $to"
    mkdir -p $to || exit 1

    has rsync
      and yes | rsync --update --progress --recursive $from/{.,}* $to/
      or cp -fru $from/{.,}* $to/
      and rm -r $from
      and ln -sf $to $from
  end
end

move_sym "$HOME/.config" "$conf"
move_sym "$HOME/.local/share" "$data"
move_sym "$HOME/.cache" "$cache"
move_sym "$HOME/.mozilla" "$apps/mozilla"
move_sym "$HOME/.local" "$data/local"
# move_sym "$HOME/Downloads" "$XDG_DOWNLOAD_DIR"

function default -a name
  for def in $argv[2..-1]
    if has $def
      set -gx $name $def
      return
    end
  end
end

# set default editor
default EDITOR /usr/bin/nvim /usr/bin/vim /usr/bin/vi /usr/bin/nano

# set default browser (i switch between browsers on diff machines)
default BROWSER firefox{-developer-edition,} brave-browser chromium


set -gx PLATFORM (uname | string lower)

# Declutter $HOME (https://wiki.archlinux.org/title/XDG_Base_Directory)
set -gx N_PREFIX "$apps/tj-n"
set -gx CARGO_HOME "$apps/cargo"
set -gx PYENV_ROOT "$apps/pyenv"
set -gx NVM_DIR "$apps/nvm"
set -gx GNUPGHOME "$apps/gpg"
set -gx RUSTUP_HOME "$cache/rustup"
set -gx GOPATH "$cache/go"
set -gx TEXMFHOME "$data/texmf/"
set -gx WEECHAT_HOME "$conf/weechat"
set -gx RIPGREP_CONFIG_PATH "$conf/rg/ripgreprc"
set -gx SQLITE_HISTORY "$cache/sqlite_history"
set -gx USERXSESSION "$conf/x/xsession"
set -gx PASSWORD_STORE_DIR "$data/pass"
set -gx USERXSESSIONRC "$conf/x/xsessionrc"
set -gx VSCODE_PORTABLE "$data"/vscode
set -gx ERRFILE "$cache/xsession-errors"
set -gx GTK2_RC_FILES "$conf/gtk-2.0/gtkrc-2.0"
set -gx _FASD_DATA "$cache/fasd"
set -gx LESSHISTFILE "$cache/_lessht"
set -gx HISTFILE "$cache/bash_history"
set -gx PNPM_HOME "$data/pnpm"
set -gx NPM_CONFIG_USERCONFIG "$conf/npm/npmrc"
set -gx USER_SVDIR "$data/runit/runsvdir/"
set -gx USER_FLDIR "$data/runit/sv/"
set -gx KUBECONFIG "$conf/kube" 
set -gx KUBECACHEDIR "$cache/kube"
set -gx MINIKUBE_HOME "$data/minikube"
# Move java clutter
set -gx _SILENT_JAVA_OPTIONS "-Djava.util.prefs.userRoot=$conf/java"
set -gx MAVEN_CONFIG "--global-settings $conf/maven/settings.xml"
set -gx ANDROID_SDK_HOME "$data/android"
set -gx ANDROID_PREFS_ROOT "$data/android"
set -gx GRADLE_USER_HOME "$data/gradle"

# Add xcursor path to env (avoid ~/.icons)
set -gx XCURSOR_PATH "$data/icons"

# prevent less from storing history
set -gx LESSHISTFILE /dev/null

# allow external python packages in google-cloud-sdk
set -gx CLOUDSDK_PYTHON_SITEPACKAGES 1

function void
  $argv >/dev/null
end
