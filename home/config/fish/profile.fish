set -q conf; or set conf $HOME/etc
set -q data; or set data $HOME/usr
set -q cache; or set cache $HOME/usr/cache
set -q apps; or set apps $HOME/opt

# Set XDG directories to custom dirs
set -x XDG_CONFIG_HOME $conf
set -x XDG_DATA_HOME $data
set -x XDG_CACHE_HOME $cache

# Set env vars for other locations
set -q SCR_DIR; or set -x SCR_DIR $HOME/media/scr
set -q BIN_DIR; or set -x BIN_DIR $HOME/bin


function move_sym -a from -a to
  if [ -d "$from" ]
    mkdir -p $to
    cp -ru $from/{.,}* $to
    mv $from $from.old # do i even need this?
    ln -sf $to $from
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
default EDITOR nvim vim vi nano

# set default browser (i switch between browsers on diff machines)
default BROWSER firefox{-developer-edition,} brave-browser chromium

# TODO: something like withdotenv /etc/os-release
# & auto erase the exported envs
begin
  set -l envs (dotenv /etc/os-release)

  # i never run ubuntu on personal machines
  if [ $ID = ubuntu ]
    set -gx WORK_MACHINE=(hostname)
  end

  # delete os-release vars when done
  for env in $envs; set -e $env; end
end

# Declutter $HOME (https://wiki.archlinux.org/title/XDG_Base_Directory)
set -gx N_PREFIX "$apps/tj-n"
set -gx CARGO_HOME "$apps/cargo"
set -gx RUSTUP_HOME "$cache/rustup"
set -gx GOPATH "$cache/go"
set -gx TEXMFHOME "$data/texmf/"
set -gx WEECHAT_HOME "$conf/weechat"
set -gx RIPGREP_CONFIG_PATH "$conf/rg/ripgreprc"
set -gx GNUPGHOME "$apps/gpg"
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
set -gx NPM_CONFIG_USERCONFIG "$conf/npm/npmrc"

# Move java clutter
set -gx _JAVA_OPTIONS "-Djava.util.prefs.userRoot=$conf/java"
set -gx MAVEN_CONFIG "--global-settings $conf/maven/settings.xml"
set -gx ANDROID_SDK_HOME "$data/android"
set -gx ANDROID_PREFS_ROOT "$data/android"
set -gx GRADLE_USER_HOME "$data/gradle"

# Add xcursor path to env (avoid ~/.icons)
set -gx XCURSOR_PATH "$data/icons"

# prevent less from storing history
set -gx LESSHISTFILE /dev/null

# # add colors to less
# set -gx LESS_TERMCAP_mb $'\e[1;31m'     # begin bold
# set -gx LESS_TERMCAP_md $'\e[1;33m'     # begin blink
# set -gx LESS_TERMCAP_so $'\e[01;44;37m' # begin reverse video
# set -gx LESS_TERMCAP_us $'\e[01;37m'    # begin underline
# set -gx LESS_TERMCAP_me $'\e[0m'        # reset bold/blink
# set -gx LESS_TERMCAP_se $'\e[0m'        # reset reverse video
# set -gx LESS_TERMCAP_ue $'\e[0m'        # reset underline

function void
  $argv & &>/dev/null
end

void sudo kbdrate -d 190 -r 60
