function _bt_devices
    set -l uuids (bluetoothctl devices | cut -f2 -d' ')

    for uuid in $uuids
        bluetoothctl info $uuid
    end |grep -e "Device\|Connected\|Name"
end

function _bt_reconnect
    function __reconnect -a uuid
        bluetoothctl info $uuid | grep -qe 'Connected: yes'
            and bluetoothctl disconnect $uuid
            and bluetoothctl connect $uuid
    end

    for uuid in (bluetoothctl devices | cut -f2 -d' ')
        __reconnect $uuid &
    end
end

function _bt_connect
    bluetoothctl $argv
end

function bt --wraps=bluetoothctl
    switch $argv[1]
        case 'rec*'
            _bt_reconnect
        case 'dev*'
            _bt_devices
    case '*'
        bluetoothctl $argv
    end
end
