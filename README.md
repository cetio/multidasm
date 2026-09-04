# Multidasm

[![AMD64 - 79%](https://img.shields.io/static/v1?label=AMD64&message=79%&color=green&style=for-the-badge)](https://)
[![MIPS - 27%](https://img.shields.io/static/v1?label=MIPS&message=27%&color=yellow&style=for-the-badge)](https://)
[![CIL - 100%](https://img.shields.io/static/v1?label=CIL&message=100%&color=brightgreen&style=for-the-badge)](https://)
[![License](https://img.shields.io/badge/License-Apache--2.0-blue)](LICENSE.txt)

> [!NOTE]
> Multidasm currently doesn't support runtime assembling. This is planned for the future.

Multidasm is a quick, dynamic comptime assembler for D. It targets CIL, x86, x86_64, and MIPS with minimal overhead and maximal throughput. Each backend uses a `Block` type, instruction methods, optional `label(name)`, and `finalize()` to produce assembled bytes.

## Modules

| Module | Target | Status |
|--------|--------|--------|
| `multidasm.amd64` | x86 / x86_64 with MMX, SSE, AVX, AVX2 | 79% |
| `multidasm.mips` | MIPS32 integer core, big-endian | 27% |
| `multidasm.cil` | Common Intermediate Language (ECMA-335) | 100% |

Per-assembler documentation:

- [AMD64](AMD64.md) - Register and memory operands, REX/VEX prefixes, instruction encoding.
- [MIPS](MIPS.md) - GPRs, I-type/J-type/R-type encoding, branch and jump label patching.
- [CIL](CIL.md) - Stack-based opcodes, branch labels, prefixes, metadata tokens.

## Installation

`dub add multidasm`

For local development in this workspace:

```json
{
    "dependencies": {
        "multidasm": {
            "path": "../multidasm"
        }
    }
}
```

## Usage

### AMD64

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

### MIPS

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

### CIL

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

## Roadmap

**Oops, there's no formal roadmap!**

- [x] x86
- [x] x86_64
- [ ] AVX-512
- [x] CIL
- [x] MIPS IV
- [ ] ARM
- [ ] z80
- [ ] IR
- [ ] Runtime assembling

## License

Multidasm is licensed under [Apache-2.0](LICENSE.txt).
