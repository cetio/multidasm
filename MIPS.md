# MIPS (IV)

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

## Instructions

| Mnemonic | Supported |
|----------|-----------|
| abs.d |  |
| abs.s |  |
| add | X |
| add.d |  |
| add.s |  |
| addi | X |
| addiu | X |
| addu | X |
| and | X |
| andi | X |
| bc1f |  |
| bc1fl |  |
| bc1t |  |
| bc1tl |  |
| beq | X |
| beql |  |
| bgez | X |
| bgezal |  |
| bgezall |  |
| bgezl |  |
| bgtz | X |
| bgtzl |  |
| blez | X |
| blezl |  |
| bltz | X |
| bltzal |  |
| bltzall |  |
| bltzl |  |
| bne | X |
| bnel |  |
| break | X |
| c.eq.d |  |
| c.eq.s |  |
| c.le.d |  |
| c.le.s |  |
| c.lt.d |  |
| c.lt.s |  |
| ceil.l.d |  |
| ceil.l.s |  |
| ceil.w.d |  |
| ceil.w.s |  |
| cfc1 |  |
| cfc2 |  |
| ctc1 |  |
| ctc2 |  |
| cvt.d.s |  |
| cvt.d.w |  |
| cvt.l.d |  |
| cvt.l.s |  |
| cvt.s.d |  |
| cvt.s.w |  |
| cvt.w.d |  |
| cvt.w.s |  |
| dadd |  |
| daddi |  |
| daddiu |  |
| daddu |  |
| ddiv |  |
| ddivu |  |
| div | X |
| div.d |  |
| div.s |  |
| divu | X |
| dmult |  |
| dmultu |  |
| dsll |  |
| dsll32 |  |
| dsllv |  |
| dsra |  |
| dsra32 |  |
| dsrav |  |
| dsrl |  |
| dsrl32 |  |
| dsrlv |  |
| dsub |  |
| dsubu |  |
| floor.l.d |  |
| floor.l.s |  |
| floor.w.d |  |
| floor.w.s |  |
| j | X |
| jal | X |
| jalr | X |
| jr | X |
| lb | X |
| lbu | X |
| ld |  |
| ldc1 |  |
| ldl |  |
| ldr |  |
| ldxc1 |  |
| lh | X |
| lhu | X |
| ll |  |
| lld |  |
| lui | X |
| lw | X |
| lwc1 |  |
| lwl |  |
| lwr |  |
| lwu |  |
| lwxc1 |  |
| madd.d |  |
| madd.s |  |
| mfc0 |  |
| mfc1 |  |
| mfc2 |  |
| mfhi | X |
| mflo | X |
| mov.d |  |
| mov.s |  |
| movcf |  |
| movci |  |
| movn | X |
| movn.d |  |
| movn.s |  |
| movz | X |
| movz.d |  |
| movz.s |  |
| msub.d |  |
| msub.s |  |
| mtc0 |  |
| mtc1 |  |
| mtc2 |  |
| mthi | X |
| mtlo | X |
| mul.d |  |
| mul.s |  |
| mult | X |
| multu | X |
| neg.d |  |
| neg.s |  |
| nmadd.d |  |
| nmadd.s |  |
| nmsub.d |  |
| nmsub.s |  |
| nor | X |
| or | X |
| ori | X |
| pref |  |
| prefx |  |
| recip.d |  |
| recip.s |  |
| round.l.d |  |
| round.l.s |  |
| round.w.d |  |
| round.w.s |  |
| rsqrt.d |  |
| rsqrt.s |  |
| sb | X |
| sc |  |
| scd |  |
| sd |  |
| sdc1 |  |
| sdl |  |
| sdr |  |
| sdxc1 |  |
| sh | X |
| sll | X |
| sllv | X |
| slt | X |
| slti | X |
| sltiu | X |
| sltu | X |
| sqrt.d |  |
| sqrt.s |  |
| sra | X |
| srav | X |
| srl | X |
| srlv | X |
| sub | X |
| sub.d |  |
| sub.s |  |
| subu | X |
| sw | X |
| swc1 |  |
| swl |  |
| swr |  |
| swxc1 |  |
| sync |  |
| syscall | X |
| teq |  |
| teqi |  |
| tge |  |
| tgei |  |
| tgeiu |  |
| tgeu |  |
| tlt |  |
| tlti |  |
| tltiu |  |
| tltu |  |
| tne |  |
| tnei |  |
| trunc.l.d |  |
| trunc.l.s |  |
| trunc.w.d |  |
| trunc.w.s |  |
| xor | X |
| xori | X |
