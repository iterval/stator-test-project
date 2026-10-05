#!/bin/sh
set -eu

printf '%s\n' 'Deliberate failure: this optional check must exit with status 1.' >&2
exit 1
