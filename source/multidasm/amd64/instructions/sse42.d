    /// www.felixcloutier.com/x86/pcmpgtq
    @("r128", "rm128")
    auto pcmpgtq(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX)(0x66, 0x0f, 0x38, 0x37, dst, src);
    /// www.felixcloutier.com/x86/pcmpestri
    @("r128", "rm128", "imm8")
    auto pcmpestri(RM)(XMM dst, RM src, ubyte imm8) if (valid!(RM, 128))
        => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x3a, 0x61, dst, src, imm8);
    /// www.felixcloutier.com/x86/pcmpestrm
    @("r128", "rm128", "imm8")
    auto pcmpestrm(RM)(XMM dst, RM src, ubyte imm8) if (valid!(RM, 128))
        => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x3a, 0x60, dst, src, imm8);
    /// www.felixcloutier.com/x86/pcmpistri
    @("r128", "rm128", "imm8")
    auto pcmpistri(RM)(XMM dst, RM src, ubyte imm8) if (valid!(RM, 128))
        => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x3a, 0x63, dst, src, imm8);
    /// www.felixcloutier.com/x86/pcmpistrm
    @("r128", "rm128", "imm8")
    auto pcmpistrm(RM)(XMM dst, RM src, ubyte imm8) if (valid!(RM, 128))
        => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x3a, 0x62, dst, src, imm8);

    /// www.felixcloutier.com/x86/crc32
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
