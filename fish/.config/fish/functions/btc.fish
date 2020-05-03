# # function bleutoothctl_reader()
# {
#   {
#     while true
#     do
#       if read line <$pipe; then
#           if [[ "$line" == 'exit' ]]; then
#               break
#           fi
#           echo $line
#       fi
#     done
#   } | bluetoothctl > "$output_file"
# }


function btc --description 'reset and connect to a bluetoth device'
  if test -z  $argv[1]
    echo "Missin dev argument"
    return 1
  end

  set device $argv[1]

  contains "$device" bt_list_known_dev; and echo bluetoothctl remove $device

  bluetoothctl scan on |
  while true
    if read line </tmp/btctemp
      # echo $line
      echo test
    end
  end |

  # bluetoothctl scan on | grep -q "$device"; and bluetoothctl trust $device; and bluetoothctl pair $device; and bluetoothctl connect $device
  # bluetoothctl scan off

end

function blue_list_known_devices
 printf (bluetoothctl devices | coln 2)
end

set -l commands (bluetoothctl devices | coln 2)

complete -c btc -f
complete -c btc -n "not __fish_seen_subcommand_from $commands" -a "$commands"

alias cth btc
