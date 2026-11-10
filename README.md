# Multidasm

[![DUB](https://img.shields.io/badge/DUB-package-red)](https://code.dlang.org/packages/multidasm) [![License](https://img.shields.io/badge/License-Apache--2.0-blue)](LICENSE.txt) [![CI](https://github.com/cetio/multidasm/actions/workflows/ci.yml/badge.svg)](https://github.com/cetio/multidasm/actions/workflows/ci.yml)

> [!NOTE]
> Runtime assembly is not currently supported; it is planned for the future.

Multidasm is a quick, dynamic comptime assembler for D. It targets CIL, x86, x86_64, and MIPS with minimal overhead and maximal throughput. Each backend uses a `Block` type, instruction methods, optional `label(name)`, and `finalize()` to produce assembled bytes.

## Installation

```sh
dub add multidasm
```

## Quick Start

### AMD64 ([reference](docs/AMD64.md))

Use `Block!false` for x86 and `Block!true` for x86_64. Registers are sized (`Reg!8`, `Reg!16`, `Reg!32`, `Reg!64`) and memory operands use `Mem!(size)`.

```d
import multidasm.amd64;

Block!true code;
with (code)
{
    mov(rax, rdi);
    add(rax, rsi);
    ret();
}

ubyte[] assembled = code.finalize();
```

### MIPS ([reference](docs/MIPS.md))

MIPS uses `Block` with `GPR` registers and `Mem` operands. Output is big-endian. Labels are resolved automatically in `finalize()`.

```d
import multidasm.mips;

Block code;
with (code)
{
    addiu(rv0, rzero, 10);
    label("loop");
    addiu(rv0, rv0, -1);
    bne(rv0, rzero, "loop");
    nop();
}

ubyte[] assembled = code.finalize();
```

### CIL ([reference](docs/CIL.md))

CIL uses `Block` with stack-based opcodes. Branches and switches use string labels patched during `finalize()`.

```d
import multidasm.cil;

Block code;
with (code)
{
    ldcI4_0();
    stloc0();
    label("loop");
    ldloc0();
    ldcI4(1);
    add();
    stloc0();
    ldloc0();
    ldcI4(10);
    blt("loop");
    ret();
}

ubyte[] assembled = code.finalize();
```

## Development

See [CONTRIBUTING.md](CONTRIBUTING.md) and [TESTING.md](TESTING.md).

## License

Multidasm is licensed under [Apache-2.0](LICENSE.txt).
