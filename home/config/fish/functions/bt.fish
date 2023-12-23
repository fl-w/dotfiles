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
        echo $uuid
        __reconnect $uuid &
    end
end


function _bt_connect
    if test (count $argv) -eq 0
        set -l dev (bluetoothctl devices | cut -f2 -d' ')
        if ! test (count $dev) -eq 0
            _bt_connect $dev
        end
    else
        for uuid in $argv
            bluetoothctl connect $uuid &
        end
        wait
    end
end

function bt --wraps=bluetoothctl
    switch $argv[1]
        case 'con*'
            _bt_connect
        case 'rec*'
            _bt_reconnect
        case 'dev*'
            _bt_devices
    case '*'
        bluetoothctl $argv
    end
end
