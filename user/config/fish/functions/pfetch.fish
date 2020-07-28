function pfetch --description 'Run pfetch with predefined args'
  set -l user $USER
  set -l PF_INFO "ascii title os kernel pkgs shell wm palette"
  set -l infinity false
  set -l clear false

  getopts $argv | while read -l key val
    set --erase argv[1]
    switch $key
      case u user
        set user $val
      case c clear
        set clear true
      case i infinite
        set infinity true
    end
  end
  if $clear
    clear
  end
  USER=$user PF_INFO=$PF_INFO command pfetch
  if $infinity
    sleep infinity
  end
end
