# Gallinule

[![AMD64 - 79%](https://img.shields.io/badge/AMD64-79%-green)](https://)
[![MIPS - 27%](https://img.shields.io/badge/MIPS-27%-yellow)](https://)
[![CIL - 100%](https://img.shields.io/badge/CIL-100%-brightgreen)](https://)

> [!NOTE]
>
> Gallinule is sporadically worked on, and currently does not have any support for runtime compilation. Eventually, it is planned for staging to be implemented, which would allow for an intermediary between runtime and comptime to allow for runtime compilation.

Gallinule is an incredibly quick, dynamic comptime assembler designed to allow for compiling CIL, x86, x86_64, and MIPS with minimal overhead and maximal throughput.

## Quick Start

Each target uses a `Block` (or `Block!true` for x86_64), instruction methods, optional `label(name)`, and `finalize()` to get the assembled bytes.

Available instructions as well as specific examples may be found in per-assembler documentation:

- [AMD64 (x86(_64))](AMD64.md)
- [MIPS (IV)](MIPS.md)
- [CIL](CIL.md)

## License

Gallinule is licensed under the [AGPL-3.0 license](LICENSE.txt).
