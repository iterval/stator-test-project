# stator test project

A public test fixture for running checks with stator. It contains a small
TypeScript function and deterministic tests using Node's built-in test runner.

Use Node 24 or later and a POSIX shell. Node runs the TypeScript directly;
no dependencies or installation step are needed. Run these scripts from the
repository root:

```sh
./scripts/test.sh
./scripts/fail.sh
```

| Check name | Image | Script path |
| --- | --- | --- |
| Tests | `node:24-bookworm-slim` | `scripts/test.sh` |
| Expected failure | `node:24-bookworm-slim` | `scripts/fail.sh` |

`Tests` should pass. The optional `Expected failure` check prints a deliberate
failure to stderr and exits with status 1.
