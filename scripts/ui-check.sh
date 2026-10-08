#!/bin/sh
set -eu

child_pid=

stop_for_signal() {
    signal=$1
    trap '' TERM INT

    if [ -n "$child_pid" ]; then
        kill -TERM "$child_pid" 2>/dev/null || :
        wait "$child_pid" 2>/dev/null || :
        child_pid=
    fi

    if [ "$signal" = TERM ]; then
        printf '%s\n' 'Dashboard check cancelled by TERM.' >&2
        exit 143
    fi

    printf '%s\n' 'Dashboard check interrupted by INT.' >&2
    exit 130
}

trap 'stop_for_signal TERM' TERM
trap 'stop_for_signal INT' INT

run_child() {
    "$@" &
    child_pid=$!

    if wait "$child_pid"; then
        status=0
    else
        status=$?
    fi

    child_pid=
    return "$status"
}

if run_child ./scripts/test.sh; then
    :
else
    status=$?
    printf 'Dashboard check tests failed with status %s.\n' "$status" >&2
    exit "$status"
fi

elapsed=0
while [ "$elapsed" -lt 5 ]; do
    printf 'Dashboard check still running (%s/5 seconds).\n' "$elapsed"
    if run_child sleep 1; then
        :
    else
        status=$?
        printf 'Dashboard check progress wait failed with status %s.\n' "$status" >&2
        exit "$status"
    fi
    elapsed=$((elapsed + 1))
done

printf '%s\n' 'Dashboard check completed after five seconds.'
