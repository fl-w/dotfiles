function btc --description 'reset and connect to a bluetoth device'
  if test -z  $argv[1]
    echo "Missin dev argument"
    return 1
  end

  set device $argv[1]

  contains "$device" bt_list_known_dev; and echo bluetoothctl remove $device

  set tmp (mktemp --suffix btc)
  trap "remove_tmp $tmp" EXIT
  echo "created tmp @ $tmp"

  bluetoothctl scan on >$tmp 2>&1 &
  echo "started bctl"
  grep -q -m 1 "$device" (tail -f $tmp | psub) || return 1

  echo found
  bluetoothctl trust $device
  bluetoothctl connect $device

end

function remove_tmp --argument tmp
  rm "$tmp"
end

function blue_list_known_devices
 printf (bluetoothctl devices | coln 2)
end

set -l commands (bluetoothctl devices | coln 2)

complete -c btc -f
complete -c btc -n "not __fish_seen_subcommand_from $commands" -a "$commands"

alias cth btc
