# multidasm

[![AMD64 - 79%](https://img.shields.io/static/v1?label=AMD64&message=79%&color=green&style=for-the-badge)](https://)
[![MIPS - 27%](https://img.shields.io/static/v1?label=MIPS&message=27%&color=yellow&style=for-the-badge)](https://)
[![CIL - 100%](https://img.shields.io/static/v1?label=CIL&message=100%&color=brightgreen&style=for-the-badge)](https://)

> [!NOTE]
> multidasm currently doesn't support runtime assembling. This is planned for the future.

multidasm is an incredibly quick, dynamic comptime assembler designed to allow for compiling CIL, x86, x86_64, and MIPS with minimal overhead and maximal throughput.

## Quick Start

Each target uses a `Block` (or `Block!true` for x86_64), instruction methods, optional `label(name)`, and `finalize()` to get the assembled bytes.

Available instructions as well as specific examples may be found in per-assembler documentation:

- [AMD64 (x86(_64))](AMD64.md)
- [MIPS (IV)](MIPS.md)
- [CIL](CIL.md)

## Roadmap

**Oops, there's no formal roadmap!**

- [X] x86
- [X] x86_64
- [ ] AVX-512
- [X] CIL
- [X] MIPS IV
- [ ] ARM
- [ ] z80
- [ ] IR
- [ ] Runtime assembling
  
## License

multidasm is licensed under the [AGPL-3.0 license](LICENSE.txt).
