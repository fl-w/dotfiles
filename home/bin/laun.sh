#!/usr/bin/env sh

## Add this to your wm startup file.

if [ $# -lt 2 ]; then
    echo "Usage: $0 <process> <command to execute> [command options]"
    exit 1
fi

if [[ $1 == --process=* ]]
then
    process=${1:9}
    shift
else
    process=$1
fi

# Terminate already running bar instances
killall -q $process

# Wait until the processes have been shut down
while pgrep -u $UID -x $process >/dev/null; do sleep 1; done

echo "$@"
$@ &