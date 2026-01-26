# Gallinule

> [!NOTE]
>
> Gallinule is sporadically worked on, and currently does not have any support for runtime compilation. Eventually, it is planned for staging to be implemented, which would allow for an intermediary between runtime and comptime to allow for runtime compilation.

Gallinule is an incredibly quick, dynamic comptime assembler designed to allow for compiling CIL, x86, x86_64, and MIPS with minimal overhead and maximal throughput.

## Quick Start

Each target uses a `Block` (or `Block!true` for x86_64), instruction methods, optional `label(name)`, and `finalize()` to get the assembled bytes.

### MIPS

```d
import gallinule.mips;

Block block;
with (block) {
    addiu(rat, rzero, 5);
    lui(rv0, 0x1234);
    label("loop");
    beq(ra0, rzero, "loop");
    syscall();
}
ubyte[] enc = block.finalize();
```

### CIL

```d
import gallinule.cil;

Block b;
with (b) {
    ldcI4_1();
    brtrueS("skip");
    ldcI4_0();
    label("skip");
    ret();
}
ubyte[] enc = b.finalize();
```

### x86_64

```d
import gallinule.amd64;

Block!true block;  // true == 64-bit
with (block) {
    push(rcx);
    mov(eax, ecx);
    jl("done");
    add(eax, 1);
    label("done");
    pop(rcx);
    ret();
}
ubyte[] enc = block.finalize();
```

## License

Gallinule is licensed under the [AGPL-3.0 license](LICENSE.txt).
