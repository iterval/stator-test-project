#!/bin/sh
set -eu
exec node --input-type=module <<'NODE'
import { setTimeout as sleep } from 'node:timers/promises';
function payload(label, lines) {
  return Buffer.from(Array.from({length: lines}, (_, i) =>
    `${label} ${String(i).padStart(8, '0')} `.padEnd(63, '.') + '\n').join(''));
}
function write(stream, data) {
  return new Promise((resolve, reject) => stream.write(data, error => error ? reject(error) : resolve()));
}
await sleep(5000);
await write(process.stdout, payload('stdout', 32768));
await write(process.stderr, payload('stderr', 1024));
await sleep(5000);
NODE
