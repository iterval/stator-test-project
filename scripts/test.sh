#!/bin/sh
set -eu

exec node --test test/sum.test.ts
