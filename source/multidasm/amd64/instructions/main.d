    /* ====== MAIN ====== */

    // NOTE: Branch hints are generally useless in the modern day, AMD CPUs don't even acknowledge them;
    // and thus these should not be used on any modern CPU.

    @("prefix")
    auto not_taken(size_t size)
    {
        buffer = buffer[0..(buffer.length - size)]~0x2e~buffer[(buffer.length - size)..$];
        return size + 1;
    }

    @("prefix")
    auto taken(size_t size)
    {
        buffer = buffer[0..(buffer.length - size)]~0x3e~buffer[(buffer.length - size)..$];
        return size + 1;
    }

    @("r32", "rm8")
    auto crc32(RM)(R32 dst, RM src) if (valid!(RM, 8)) => emit!0(0xf2, 0x0f, 0x38, 0xf0, dst, src);
    @("r32", "rm16")
    auto crc32(RM)(R32 dst, RM src) if (valid!(RM, 16)) => emit!0(0xf2, 0x0f, 0x38, 0xf1, dst, src);
    @("r32", "rm32")
    auto crc32(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0xf2, 0x0f, 0x38, 0xf1, dst, src);

    @("r64", "rm8")
    auto crc32(RM)(R64 dst, RM src) if (valid!(RM, 8)) => emit!0(0xf2, 0x0f, 0x38, 0xf0, dst, src);
    @("r64", "rm64")
    auto crc32(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0xf2, 0x0f, 0x38, 0xf1, dst, src);

    // literally 1984
    // Why did I write this comment? What is literally 1984????
    @("r32", "m512")
    auto enqcmd(R32 dst, Mem!512 src) => emit!0(0xf2, 0x0f, 0x38, 0xf8, dst, src);
    @("r64", "m512")
    auto enqcmd(R64 dst, Mem!512 src) => emit!0(0xf2, 0x0f, 0x38, 0xf8, dst, src);

    @("rm8", "r8")
    auto cmpxchg(RM)(RM dst, R8 src) if (valid!(RM, 8)) => emit!0(0x0f, 0xb0, dst, src);
    @("rm16", "r16")
    auto cmpxchg(RM)(RM dst, R16 src) if (valid!(RM, 16)) => emit!0(0x0f, 0xb1, dst, src);
    @("rm32", "r32")
    auto cmpxchg(RM)(RM dst, R32 src) if (valid!(RM, 32)) => emit!0(0x0f, 0xb1, dst, src);
    @("rm64", "r64")
    auto cmpxchg(RM)(RM dst, R64 src) if (valid!(RM, 64)) => emit!0(0x0f, 0xb1, dst, src);

    auto aaa() => emit!0(0x37);
    auto aad() => emit!0(0xd5, 0x0a);
    @("imm8")
    auto aad(ubyte imm8) => emit!0(0xd5, imm8);
    auto aam() => emit!0(0xd4, 0x0a);
    @("imm8")
    auto aam(ubyte imm8) => emit!0(0xd4, imm8);
    auto aas() => emit!0(0x3f);

    @("imm8")
    auto add(ubyte imm8) => emit!0(0x04, imm8);
    @("imm16")
    auto add(ushort imm16) => emit!0(0x05, imm16);
    @("imm32")
    auto add(uint imm32) => emit!0(0x05, imm32);

    @("rm8", "imm8")
    auto add(RM)(RM dst, ubyte imm8) if (valid!(RM, 8)) => emit!0(0x80, dst, imm8);
    @("rm16", "imm16")
    auto add(RM)(RM dst, ushort imm16) if (valid!(RM, 16)) => emit!0(0x81, dst, imm16);
    @("rm32", "imm32")
    auto add(RM)(RM dst, uint imm32) if (valid!(RM, 32)) => emit!0(0x81, dst, imm32);
    @("rm64", "imm32")
    auto add(RM)(RM dst, uint imm32) if (valid!(RM, 64)) => emit!0(0x81, dst, imm32);
    @("rm16", "imm8")
    auto add(RM)(RM dst, ubyte imm8) if (valid!(RM, 16)) => emit!0(0x83, dst, imm8);
    @("rm32", "imm8")
    auto add(RM)(RM dst, ubyte imm8) if (valid!(RM, 32)) => emit!0(0x83, dst, imm8);
    @("rm64", "imm8")
    auto add(RM)(RM dst, ubyte imm8) if (valid!(RM, 64)) => emit!0(0x83, dst, imm8);

    @("rm8", "r8")
    auto add(RM)(RM dst, R8 src) if (valid!(RM, 8)) => emit!0(0x00, dst, src);
    @("rm16", "r16")
    auto add(RM)(RM dst, R16 src) if (valid!(RM, 16)) => emit!0(0x01, dst, src);
    @("rm32", "r32")
    auto add(RM)(RM dst, R32 src) if (valid!(RM, 32)) => emit!0(0x01, dst, src);
    @("rm64", "r64")
    auto add(RM)(RM dst, R64 src) if (valid!(RM, 64)) => emit!0(0x01, dst, src);

    @("r8", "m8")
    auto add(R8 dst, Mem!8 src) => emit!0(0x02, dst, src);
    @("r16", "m16")
    auto add(R16 dst, Mem!16 src) => emit!0(0x03, dst, src);
    @("r32", "m32")
    auto add(R32 dst, Mem!32 src) => emit!0(0x03, dst, src);
    @("r64", "m64")
    auto add(R64 dst, Mem!64 src) => emit!0(0x03, dst, src);

    @("imm8")
    auto and(ubyte imm8) => emit!0(0x24, imm8);
    @("imm16")
    auto and(ushort imm16) => emit!0(0x25, imm16);
    @("imm32")
    auto and(uint imm32) => emit!0(0x25, imm32);

    @("rm8", "imm8")
    auto and(RM)(RM dst, ubyte imm8) if (valid!(RM, 8)) => emit!4(0x80, dst, imm8);
    @("rm16", "imm16")
    auto and(RM)(RM dst, ushort imm16) if (valid!(RM, 16)) => emit!4(0x81, dst, imm16);
    @("rm32", "imm32")
    auto and(RM)(RM dst, uint imm32) if (valid!(RM, 32)) => emit!4(0x81, dst, imm32);
    @("rm64", "imm32")
    auto and(RM)(RM dst, uint imm32) if (valid!(RM, 64)) => emit!4(0x81, dst, imm32);
    @("rm16", "imm8")
    auto and(RM)(RM dst, ubyte imm8) if (valid!(RM, 16)) => emit!4(0x83, dst, imm8);
    @("rm32", "imm8")
    auto and(RM)(RM dst, ubyte imm8) if (valid!(RM, 32)) => emit!4(0x83, dst, imm8);
    @("rm64", "imm8")
    auto and(RM)(RM dst, ubyte imm8) if (valid!(RM, 64)) => emit!4(0x83, dst, imm8);

    @("rm8", "r8")
    auto and(RM)(RM dst, R8 src) if (valid!(RM, 8)) => emit!0(0x20, dst, src);
    @("rm16", "r16")
    auto and(RM)(RM dst, R16 src) if (valid!(RM, 16)) => emit!0(0x21, dst, src);
    @("rm32", "r32")
    auto and(RM)(RM dst, R32 src) if (valid!(RM, 32)) => emit!0(0x21, dst, src);
    @("rm64", "r64")
    auto and(RM)(RM dst, R64 src) if (valid!(RM, 64)) => emit!0(0x21, dst, src);

    @("r8", "m8")
    auto and(R8 dst, Mem!8 src) => emit!0(0x22, dst, src);
    @("r16", "m16")
    auto and(R16 dst, Mem!16 src) => emit!0(0x23, dst, src);
    @("r32", "m32")
    auto and(R32 dst, Mem!32 src) => emit!0(0x23, dst, src);
    @("r64", "m64")
    auto and(R64 dst, Mem!64 src) => emit!0(0x23, dst, src);

    @("rm16", "r16")
    auto arpl(RM)(RM dst, R16 src) if (valid!(RM, 16)) => emit!0(0x63, dst, src);

    @("r16", "rm16")
    auto bsf(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0xbc, dst, src);
    @("r32", "rm32")
    auto bsf(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0xbc, dst, src);
    @("r64", "rm64")
    auto bsf(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0xbc, dst, src);

    @("r16", "rm16")
    auto bsr(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0xbd, dst, src);
    @("r32", "rm32")
    auto bsr(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0xbd, dst, src);
    @("r64", "rm64")
    auto bsr(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0xbd, dst, src);

    @("r32")
    auto bswap(R32 dst) => emit!(0, ENCODED)(0x0f, 0xc8, dst);
    @("r64")
    auto bswap(R64 dst) => emit!(0, ENCODED)(0x0f, 0xc8, dst);

    @("rm16", "r16")
    auto bt(RM)(RM dst, R16 src) if (valid!(RM, 16)) => emit!0(0x0f, 0xa3, dst, src); 
    @("rm32", "r32")
    auto bt(RM)(RM dst, R32 src) if (valid!(RM, 32)) => emit!0(0x0f, 0xa3, dst, src); 
    @("rm64", "r64")
    auto bt(RM)(RM dst, R64 src) if (valid!(RM, 64)) => emit!0(0x0f, 0xa3, dst, src); 
    @("rm16", "imm8")
    auto bt(RM)(RM dst, ubyte imm8) if (valid!(RM, 16)) => emit!4(0x0f, 0xba, dst, imm8); 
    @("rm32", "imm8")
    auto bt(RM)(RM dst, ubyte imm8) if (valid!(RM, 32)) => emit!4(0x0f, 0xba, dst, imm8); 
    @("rm64", "imm8")
    auto bt(RM)(RM dst, ubyte imm8) if (valid!(RM, 64)) => emit!4(0x0f, 0xba, dst, imm8); 

    @("rm16", "r16")
    auto btc(RM)(RM dst, R16 src) if (valid!(RM, 16)) => emit!0(0x0f, 0xbb, dst, src); 
    @("rm32", "r32")
    auto btc(RM)(RM dst, R32 src) if (valid!(RM, 32)) => emit!0(0x0f, 0xbb, dst, src); 
    @("rm64", "r64")
    auto btc(RM)(RM dst, R64 src) if (valid!(RM, 64)) => emit!0(0x0f, 0xbb, dst, src); 
    @("rm16", "imm8")
    auto btc(RM)(RM dst, ubyte imm8) if (valid!(RM, 16)) => emit!7(0x0f, 0xba, dst, imm8); 
    @("rm32", "imm8")
    auto btc(RM)(RM dst, ubyte imm8) if (valid!(RM, 32)) => emit!7(0x0f, 0xba, dst, imm8); 
    @("rm64", "imm8")
    auto btc(RM)(RM dst, ubyte imm8) if (valid!(RM, 64)) => emit!7(0x0f, 0xba, dst, imm8); 

    @("rm16", "r16")
    auto btr(RM)(RM dst, R16 src) if (valid!(RM, 16)) => emit!0(0x0f, 0xb3, dst, src); 
    @("rm32", "r32")
    auto btr(RM)(RM dst, R32 src) if (valid!(RM, 32)) => emit!0(0x0f, 0xb3, dst, src); 
    @("rm64", "r64")
    auto btr(RM)(RM dst, R64 src) if (valid!(RM, 64)) => emit!0(0x0f, 0xb3, dst, src); 
    @("rm16", "imm8")
    auto btr(RM)(RM dst, ubyte imm8) if (valid!(RM, 16)) => emit!6(0x0f, 0xba, dst, imm8); 
    @("rm32", "imm8")
    auto btr(RM)(RM dst, ubyte imm8) if (valid!(RM, 32)) => emit!6(0x0f, 0xba, dst, imm8); 
    @("rm64", "imm8")
    auto btr(RM)(RM dst, ubyte imm8) if (valid!(RM, 64)) => emit!6(0x0f, 0xba, dst, imm8); 

    @("rm16", "r16")
    auto bts(RM)(RM dst, R16 src) if (valid!(RM, 16)) => emit!0(0x0f, 0xab, dst, src); 
    @("rm32", "r32")
    auto bts(RM)(RM dst, R32 src) if (valid!(RM, 32)) => emit!0(0x0f, 0xab, dst, src); 
    @("rm64", "r64")
    auto bts(RM)(RM dst, R64 src) if (valid!(RM, 64)) => emit!0(0x0f, 0xab, dst, src); 
    @("rm16", "imm8")
    auto bts(RM)(RM dst, ubyte imm8) if (valid!(RM, 16)) => emit!5(0x0f, 0xba, dst, imm8); 
    @("rm32", "imm8")
    auto bts(RM)(RM dst, ubyte imm8) if (valid!(RM, 32)) => emit!5(0x0f, 0xba, dst, imm8); 
    @("rm64", "imm8")
    auto bts(RM)(RM dst, ubyte imm8) if (valid!(RM, 64)) => emit!5(0x0f, 0xba, dst, imm8);

    @("imm8")
    auto cmp(ubyte imm8) => emit!0(0x3c, imm8);
    @("imm16")
    auto cmp(ushort imm16) => emit!0(0x3d, imm16);
    @("imm32")
    auto cmp(uint imm32) => emit!0(0x3d, imm32);

    @("rm8", "imm8")
    auto cmp(RM)(RM dst, ubyte imm8) if (valid!(RM, 8)) => emit!7(0x80, dst, imm8);
    @("rm16", "imm16")
    auto cmp(RM)(RM dst, ushort imm16) if (valid!(RM, 16)) => emit!7(0x81, dst, imm16);
    @("rm32", "imm32")
    auto cmp(RM)(RM dst, uint imm32) if (valid!(RM, 32)) => emit!7(0x81, dst, imm32);
    @("rm64", "imm32")
    auto cmp(RM)(RM dst, uint imm32) if (valid!(RM, 64)) => emit!7(0x81, dst, imm32);
    @("rm16", "imm8")
    auto cmp(RM)(RM dst, ubyte imm8) if (valid!(RM, 16)) => emit!7(0x83, dst, imm8); 
    @("rm32", "imm8")
    auto cmp(RM)(RM dst, ubyte imm8) if (valid!(RM, 32)) => emit!7(0x83, dst, imm8); 
    @("rm64", "imm8")
    auto cmp(RM)(RM dst, ubyte imm8) if (valid!(RM, 64)) => emit!7(0x83, dst, imm8); 

    @("rm8", "r8")
    auto cmp(RM)(RM dst, R8 src) if (valid!(RM, 8)) => emit!0(0x38, dst, src);
    @("rm16", "r16")
    auto cmp(RM)(RM dst, R16 src) if (valid!(RM, 16)) => emit!0(0x39, dst, src);
    @("rm32", "r32")
    auto cmp(RM)(RM dst, R32 src) if (valid!(RM, 32)) => emit!0(0x39, dst, src);
    @("rm64", "r64")
    auto cmp(RM)(RM dst, R64 src) if (valid!(RM, 64)) => emit!0(0x39, dst, src);

    @("r8", "m8")
    auto cmp(R8 dst, Mem!8 src) => emit!0(0x3a, dst, src);
    @("r16", "m16")
    auto cmp(R16 dst, Mem!16 src) => emit!0(0x3b, dst, src);
    @("r32", "m32")
    auto cmp(R32 dst, Mem!32 src) => emit!0(0x3b, dst, src);
    @("r64", "m64")
    auto cmp(R64 dst, Mem!64 src) => emit!0(0x3b, dst, src);

    auto cwd() => emit!0(0x66, 0x99);
    auto cdq() => emit!0(0x99);
    auto cqo() => emit!0(0x48, 0x99);

    auto cbw() => emit!0(0x66, 0x98);
    auto cwde() => emit!0(0x98);
    auto cdqe() => emit!0(0x48, 0x98);

    auto cpuid() => emit!0(0x0f, 0xa2);
    @("imm32")
    auto cpuid(uint imm32) => mov(eax, imm32) + cpuid();

    auto clc() => emit!0(0xf8);
    auto cld() => emit!0(0xfc);
    auto cli() => emit!0(0xfa);
    auto clts() => emit!0(0x0f, 0x06);

    auto cmc() => emit!0(0xf5);

    @("rm8")
    auto dec(RM)(RM dst) if (valid!(RM, 8)) => emit!1(0xfe, dst);
    static if (X64)
    @("rm16")
    auto dec(RM)(RM dst) if (valid!(RM, 16)) => emit!1(0xff, dst);
    static if (!X64)
    @("m16")
    auto dec(Mem!16 dst) => emit!1(0xff, dst);
    static if (X64)
    @("rm32")
    auto dec(RM)(RM dst) if (valid!(RM, 32)) => emit!1(0xff, dst);
    static if (!X64)
    @("m32")
    auto dec(Mem!32 dst) => emit!1(0xff, dst);
    @("rm64")
    auto dec(RM)(RM dst) if (valid!(RM, 64)) => emit!1(0xff, dst);

    static if (!X64)
    @("r16")
    auto dec(R16 dst) => emit!(0, ENCODED)(0x48, dst);
    static if (!X64)
    @("r32")
    auto dec(R32 dst) => emit!(0, ENCODED)(0x48, dst);

    auto int3() => emit!0(0xcc);
    @("imm8")
    auto _int(ubyte imm8) => emit!0(0xcd, imm8);
    auto into() => emit!0(0xce);
    auto int1() => emit!0(0xf1);
    @("r32", "rm32")
    auto ud0(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0xff, dst, src);
    @("r32", "rm32")
    auto ud1(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0xb9, dst, src);
    auto ud2() => emit!0(0x0f, 0x0b);
    
    auto iret() => emit!0(0xcf);
    auto iretd() => emit!0(0xcf);
    auto iretq() => emit!0(0xcf);

    @("rm8")
    auto inc(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0xfe, dst);
    static if (X64)
    @("rm16")
    auto inc(RM)(RM dst) if (valid!(RM, 16)) => emit!0(0xff, dst);
    static if (!X64)
    @("m16")
    auto inc(Mem!16 dst) => emit!0(0xff, dst);
    static if (X64)
    @("rm32")
    auto inc(RM)(RM dst) if (valid!(RM, 32)) => emit!0(0xff, dst);
    static if (!X64)
    @("m32")
    auto inc(Mem!32 dst) => emit!0(0xff, dst);
    @("rm64")
    auto inc(RM)(RM dst) if (valid!(RM, 64)) => emit!0(0xff, dst);

    static if (!X64)
    @("r16")
    auto inc(R16 dst) => emit!(0, ENCODED)(0x40, dst);
    static if (!X64)
    @("r32")
    auto inc(R32 dst) => emit!(0, ENCODED)(0x40, dst);

    auto hlt() => emit!0(0xf4);
    auto pause() => emit!0(0xf3, 0x90);
    auto swapgs() => emit!0(0x0f, 0x01, 0xf8);
    
    @("prefix")
    auto lock(size_t size)
    {
        buffer = buffer[0..(buffer.length - size)]~0xf0~buffer[(buffer.length - size)..$];
        return size + 1;
    }

    auto wait() => emit!0(0x9b);
    auto fwait() => emit!0(0x9b);

    auto sysretc() => emit!0(0x0f, 0x07);
    auto sysret() => emit!0(0x0f, 0x07);
    auto syscall() => emit!0(0x0f, 0x05);
    auto rsm() => emit!0(0x0f, 0xaa);

    auto leave() => emit!0(0xc9);
    @("imm16")
    auto enter(ushort imm16) => emit!0(0xc8, imm16, 0x00);
    @("imm16", "imm8")
    auto enter(ushort imm16, ubyte imm8) => emit!0(0xc8, imm16, imm8);
    
    @("r16", "m16")
    auto lea(RM)(R16 dst, Mem!16) => emit!0(0x8d, dst, src);
    @("r32", "m32")
    auto lea(RM)(R32 dst, Mem!32) => emit!0(0x8d, dst, src);
    @("r64", "m64")
    auto lea(RM)(R64 dst, Mem!64) => emit!0(0x8d, dst, src);

    @("r16", "m16")
    auto lds(RM)(R16 dst, Mem!16) => emit!0(0xc5, dst, src);
    @("r32", "m32")
    auto lds(RM)(R32 dst, Mem!32) => emit!0(0xc5, dst, src);

    @("r16", "m16")
    auto lss(RM)(R16 dst, Mem!16) => emit!0(0x0f, 0xb2, dst, src);
    @("r32", "m32")
    auto lss(RM)(R32 dst, Mem!32) => emit!0(0x0f, 0xb2, dst, src);
    @("r64", "m64")
    auto lss(RM)(R64 dst, Mem!64) => emit!0(0x0f, 0xb2, dst, src);

    @("r16", "m16")
    auto les(RM)(R16 dst, Mem!16) => emit!0(0xc4, dst, src);
    @("r32", "m32")
    auto les(RM)(R32 dst, Mem!32) => emit!0(0xc4, dst, src);

    @("r16", "m16")
    auto lfs(RM)(R16 dst, Mem!16) => emit!0(0x0f, 0xb4, dst, src);
    @("r32", "m32")
    auto lfs(RM)(R32 dst, Mem!32) => emit!0(0x0f, 0xb4, dst, src);
    @("r64", "m64")
    auto lfs(RM)(R64 dst, Mem!64) => emit!0(0x0f, 0xb4, dst, src);

    @("r16", "m16")
    auto lgs(RM)(R16 dst, Mem!16) => emit!0(0x0f, 0xb5, dst, src);
    @("r32", "m32")
    auto lgs(RM)(R32 dst, Mem!32) => emit!0(0x0f, 0xb5, dst, src);
    @("r64", "m64")
    auto lgs(RM)(R64 dst, Mem!64) => emit!0(0x0f, 0xb5, dst, src);

    @("r16", "rm16")
    auto lsl(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x03, dst, src);
    @("r32", "r32")
    auto lsl(R32 dst, R32 src) => emit!0(0x0f, 0x03, dst, src);
    @("r64", "r32")
    auto lsl(R64 dst, R32 src) => emit!0(0x0f, 0x03, dst, src);
    @("r32", "m16")
    auto lsl(R32 dst, Mem!16 src) => emit!0(0x0f, 0x03, dst, src);
    @("r64", "m16")
    auto lsl(R64 dst, Mem!16 src) => emit!0(0x0f, 0x03, dst, src);

    @("rm16")
    auto ltr(RM)(RM dst) if (valid!(RM, 16)) => emit!3(0x0f, 0x00, dst);
    @("rm16")
    auto str(RM)(RM dst) if (valid!(RM, 16)) => emit!1(0x0f, 0x00, dst);

    @("rm8")
    auto neg(RM)(RM dst) if (valid!(RM, 8)) => emit!3(0xf6, dst);
    @("rm16")
    auto neg(RM)(RM dst) if (valid!(RM, 16)) => emit!3(0xf7, dst);
    @("rm32")
    auto neg(RM)(RM dst) if (valid!(RM, 32)) => emit!3(0xf7, dst);
    @("rm64")
    auto neg(RM)(RM dst) if (valid!(RM, 64)) => emit!3(0xf7, dst);

    auto nop() => emit!0(0x90);
    @("rm16")
    auto nop(RM)(RM dst) if (valid!(RM, 16)) => emit!0(0x0f, 0x1f, dst);

    @("rm8")
    auto not(RM)(RM dst) if (valid!(RM, 8)) => emit!2(0xf6, dst);
    @("rm16")
    auto not(RM)(RM dst) if (valid!(RM, 16)) => emit!2(0xf7, dst);
    @("rm32")
    auto not(RM)(RM dst) if (valid!(RM, 32)) => emit!2(0xf7, dst);
    @("rm64")
    auto not(RM)(RM dst) if (valid!(RM, 64)) => emit!2(0xf7, dst);

    auto ret() => emit!0(0xc3);
    @("imm16")
    auto ret(ushort imm16) => emit!0(0xc2, imm16);
    auto retf() => emit!0(0xcb);
    @("imm16")
    auto retf(ushort imm16) => emit!0(0xca, imm16);

    auto stc() => emit!0(0xf9);
    auto std() => emit!0(0xfd);
    auto sti() => emit!0(0xfb);

    @("imm8")
    auto sub(ubyte imm8) => emit!0(0x2c, imm8);
    @("imm16")
    auto sub(ushort imm16) => emit!0(0x2d, imm16);
    @("imm32")
    auto sub(uint imm32) => emit!0(0x2d, imm32);

    @("rm8", "imm8")
    auto sub(RM)(RM dst, ubyte imm8) if (valid!(RM, 8)) => emit!5(0x80, dst, imm8);
    @("rm16", "imm16")
    auto sub(RM)(RM dst, ushort imm16) if (valid!(RM, 16)) => emit!5(0x81, dst, imm16);
    @("rm32", "imm32")
    auto sub(RM)(RM dst, uint imm32) if (valid!(RM, 32)) => emit!5(0x81, dst, imm32);
    @("rm64", "imm32")
    auto sub(RM)(RM dst, uint imm32) if (valid!(RM, 64)) => emit!5(0x81, dst, imm32);
    @("rm16", "imm8")
    auto sub(RM)(RM dst, ubyte imm8) if (valid!(RM, 16)) => emit!5(0x83, dst, imm8);
    @("rm32", "imm8")
    auto sub(RM)(RM dst, ubyte imm8) if (valid!(RM, 32)) => emit!5(0x83, dst, imm8);
    @("rm64", "imm8")
    auto sub(RM)(RM dst, ubyte imm8) if (valid!(RM, 64)) => emit!5(0x83, dst, imm8);

    @("rm8", "r8")
    auto sub(RM)(RM dst, R8 src) if (valid!(RM, 8)) => emit!0(0x28, dst, src);
    @("rm16", "r16")
    auto sub(RM)(RM dst, R16 src) if (valid!(RM, 16)) => emit!0(0x29, dst, src);
    @("rm32", "r32")
    auto sub(RM)(RM dst, R32 src) if (valid!(RM, 32)) => emit!0(0x29, dst, src);
    @("rm64", "r64")
    auto sub(RM)(RM dst, R64 src) if (valid!(RM, 64)) => emit!0(0x29, dst, src);

    @("r8", "m8")
    auto sub(R8 dst, Mem!8 src) => emit!0(0x2a, dst, src);
    @("r16", "m16")
    auto sub(R16 dst, Mem!16 src) => emit!0(0x2b, dst, src);
    @("r32", "m32")
    auto sub(R32 dst, Mem!32 src) => emit!0(0x2b, dst, src);
    @("r64", "m64")
    auto sub(R64 dst, Mem!64 src) => emit!0(0x2b, dst, src);

    @("imm8")
    auto sbb(ubyte imm8) => emit!0(0x1c, imm8);
    @("imm16")
    auto sbb(ushort imm16) => emit!0(0x1d, imm16);
    @("imm32")
    auto sbb(uint imm32) => emit!0(0x1d, imm32);

    @("rm8", "imm8")
    auto sbb(RM)(RM dst, ubyte imm8) if (valid!(RM, 8)) => emit!3(0x80, dst, imm8);
    @("rm16", "imm16")
    auto sbb(RM)(RM dst, ushort imm16) if (valid!(RM, 16)) => emit!3(0x81, dst, imm16);
    @("rm32", "imm32")
    auto sbb(RM)(RM dst, uint imm32) if (valid!(RM, 32)) => emit!3(0x81, dst, imm32);
    @("rm64", "imm32")
    auto sbb(RM)(RM dst, uint imm32) if (valid!(RM, 64)) => emit!3(0x81, dst, imm32);
    @("rm16", "imm8")
    auto sbb(RM)(RM dst, ubyte imm8) if (valid!(RM, 16)) => emit!3(0x83, dst, imm8);
    @("rm32", "imm8")
    auto sbb(RM)(RM dst, ubyte imm8) if (valid!(RM, 32)) => emit!3(0x83, dst, imm8);
    @("rm64", "imm8")
    auto sbb(RM)(RM dst, ubyte imm8) if (valid!(RM, 64)) => emit!3(0x83, dst, imm8);

    @("rm8", "r8")
    auto sbb(RM)(RM dst, R8 src) if (valid!(RM, 8)) => emit!0(0x18, dst, src);
    @("rm16", "r16")
    auto sbb(RM)(RM dst, R16 src) if (valid!(RM, 16)) => emit!0(0x19, dst, src);
    @("rm32", "r32")
    auto sbb(RM)(RM dst, R32 src) if (valid!(RM, 32)) => emit!0(0x19, dst, src);
    @("rm64", "r64")
    auto sbb(RM)(RM dst, R64 src) if (valid!(RM, 64)) => emit!0(0x19, dst, src);

    @("r8", "m8")
    auto sbb(R8 dst, Mem!8 src) => emit!0(0x1a, dst, src);
    @("r16", "m16")
    auto sbb(R16 dst, Mem!16 src) => emit!0(0x1b, dst, src);
    @("r32", "m32")
    auto sbb(R32 dst, Mem!32 src) => emit!0(0x1b, dst, src);
    @("r64", "m64")
    auto sbb(R64 dst, Mem!64 src) => emit!0(0x1b, dst, src);

    @("imm8")
    auto xor(ubyte imm8) => emit!0(0x34, imm8);
    @("imm16")
    auto xor(ushort imm16) => emit!0(0x35, imm16);
    @("imm32")
    auto xor(uint imm32) => emit!0(0x35, imm32);

    @("r8", "imm8")
    auto xor(RM)(RM dst, ubyte imm8) if (valid!(RM, 8)) => emit!6(0x80, dst, imm8);
    @("r16", "imm16")
    auto xor(RM)(RM dst, ushort imm16) if (valid!(RM, 16)) => emit!6(0x81, dst, imm16);
    @("r32", "imm32")
    auto xor(RM)(RM dst, uint imm32) if (valid!(RM, 32)) => emit!6(0x81, dst, imm32);
    @("r64", "imm32")
    auto xor(RM)(RM dst, uint imm32) if (valid!(RM, 64)) => emit!6(0x81, dst, imm32);
    @("r16", "imm8")
    auto xor(RM)(RM dst, ubyte imm8) if (valid!(RM, 16)) => emit!6(0x83, dst, imm8);
    @("r32", "imm8")
    auto xor(RM)(RM dst, ubyte imm8) if (valid!(RM, 32)) => emit!6(0x83, dst, imm8);
    @("r64", "imm8")
    auto xor(RM)(RM dst, ubyte imm8) if (valid!(RM, 64)) => emit!6(0x83, dst, imm8);

    @("rm8", "r8")
    auto xor(RM)(RM dst, R8 src) if (valid!(RM, 8)) => emit!0(0x30, dst, src);
    @("rm16", "r16")
    auto xor(RM)(RM dst, R16 src) if (valid!(RM, 16)) => emit!0(0x31, dst, src);
    @("rm32", "r32")
    auto xor(RM)(RM dst, R32 src) if (valid!(RM, 32)) => emit!0(0x31, dst, src);
    @("rm64", "r64")
    auto xor(RM)(RM dst, R64 src) if (valid!(RM, 64)) => emit!0(0x31, dst, src);

    @("r8", "m8")
    auto xor(R8 dst, Mem!8 src) => emit!0(0x32, dst, src);
    @("r16", "m16")
    auto xor(R16 dst, Mem!16 src) => emit!0(0x33, dst, src);
    @("r32", "m32")
    auto xor(R32 dst, Mem!32 src) => emit!0(0x33, dst, src);
    @("r64", "m64")
    auto xor(R64 dst, Mem!64 src) => emit!0(0x33, dst, src);

    @("imm8")
    auto or(ubyte imm8) => emit!0(0x0c, imm8);
    @("imm16")
    auto or(ushort imm16) => emit!0(0x0d, imm16);
    @("imm32")
    auto or(uint imm32) => emit!0(0x0d, imm32);

    @("r8", "imm8")
    auto or(RM)(RM dst, ubyte imm8) if (valid!(RM, 8)) => emit!1(0x80, dst, imm8);
    @("r16", "imm16")
    auto or(RM)(RM dst, ushort imm16) if (valid!(RM, 16)) => emit!1(0x81, dst, imm16);
    @("r32", "imm32")
    auto or(RM)(RM dst, uint imm32) if (valid!(RM, 32)) => emit!1(0x81, dst, imm32);
    @("r64", "imm32")
    auto or(RM)(RM dst, uint imm32) if (valid!(RM, 64)) => emit!1(0x81, dst, imm32);
    @("r16", "imm8")
    auto or(RM)(RM dst, ubyte imm8) if (valid!(RM, 16)) => emit!1(0x83, dst, imm8);
    @("r32", "imm8")
    auto or(RM)(RM dst, ubyte imm8) if (valid!(RM, 32)) => emit!1(0x83, dst, imm8);
    @("r64", "imm8")
    auto or(RM)(RM dst, ubyte imm8) if (valid!(RM, 64)) => emit!1(0x83, dst, imm8);

    @("rm8", "r8")
    auto or(RM)(RM dst, R8 src) if (valid!(RM, 8)) => emit!0(0x8, dst, src);
    @("rm16", "r16")
    auto or(RM)(RM dst, R16 src) if (valid!(RM, 16)) => emit!0(0x9, dst, src);
    @("rm32", "r32")
    auto or(RM)(RM dst, R32 src) if (valid!(RM, 32)) => emit!0(0x9, dst, src);
    @("rm64", "r64")
    auto or(RM)(RM dst, R64 src) if (valid!(RM, 64)) => emit!0(0x9, dst, src);

    @("r8", "m8")
    auto or(R8 dst, Mem!8 src) => emit!0(0xa, dst, src);
    @("r16", "m16")
    auto or(R16 dst, Mem!16 src) => emit!0(0xb, dst, src);
    @("r32", "m32")
    auto or(R32 dst, Mem!32 src) => emit!0(0xb, dst, src);
    @("r64", "m64")
    auto or(R64 dst, Mem!64 src) => emit!0(0xb, dst, src);

    @("rm8")
    auto sal(RM)(RM dst) if (valid!(RM, 8)) => emit!4(0xd2, dst, cl);
    @("rm8", "imm8")
    auto sal(RM)(RM dst, ubyte imm8) if (valid!(RM, 8))
    {
        if (imm8 == 1)
            return emit!4(0xd0, dst);
        else
            return emit!4(0xc0, dst, imm8);
    }
    @("rm16")
    auto sal(RM)(RM dst) if (valid!(RM, 16)) => emit!4(0xd3, dst, cl);
    @("rm16", "imm8")
    auto sal(RM)(RM dst, ubyte imm8) if (valid!(RM, 16))
    {
        if (imm8 == 1)
            return emit!4(0xd1, dst);
        else
            return emit!4(0xc1, dst, imm8);
    }
    @("rm32")
    auto sal(RM)(RM dst) if (valid!(RM, 32)) => emit!4(0xd3, dst, cl);
    @("rm32", "imm8")
    auto sal(RM)(RM dst, ubyte imm8) if (valid!(RM, 32))
    {
        if (imm8 == 1)
            return emit!4(0xd1, dst);
        else
            return emit!4(0xc1, dst, imm8);
    }
    @("rm64")
    auto sal(RM)(RM dst) if (valid!(RM, 64)) => emit!4(0xd3, dst, cl);
    @("rm64", "imm8")
    auto sal(RM)(RM dst, ubyte imm8) if (valid!(RM, 64))
    {
        if (imm8 == 1)
            return emit!4(0xd1, dst);
        else
            return emit!4(0xc1, dst, imm8);
    }

    @("rm8")
    auto sar(RM)(RM dst) if (valid!(RM, 8)) => emit!7(0xd2, dst, cl);
    @("rm8", "imm8")
    auto sar(RM)(RM dst, ubyte imm8) if (valid!(RM, 8))
    {
        if (imm8 == 1)
            return emit!7(0xd0, dst);
        else
            return emit!7(0xc0, dst, imm8);
    }
    @("rm16")
    auto sar(RM)(RM dst) if (valid!(RM, 16)) => emit!7(0xd3, dst, cl);
    @("rm16", "imm8")
    auto sar(RM)(RM dst, ubyte imm8) if (valid!(RM, 16))
    {
        if (imm8 == 1)
            return emit!7(0xd1, dst);
        else
            return emit!7(0xc1, dst, imm8);
    }
    @("rm32")
    auto sar(RM)(RM dst) if (valid!(RM, 32)) => emit!7(0xd3, dst, cl);
    @("rm32", "imm8")
    auto sar(RM)(RM dst, ubyte imm8) if (valid!(RM, 32))
    {
        if (imm8 == 1)
            return emit!7(0xd1, dst);
        else
            return emit!7(0xc1, dst, imm8);
    }
    @("rm64")
    auto sar(RM)(RM dst) if (valid!(RM, 64)) => emit!7(0xd3, dst, cl);
    @("rm64", "imm8")
    auto sar(RM)(RM dst, ubyte imm8) if (valid!(RM, 64))
    {
        if (imm8 == 1)
            return emit!7(0xd1, dst);
        else
            return emit!7(0xc1, dst, imm8);
    }

    @("rm8")
    auto shl(RM)(RM dst) if (valid!(RM, 8)) => sal(dst);
    @("rm8", "imm8")
    auto shl(RM)(RM dst, ubyte imm8) if (valid!(RM, 8)) => sal(dst, imm8);
    @("rm16")
    auto shl(RM)(RM dst) if (valid!(RM, 16)) => sal(dst);
    @("rm16", "imm8")
    auto shl(RM)(RM dst, ubyte imm8) if (valid!(RM, 16)) => sal(dst, imm8);
    @("rm32")
    auto shl(RM)(RM dst) if (valid!(RM, 32)) => sal(dst);
    @("rm32", "imm8")
    auto shl(RM)(RM dst, ubyte imm8) if (valid!(RM, 32)) => sal(dst, imm8);
    @("rm64")
    auto shl(RM)(RM dst) if (valid!(RM, 64)) => sal(dst);
    @("rm64", "imm8")
    auto shl(RM)(RM dst, ubyte imm8) if (valid!(RM, 64)) => sal(dst, imm8);

    @("rm8")
    auto shr(RM)(RM dst) if (valid!(RM, 8)) => emit!5(0xd2, dst, cl);
    @("rm8", "imm8")
    auto shr(RM)(RM dst, ubyte imm8) if (valid!(RM, 8))
    {
        if (imm8 == 1)
            return emit!5(0xd0, dst);
        else
            return emit!5(0xc0, dst, imm8);
    }
    @("rm16")
    auto shr(RM)(RM dst) if (valid!(RM, 16)) => emit!5(0xd3, dst, cl);
    @("rm16", "imm8")
    auto shr(RM)(RM dst, ubyte imm8) if (valid!(RM, 16))
    {
        if (imm8 == 1)
            return emit!5(0xd1, dst);
        else
            return emit!5(0xc1, dst, imm8);
    }
    @("rm32")
    auto shr(RM)(RM dst) if (valid!(RM, 32)) => emit!5(0xd3, dst, cl);
    @("rm32", "imm8")
    auto shr(RM)(RM dst, ubyte imm8) if (valid!(RM, 32))
    {
        if (imm8 == 1)
            return emit!5(0xd1, dst);
        else
            return emit!5(0xc1, dst, imm8);
    }
    @("rm64")
    auto shr(RM)(RM dst) if (valid!(RM, 64)) => emit!5(0xd3, dst, cl);
    @("rm64", "imm8")
    auto shr(RM)(RM dst, ubyte imm8) if (valid!(RM, 64))
    {
        if (imm8 == 1)
            return emit!5(0xd1, dst);
        else
            return emit!5(0xc1, dst, imm8);
    }

    @("rm8")
    auto rcl(RM)(RM dst) if (valid!(RM, 8)) => emit!2(0xd2, dst, cl);
    @("rm8", "imm8")
    auto rcl(RM)(RM dst, ubyte imm8) if (valid!(RM, 8))
    {
        if (imm8 == 1)
            return emit!2(0xd0, dst);
        else
            return emit!2(0xc0, dst, imm8);
    }
    @("rm16")
    auto rcl(RM)(RM dst) if (valid!(RM, 16)) => emit!2(0xd3, dst, cl);
    @("rm16", "imm8")
    auto rcl(RM)(RM dst, ubyte imm8) if (valid!(RM, 16))
    {
        if (imm8 == 1)
            return emit!2(0xd1, dst);
        else
            return emit!2(0xc1, dst, imm8);
    }
    @("rm32")
    auto rcl(RM)(RM dst) if (valid!(RM, 32)) => emit!2(0xd3, dst, cl);
    @("rm32", "imm8")
    auto rcl(RM)(RM dst, ubyte imm8) if (valid!(RM, 32))
    {
        if (imm8 == 1)
            return emit!2(0xd1, dst);
        else
            return emit!2(0xc1, dst, imm8);
    }
    @("rm64")
    auto rcl(RM)(RM dst) if (valid!(RM, 64)) => emit!2(0xd3, dst, cl);
    @("rm64", "imm8")
    auto rcl(RM)(RM dst, ubyte imm8) if (valid!(RM, 64))
    {
        if (imm8 == 1)
            return emit!2(0xd1, dst);
        else
            return emit!2(0xc1, dst, imm8);
    }

    @("rm8")
    auto rcr(RM)(RM dst) if (valid!(RM, 8)) => emit!3(0xd2, dst, cl);
    @("rm8", "imm8")
    auto rcr(RM)(RM dst, ubyte imm8) if (valid!(RM, 8))
    {
        if (imm8 == 1)
            return emit!3(0xd0, dst);
        else
            return emit!3(0xc0, dst, imm8);
    }
    @("rm16")
    auto rcr(RM)(RM dst) if (valid!(RM, 16)) => emit!3(0xd3, dst, cl);
    @("rm16", "imm8")
    auto rcr(RM)(RM dst, ubyte imm8) if (valid!(RM, 16))
    {
        if (imm8 == 1)
            return emit!3(0xd1, dst);
        else
            return emit!3(0xc1, dst, imm8);
    }
    @("rm32")
    auto rcr(RM)(RM dst) if (valid!(RM, 32)) => emit!3(0xd3, dst, cl);
    @("rm32", "imm8")
    auto rcr(RM)(RM dst, ubyte imm8) if (valid!(RM, 32))
    {
        if (imm8 == 1)
            return emit!3(0xd1, dst);
        else
            return emit!3(0xc1, dst, imm8);
    }
    @("rm64")
    auto rcr(RM)(RM dst) if (valid!(RM, 64)) => emit!3(0xd3, dst, cl);
    @("rm64", "imm8")
    auto rcr(RM)(RM dst, ubyte imm8) if (valid!(RM, 64))
    {
        if (imm8 == 1)
            return emit!3(0xd1, dst);
        else
            return emit!3(0xc1, dst, imm8);
    }

    @("rm8")
    auto rol(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0xd2, dst, cl);
    @("rm8", "imm8")
    auto rol(RM)(RM dst, ubyte imm8) if (valid!(RM, 8))
    {
        if (imm8 == 1)
            return emit!0(0xd0, dst);
        else
            return emit!0(0xc0, dst, imm8);
    }
    @("rm16")
    auto rol(RM)(RM dst) if (valid!(RM, 16)) => emit!0(0xd3, dst, cl);
    @("rm16", "imm8")
    auto rol(RM)(RM dst, ubyte imm8) if (valid!(RM, 16))
    {
        if (imm8 == 1)
            return emit!0(0xd1, dst);
        else
            return emit!0(0xc1, dst, imm8);
    }
    @("rm32")
    auto rol(RM)(RM dst) if (valid!(RM, 32)) => emit!0(0xd3, dst, cl);
    @("rm32", "imm8")
    auto rol(RM)(RM dst, ubyte imm8) if (valid!(RM, 32))
    {
        if (imm8 == 1)
            return emit!0(0xd1, dst);
        else
            return emit!0(0xc1, dst, imm8);
    }
    @("rm64")
    auto rol(RM)(RM dst) if (valid!(RM, 64)) => emit!0(0xd3, dst, cl);
    @("rm64", "imm8")
    auto rol(RM)(RM dst, ubyte imm8) if (valid!(RM, 64))
    {
        if (imm8 == 1)
            return emit!0(0xd1, dst);
        else
            return emit!0(0xc1, dst, imm8);
    }

    @("rm8")
    auto ror(RM)(RM dst) if (valid!(RM, 8)) => emit!1(0xd2, dst, cl);
    @("rm8", "imm8")
    auto ror(RM)(RM dst, ubyte imm8) if (valid!(RM, 8))
    {
        if (imm8 == 1)
            return emit!1(0xd0, dst);
        else
            return emit!1(0xc0, dst, imm8);
    }
    @("rm16")
    auto ror(RM)(RM dst) if (valid!(RM, 16)) => emit!1(0xd3, dst, cl);
    @("rm16", "imm8")
    auto ror(RM)(RM dst, ubyte imm8) if (valid!(RM, 16))
    {
        if (imm8 == 1)
            return emit!1(0xd1, dst);
        else
            return emit!1(0xc1, dst, imm8);
    }
    @("rm32")
    auto ror(RM)(RM dst) if (valid!(RM, 32)) => emit!1(0xd3, dst, cl);
    @("rm32", "imm8")
    auto ror(RM)(RM dst, ubyte imm8) if (valid!(RM, 32))
    {
        if (imm8 == 1)
            return emit!1(0xd1, dst);
        else
            return emit!1(0xc1, dst, imm8);
    }
    @("rm64")
    auto ror(RM)(RM dst) if (valid!(RM, 64)) => emit!1(0xd3, dst, cl);
    @("rm64", "imm8")
    auto ror(RM)(RM dst, ubyte imm8) if (valid!(RM, 64))
    {
        if (imm8 == 1)
            return emit!1(0xd1, dst);
        else
            return emit!1(0xc1, dst, imm8);
    }

    @("rm16")
    auto verr(RM)(RM dst) if (valid!(RM, 16)) => emit!4(0xf0, 0x00, dst);
    @("rm16")
    auto verw(RM)(RM dst) if (valid!(RM, 16)) => emit!5(0xf0, 0x00, dst);

    @("imm8")
    auto test(ubyte imm8) => emit!0(0xa8, imm8);
    @("imm16")
    auto test(ushort imm16) => emit!0(0xa9, imm16);
    @("imm32")
    auto test(uint imm32) => emit!0(0xa9, imm32);

    @("rm8", "imm8")
    auto test(RM)(RM dst, ubyte imm8) if (valid!(RM, 8)) => emit!0(0xf6, dst, imm8);
    @("rm16", "imm16")
    auto test(RM)(RM dst, ushort imm16) if (valid!(RM, 16)) => emit!0(0xf7, dst, imm16);
    @("rm32", "imm32")
    auto test(RM)(RM dst, uint imm32) if (valid!(RM, 32)) => emit!0(0xf7, dst, imm32);
    @("rm64", "imm32")
    auto test(RM)(RM dst, uint imm32) if (valid!(RM, 64)) => emit!0(0xf7, dst, cast(long)imm32);

    @("rm8", "r8")
    auto test(RM)(RM dst, R8 src) if (valid!(RM, 8)) => emit!0(0x84, dst, src);
    @("rm16", "r16")
    auto test(RM)(RM dst, R16 src) if (valid!(RM, 16)) => emit!0(0x85, dst, src);
    @("rm32", "r32")
    auto test(RM)(RM dst, R32 src) if (valid!(RM, 32)) => emit!0(0x85, dst, src);
    @("rm64", "r64")
    auto test(RM)(RM dst, R64 src) if (valid!(RM, 64)) => emit!0(0x85, dst, src);

    @("m16")
    auto pop(Mem!16 dst) => emit!0(0x8f, dst);
    static if (!X64)
    @("m32")
    auto pop(Mem!32 dst) => emit!(0, NO_REX)(0x8f, dst);
    static if (X64)
    @("m64")
    auto pop(Mem!64 dst) => emit!(0, NO_REX)(0x8f, dst);

    @("r16")
    auto pop(R16 dst) => emit!(0, ENCODED | NO_REX_W)(0x58, dst);
    static if (!X64)
    @("r32")
    auto pop(R32 dst) => emit!(0, ENCODED | NO_REX_W)(0x58, dst);
    static if (X64)
    @("r64")
    auto pop(R64 dst) => emit!(0, ENCODED | NO_REX_W)(0x58, dst);

    auto popds() => emit!0(0x1f);
    auto popes() => emit!0(0x07);
    auto popss() => emit!0(0x17);
    auto popfs() => emit!0(0x0f, 0xa1);
    auto popgs() => emit!0(0x0f, 0xa9); 

    auto popa() => emit!0(0x61);
    auto popad() => emit!0(0x61);

    auto popf() => emit!0(0x9d);
    auto popfd() => emit!0(0x9d);
    auto popfq() => emit!0(0x9d);

    @("m16")
    auto push(Mem!16 dst) => emit!6(0xff, dst);
    static if (!X64)
    @("m32")
    auto push(Mem!32 dst) => emit!(6, NO_REX)(0xff, dst);
    static if (X64)
    @("m64")
    auto push(Mem!64 dst) => emit!(6, NO_REX)(0xff, dst);

    @("r16")
    auto push(R16 dst) => emit!(0, ENCODED | NO_REX_W)(0x50, dst);
    static if (!X64)
    @("r32")
    auto push(R32 dst) => emit!(0, ENCODED | NO_REX_W)(0x50, dst);
    static if (X64)
    @("r64")
    auto push(R64 dst) => emit!(0, ENCODED | NO_REX_W)(0x50, dst);

    @("imm8")
    auto push(ubyte imm8) => emit!0(0x6a, imm8);
    @("imm16")
    auto push(ushort imm16) => emit!0(0x68, imm16);
    @("imm32")
    auto push(uint imm32) => emit!0(0x68, imm32);

    auto pushcs() => emit!0(0x0e);
    auto pushss() => emit!0(0x16);
    auto pushds() => emit!0(0x1e);
    auto pushes() => emit!0(0x06);
    auto pushfs() => emit!0(0x0f, 0xa0);
    auto pushgs() => emit!0(0x0f, 0xa8); 

    auto pusha() => emit!0(0x60);
    auto pushad() => emit!0(0x60);

    auto pushf() => emit!0(0x9c);
    auto pushfd() => emit!0(0x9c);
    auto pushfq() => emit!0(0x9c);

    @("rm8", "r8")
    auto xadd(RM)(RM dst, R8 src) if (valid!(RM, 8)) => emit!0(0x0f, 0xc0, dst, src);
    @("rm16", "r16")
    auto xadd(RM)(RM dst, R16 src) if (valid!(RM, 16)) => emit!0(0x0f, 0xc1, dst, src);
    @("rm32", "r32")
    auto xadd(RM)(RM dst, R32 src) if (valid!(RM, 32)) => emit!0(0x0f, 0xc1, dst, src);
    @("rm64", "r64")
    auto xadd(RM)(RM dst, R64 src) if (valid!(RM, 64)) => emit!0(0x0f, 0xc1, dst, src);

    @("r16")
    auto xchg(R16 dst) => emit!(0, ENCODED)(90, dst);
    @("r32")
    auto xchg(R32 dst) => emit!(0, ENCODED)(90, dst);
    @("r64")
    auto xchg(R64 dst) => emit!(0, ENCODED)(90, dst);

    @("rm8", "rm8")
    auto xchg(A, B)(A dst, B src) if (valid!(A, 8) && valid!(B, 8)) => emit!0(0x86, dst, src);
    @("rm16", "rm16")
    auto xchg(A, B)(A dst, B src) if (valid!(A, 16) && valid!(B, 16)) => emit!0(0x87, dst, src);
    @("rm32", "rm32")
    auto xchg(A, B)(A dst, B src) if (valid!(A, 32) && valid!(B, 32)) => emit!0(0x87, dst, src);
    @("rm64", "rm64")
    auto xchg(A, B)(A dst, B src) if (valid!(A, 64) && valid!(B, 64)) => emit!0(0x87, dst, src);

    auto xlat() => emit!0(0xd7);
    static if (!X64)
    auto xlatb() => emit!0(0xd7);
    static if (X64)
    auto xlatb() => emit!0(0x48, 0xd7);

    @("r16", "m16")
    auto lar(R16 dst, Mem!16 src) => emit!0(0x0f, 0x02, dst, src);
    @("r16", "r16")
    auto lar(R16 dst, R16 src) => emit!0(0x0f, 0x02, dst, src);
    @("r32", "m16")
    auto lar(R32 dst, Mem!16 src) => emit!0(0x0f, 0x02, dst, src);
    @("r32", "r32")
    auto lar(R32 dst, R32 src) => emit!0(0x0f, 0x02, dst, src);

    auto daa() => emit!0(0x27);
    auto das() => emit!0(0x2f);

    @("rm8")
    auto mul(RM)(RM dst) if (valid!(RM, 8)) => emit!4(0xf6, dst);
    @("rm16")
    auto mul(RM)(RM dst) if (valid!(RM, 16)) => emit!4(0xf7, dst);
    @("rm32")
    auto mul(RM)(RM dst) if (valid!(RM, 32)) => emit!4(0xf7, dst);
    @("rm64")
    auto mul(RM)(RM dst) if (valid!(RM, 64)) => emit!4(0xf7, dst);

    @("rm8")
    auto imul(RM)(RM dst) if (valid!(RM, 8)) => emit!5(0xf6, dst);
    @("rm16")
    auto imul(RM)(RM dst) if (valid!(RM, 16)) => emit!5(0xf7, dst);
    @("rm32")
    auto imul(RM)(RM dst) if (valid!(RM, 32)) => emit!5(0xf7, dst);
    @("rm64")
    auto imul(RM)(RM dst) if (valid!(RM, 64)) => emit!5(0xf7, dst);

    @("r16", "rm16")
    auto imul(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0xaf, dst, src);
    @("r32", "rm32")
    auto imul(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0xaf, dst, src);
    @("r64", "rm64")
    auto imul(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0xaf, dst, src);

    @("r16", "rm16", "imm8")
    auto imul(RM)(R16 dst, RM src, ubyte imm8) if (valid!(RM, 16)) => emit!0(0x6b, dst, src, imm8);
    @("r32", "rm32", "imm8")
    auto imul(RM)(R32 dst, RM src, ubyte imm8) if (valid!(RM, 32)) => emit!0(0x6b, dst, src, imm8);
    @("r64", "rm64", "imm8")
    auto imul(RM)(R64 dst, RM src, ubyte imm8) if (valid!(RM, 64)) => emit!0(0x6b, dst, src, imm8);
    @("r16", "rm16", "imm16")
    auto imul(RM)(R16 dst, RM src, ushort imm16) if (valid!(RM, 16)) => emit!0(0x69, dst, src, imm16);
    @("r32", "rm32", "imm32")
    auto imul(RM)(R32 dst, RM src, uint imm32) if (valid!(RM, 32)) => emit!0(0x69, dst, src, imm32);
    @("r64", "rm64", "imm32")
    auto imul(RM)(R64 dst, RM src, uint imm32) if (valid!(RM, 64)) => emit!0(0x69, dst, src, imm32);

    @("rm8")
    auto div(RM)(RM dst) if (valid!(RM, 8)) => emit!6(0xf6, dst);
    @("rm16")
    auto div(RM)(RM dst) if (valid!(RM, 16)) => emit!6(0xf7, dst);
    @("rm32")
    auto div(RM)(RM dst) if (valid!(RM, 32)) => emit!6(0xf7, dst);
    @("rm64")
    auto div(RM)(RM dst) if (valid!(RM, 64)) => emit!6(0xf7, dst);

    @("rm8")
    auto idiv(RM)(RM dst) if (valid!(RM, 8)) => emit!7(0xf6, dst);
    @("rm16")
    auto idiv(RM)(RM dst) if (valid!(RM, 16)) => emit!7(0xf7, dst);
    @("rm32")
    auto idiv(RM)(RM dst) if (valid!(RM, 32)) => emit!7(0xf7, dst);
    @("rm64")
    auto idiv(RM)(RM dst) if (valid!(RM, 64)) => emit!7(0xf7, dst);

    @("rm8", "r8")
    auto mov(RM)(RM dst, R8 src) if (valid!(RM, 8)) => emit!0(0x88, dst, src);
    @("rm16", "r16")
    auto mov(RM)(RM dst, R16 src) if (valid!(RM, 16)) => emit!0(0x89, dst, src);
    @("rm32", "r32")
    auto mov(RM)(RM dst, R32 src) if (valid!(RM, 32)) => emit!0(0x89, dst, src);
    @("rm64", "r64")
    auto mov(RM)(RM dst, R64 src) if (valid!(RM, 64)) => emit!0(0x89, dst, src);

    @("r8", "m8")
    auto mov(R8 dst, Mem!8 src) => emit!0(0x8a, dst, src);
    @("r16", "m16")
    auto mov(R16 dst, Mem!16 src) => emit!0(0x8b, dst, src);
    @("r32", "m32")
    auto mov(R32 dst, Mem!32 src) => emit!0(0x8b, dst, src);
    @("r64", "m64")
    auto mov(R64 dst, Mem!64 src) => emit!0(0x8b, dst, src);
    
    @("r8", "imm8")
    auto mov(R8 dst, ubyte imm8) => emit!(0, ENCODED)(0xb0, dst, imm8);
    @("r16", "imm16")
    auto mov(R16 dst, ushort imm16) => emit!(0, ENCODED)(0xb8, dst, imm16);
    @("r32", "imm32")
    auto mov(R32 dst, uint imm32) => emit!(0, ENCODED)(0xb8, dst, imm32);
    @("r64", "imm64")
    auto mov(R64 dst, ulong imm64) => emit!(0, ENCODED)(0xb8, dst, imm64);

    @("m8", "imm8")
    auto mov(Mem!8 dst, ubyte imm8) => emit!0(0xc6, dst, imm8);
    @("m16", "imm16")
    auto mov(Mem!16 dst, ushort imm16) => emit!0(0xc7, dst, imm16);
    @("m32", "imm32")
    auto mov(Mem!32 dst, uint imm32) => emit!0(0xc7, dst, imm32);
    @("m64", "imm32")
    auto mov(Mem!64 dst, uint imm32) => emit!0(0xc7, dst, imm32);

    @("r32", "cr")
    auto mov(R32 dst, CR src) => emit!0(0x0f, 0x20, dst, src);
    @("r64", "cr")
    auto mov(R64 dst, CR src) => emit!0(0x0f, 0x20, dst, src);
    @("cr", "r32")
    auto mov(CR dst, R32 src) => emit!0(0x0f, 0x22, dst, src);
    @("cr", "r64")
    auto mov(CR dst, R64 src) => emit!0(0x0f, 0x22, dst, src);

    @("r32", "dr")
    auto mov(R32 dst, DR src) => emit!0(0x0f, 0x21, dst, src);
    @("r64", "dr")
    auto mov(R64 dst, DR src) => emit!0(0x0f, 0x21, dst, src);
    @("dr", "r32")
    auto mov(DR dst, R32 src) => emit!0(0x0f, 0x23, dst, src);
    @("dr", "r64")
    auto mov(DR dst, R64 src) => emit!0(0x0f, 0x23, dst, src);

    @("r16", "rm8")
    auto movsx(RM)(R16 dst, RM src) if (valid!(RM, 8)) => emit!0(0x0f, 0xbe, dst, src);
    @("r32", "rm8")
    auto movsx(RM)(R32 dst, RM src) if (valid!(RM, 8)) => emit!0(0x0f, 0xbe, dst, src);
    @("r64", "rm8")
    auto movsx(RM)(R64 dst, RM src) if (valid!(RM, 8)) => emit!0(0x0f, 0xbe, dst, src);

    @("r32", "rm16")
    auto movsx(RM)(R32 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0xbf, dst, src);
    @("r64", "rm16")
    auto movsx(RM)(R64 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0xbf, dst, src);

    @("r16", "rm16")
    auto movsxd(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x63, dst, src);
    @("r32", "rm32")
    auto movsxd(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x63, dst, src);
    @("r64", "rm32")
    auto movsxd(RM)(R64 dst, RM src) if (valid!(RM, 32)) => emit!0(0x63, dst, src);

    @("r16", "rm8")
    auto movzx(RM)(R16 dst, RM src) if (valid!(RM, 8)) => emit!0(0x0f, 0xb6, dst, src);
    @("r32", "rm8")
    auto movzx(RM)(R32 dst, RM src) if (valid!(RM, 8)) => emit!0(0x0f, 0xb6, dst, src);
    @("r64", "rm8")
    auto movzx(RM)(R64 dst, RM src) if (valid!(RM, 8)) => emit!0(0x0f, 0xb6, dst, src);

    @("r32", "rm16")
    auto movzx(RM)(R32 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0xb7, dst, src);
    @("r64", "rm16")
    auto movzx(RM)(R64 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0xb7, dst, src);

    @("imm16")
    auto call(ushort rel16) => emit!0(0xe8, rel16);
    @("imm32")
    auto call(uint rel32) => emit!0(0xe8, rel32);

    @("r16")
    auto call(R16 dst) => emit!2(0xff, dst);
    @("r32")
    auto call(R32 dst) => emit!2(0xff, dst);
    @("r64")
    auto call(R64 dst) => emit!2(0xff, dst);

    @("m16")
    auto call(Mem!16 dst) => emit!3(0xff, dst);
    @("m32")
    auto call(Mem!32 dst) => emit!3(0xff, dst);
    @("m64")
    auto call(Mem!64 dst) => emit!3(0xff, dst);

    @("jump")
    auto loop(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "loop", name !in labels);
    @("jump")
    auto loope(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "loope", name !in labels);
    @("jump")
    auto loopne(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "loopne", name !in labels);

    @("jump")
    auto jmp(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jmp", name !in labels);
    @("rm16")
    auto jmp(RM)(RM dst) if (valid!(RM, 16)) => emit!4(0xff, dst);
    @("rm32")
    auto jmp(RM)(RM dst) if (valid!(RM, 32)) => emit!4(0xff, dst);
    @("rm64")
    auto jmp(RM)(RM dst) if (valid!(RM, 64)) => emit!4(0xff, dst);

    /* auto jmp(Mem!16 dst) => emit!5(0xff, dst);
    auto jmp(Mem!32 dst) => emit!5(0xff, dst);
    auto jmp(Mem!64 dst) => emit!5(0xff, dst); */

    @("imm16")
    auto jmp(ushort imm16) => emit!0(0xea, imm16);
    @("imm32")
    auto jmp(uint imm32) => emit!0(0xea, imm32);

    @("jump")
    auto ja(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "ja", name !in labels);
    @("jump")
    auto jae(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jae", name !in labels);
    @("jump")
    auto jb(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jb", name !in labels);
    @("jump")
    auto jbe(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jbe", name !in labels);
    @("jump")
    auto jc(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jc", name !in labels);
    @("jump")
    auto jcxz(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jcxz", name !in labels);
    @("jump")
    auto jecxz(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jecxz", name !in labels);
    @("jump")
    auto jrcxz(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jrcxz", name !in labels);
    @("jump")
    auto je(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "je", name !in labels);
    @("jump")
    auto jg(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jg", name !in labels);
    @("jump")
    auto jge(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jge", name !in labels);
    @("jump")
    auto jl(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jl", name !in labels);
    @("jump")
    auto jle(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jle", name !in labels);
    @("jump")
    auto jna(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jna", name !in labels);
    @("jump")
    auto jnae(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jnae", name !in labels);
    @("jump")
    auto jnb(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jnb", name !in labels);
    @("jump")
    auto jnbe(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jnbe", name !in labels);
    @("jump")
    auto jnc(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jnc", name !in labels);
    @("jump")
    auto jne(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jne", name !in labels);
    @("jump")
    auto jng(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jng", name !in labels);
    @("jump")
    auto jnge(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jnge", name !in labels);
    @("jump")
    auto jnl(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jnl", name !in labels);
    @("jump")
    auto jnle(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jnle", name !in labels);
    @("jump")
    auto jno(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jno", name !in labels);
    @("jump")
    auto jnp(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jnp", name !in labels);
    @("jump")
    auto jns(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jns", name !in labels);
    @("jump")
    auto jnz(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jnz", name !in labels);
    @("jump")
    auto jo(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jo", name !in labels);
    @("jump")
    auto jp(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jp", name !in labels);
    @("jump")
    auto jpe(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jpe", name !in labels);
    @("jump")
    auto jpo(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jpo", name !in labels);
    @("jump")
    auto js(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "js", name !in labels);
    @("jump")
    auto jz(string name) => branches ~= tuple(cast(ptrdiff_t)buffer.length, name, "jz", name !in labels);
        
    @("prefix")
    auto rep(size_t size)
    {
        buffer = buffer[0..(buffer.length - size)]~0xf3~buffer[(buffer.length - size)..$];
        return size + 1;
    }
        
    @("prefix")
    auto repe(size_t size)
    {
        buffer = buffer[0..(buffer.length - size)]~0xf3~buffer[(buffer.length - size)..$];
        return size + 1;
    }
        
    @("prefix")
    auto repz(size_t size)
    {
        buffer = buffer[0..(buffer.length - size)]~0xf3~buffer[(buffer.length - size)..$];
        return size + 1;
    }
        
    @("prefix")
    auto repne(size_t size)
    {
        buffer = buffer[0..(buffer.length - size)]~0xf2~buffer[(buffer.length - size)..$];
        return size + 1;
    }

    @("prefix")
    auto repnz(size_t size)
    {
        buffer = buffer[0..(buffer.length - size)]~0xf2~buffer[(buffer.length - size)..$];
        return size + 1;
    }

    @("m8", "m8")
    auto movs(Mem!8 dst, Mem!8 src) => emit!0(0xa4, dst, src);
    @("m16", "m16")
    auto movs(Mem!16 dst, Mem!16 src) => emit!0(0xa5, dst, src);
    @("m32", "m32")
    auto movs(Mem!32 dst, Mem!32 src) => emit!0(0xa5, dst, src);
    @("m64", "m64")
    auto movs(Mem!64 dst, Mem!64 src) => emit!0(0xa5, dst, src);

    auto movsb() => emit!0(0xa4);
    auto movsw() => emit!0(0x66, 0xa5);
    auto movsd() => emit!0(0xa5);
    auto movsq() => emit!0(0x48, 0xa5);

    @("m8", "m8")
    auto cmps(Mem!8 dst, Mem!8 src) => emit!0(0xa6, dst, src);
    @("m16", "m16")
    auto cmps(Mem!16 dst, Mem!16 src) => emit!0(0xa7, dst, src);
    @("m32", "m32")
    auto cmps(Mem!32 dst, Mem!32 src) => emit!0(0xa7, dst, src);
    @("m64", "m64")
    auto cmps(Mem!64 dst, Mem!64 src) => emit!0(0xa7, dst, src);

    auto cmpsb() => emit!0(0xa6);
    auto cmpsw() => emit!0(0x66, 0xa7);
    auto cmpsd() => emit!0(0xa7);
    auto cmpsq() => emit!0(0x48, 0xa7);

    @("m8")
    auto scas(Mem!8 dst) => emit!0(0xae, dst);
    @("m16")
    auto scas(Mem!16 dst) => emit!0(0xaf, dst);
    @("m32")
    auto scas(Mem!32 dst) => emit!0(0xaf, dst);
    @("m64")
    auto scas(Mem!64 dst) => emit!0(0xaf, dst);

    auto scasb() => emit!0(0xae);
    auto scasw() => emit!0(0x66, 0xaf);
    auto scasd() => emit!0(0xaf);
    auto scasq() => emit!0(0x48, 0xaf);

    @("m8")
    auto lods(Mem!8 dst) => emit!0(0xac, dst);
    @("m16")
    auto lods(Mem!16 dst) => emit!0(0xad, dst);
    @("m32")
    auto lods(Mem!32 dst) => emit!0(0xad, dst);
    @("m64")
    auto lods(Mem!64 dst) => emit!0(0xad, dst);

    auto lodsb() => emit!0(0xac);
    auto lodsw() => emit!0(0x66, 0xad);
    auto lodsd() => emit!0(0xad);
    auto lodsq() => emit!0(0x48, 0xad);

    @("m8")
    auto stos(Mem!8 dst) => emit!0(0xaa, dst);
    @("m16")
    auto stos(Mem!16 dst) => emit!0(0xab, dst);
    @("m32")
    auto stos(Mem!32 dst) => emit!0(0xab, dst);
    @("m64")
    auto stos(Mem!64 dst) => emit!0(0xab, dst);

    auto stosb() => emit!0(0xaa);
    auto stosw() => emit!0(0x66, 0xab);
    auto stosd() => emit!0(0xab);
    auto stosq() => emit!0(0x48, 0xab);

    @("imm8")
    auto inal(ubyte imm8) => emit!0(0xe4, imm8);
    auto inal() => emit!0(0xec);

    @("imm8")
    auto _in(ubyte imm8) => emit!0(0xe5, imm8);
    auto _in() => emit!0(0xed);

    @("m8")
    auto ins(Mem!8 dst) => emit!0(0x6c, dst);
    @("m16")
    auto ins(Mem!16 dst) => emit!0(0x6d, dst);
    @("m32")
    auto ins(Mem!32 dst) => emit!0(0x6d, dst);

    auto insb() => emit!0(0x6c);
    auto insw() => emit!0(0x66, 0x6d);
    auto insd() => emit!0(0x6d);
    
    @("imm8")
    auto outal(ubyte imm8) => emit!0(0xe6, imm8);
    auto outal() => emit!0(0xee);

    @("imm8")
    auto _out(ubyte imm8) => emit!0(0xe7, imm8);
    auto _out() => emit!0(0xef);

    @("m8")
    auto outs(Mem!8 dst) => emit!0(0x6e, dst);
    @("m16")
    auto outs(Mem!16 dst) => emit!0(0x6f, dst);
    @("m32")
    auto outs(Mem!32 dst) => emit!0(0x6f, dst);

    auto outsb() => emit!0(0x6e);
    auto outsw() => emit!0(0x66, 0x6f);
    auto outsd() => emit!0(0x6f);

    @("rm8")
    auto seta(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x97, dst);
    @("rm8")
    auto setae(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x93, dst);
    @("rm8")
    auto setb(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x92, dst);
    @("rm8")
    auto setbe(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x96, dst);
    @("rm8")
    auto setc(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x92, dst);
    @("rm8")
    auto sete(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x94, dst);
    @("rm8")
    auto setg(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x9f, dst);
    @("rm8")
    auto setge(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x9d, dst);
    @("rm8")
    auto setl(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x9c, dst);
    @("rm8")
    auto setle(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x9e, dst);
    @("rm8")
    auto setna(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x96, dst);
    @("rm8")
    auto setnae(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x92, dst);
    @("rm8")
    auto setnb(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x93, dst);
    @("rm8")
    auto setnbe(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x97, dst);
    @("rm8")
    auto setnc(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x93, dst);
    @("rm8")
    auto setne(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x95, dst);
    @("rm8")
    auto setng(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x9e, dst);
    @("rm8")
    auto setnge(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x9c, dst);
    @("rm8")
    auto setnl(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x9d, dst);
    @("rm8")
    auto setnle(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x9f, dst);
    @("rm8")
    auto setno(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x91, dst);
    @("rm8")
    auto setnp(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x9b, dst);
    @("rm8")
    auto setns(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x99, dst);
    @("rm8")
    auto setnz(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x95, dst);
    @("rm8")
    auto seto(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x90, dst);
    @("rm8")
    auto setp(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x9a, dst);
    @("rm8")
    auto setpe(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x9a, dst);
    @("rm8")
    auto setpo(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x9b, dst);
    @("rm8")
    auto sets(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x98, dst);
    @("rm8")
    auto setz(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x94, dst);

