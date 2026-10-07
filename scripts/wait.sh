#!/bin/sh
set -u

wait_pid=

stop_wait() {
    signal=$1

    if [ -n "$wait_pid" ]; then
        kill -TERM "$wait_pid" 2>/dev/null || :
        wait "$wait_pid" 2>/dev/null || :
    fi

    if [ "$signal" = TERM ]; then
        printf '%s\n' 'Cancellation observed; stopping cleanly.' >&2
        exit 143
    fi

    printf '%s\n' 'Interruption observed; stopping cleanly.' >&2
    exit 130
}

trap 'stop_wait TERM' TERM
trap 'stop_wait INT' INT

printf '%s\n' 'Running cancellation fixture; waiting for termination.'
sleep 120 &
wait_pid=$!

if wait "$wait_pid"; then
    wait_pid=
    printf '%s\n' 'Wait completed without cancellation; exiting as failure.' >&2
    exit 1
else
    status=$?
    wait_pid=
    printf '%s\n' 'Wait child stopped unexpectedly; exiting as failure.' >&2
    exit "$status"
fi
