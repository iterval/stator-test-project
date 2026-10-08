# stator test project

A public test fixture for running checks with stator. It contains a small
TypeScript function and deterministic tests using Node's built-in test runner.

Use Node 24 or later and a POSIX shell. Node runs the TypeScript directly;
no dependencies or installation step are needed. Run these scripts from the
repository root:

```sh
./scripts/test.sh
./scripts/ui-check.sh
./scripts/fail.sh
./scripts/wait.sh
```

| Check name | Image | Script path |
| --- | --- | --- |
| Tests | `node:24-bookworm-slim` | `scripts/test.sh` |
| Dashboard exercise | `node:24-bookworm-slim` | `scripts/ui-check.sh` |
| Expected failure | `node:24-bookworm-slim` | `scripts/fail.sh` |
| Running cancellation | `node:24-bookworm-slim` | `scripts/wait.sh` |

`Tests` should pass. The optional `Expected failure` check prints a deliberate
failure to stderr and exits with status 1.

`Dashboard exercise` runs the tests, then prints progress during a five-second
hold before passing. TERM or INT cancels the hold, stops its owned sleep child,
and exits nonzero.

The `Running cancellation` check waits for a termination signal and exits
nonzero after it is observed; if no signal arrives, it exits nonzero after the
wait instead of passing accidentally.
