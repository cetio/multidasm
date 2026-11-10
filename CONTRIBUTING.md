# Contributing

Keep changes focused. Explain what changed and why it was needed.

## Before Making Changes

Read the relevant backend and its tests first. Match the style of neighboring D code.

- Assemblers live under `source/multidasm/`, one tree per backend (`amd64`, `mips`, `cil.d`).
- Exact-byte tests live under `source/tests/`, one tree per backend.
- Per-assembler docs live under `docs/`.

## Tests

Run the suite for the backend you changed before submitting.

```sh
dub run --compiler=ldc2 -c test-amd64
dub run --compiler=ldc2 -c test-mips
dub run --compiler=ldc2 -c test-cil
```

Add tests for behavior changes. Tests below the `// Known defects.` markers are expected to fail; when a fix makes one pass, keep it as a regression test. See [Testing](TESTING.md) for details.

## Documentation

Update the README and the matching page under `docs/` when public behavior changes. Check examples against the code, including register names and encoding notes.

## Reporting Issues

Include a minimal example, expected and actual bytes or behavior, compiler and DUB versions, and the backend involved (AMD64, MIPS, or CIL). Sanitize logs and never commit credentials.
