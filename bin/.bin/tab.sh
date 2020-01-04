#!/usr/bin/env bash
LOCKDIR="/tmp/tab-page"
TABDIR="$HOME/sbin/tab"

#Remove the lock directory
function cleanup {
    if rmdir $LOCKDIR; then
        echo "Finished"
    else
        echo "Failed to remove lock directory '$LOCKDIR'"
        exit 1
    fi
}

if mkdir $LOCKDIR; then
    #Ensure that if we "grabbed a lock", we release it
    #Works for SIGTERM and SIGINT(Ctrl-C)
    trap "cleanup" EXIT

    echo "Acquired lock, running"

    # Serve $HOME/sbin/tab/index.html
    python -m http.server 8000 -d $TABDIR

else
    echo "Could not create lock directory '$LOCKDIR'"
    exit 1
fi
