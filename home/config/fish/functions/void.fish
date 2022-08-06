function void --description 'scream into the void'
  set -q argv[1]
    or return

    command $argv &>/dev/null
end
