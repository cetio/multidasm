    @("r128", "rm128")
    auto pshufb(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x00, dst, src);
    @("r128", "rm128", "imm8")
    auto palignr(RM)(XMM dst, RM src, ubyte imm8) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x3a, 0x0f, dst, src, imm8);
    @("r128", "rm128")
    auto pabsb(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x1c, dst, src);
    @("r128", "rm128")
    auto pabsw(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x1d, dst, src);
    @("r128", "rm128")
    auto pabsd(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x1e, dst, src);
    @("r128", "rm128")
    auto phaddw(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x01, dst, src);
    @("r128", "rm128")
    auto phaddd(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x02, dst, src);
    @("r128", "rm128")
    auto phsubw(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x05, dst, src);
    @("r128", "rm128")
    auto phsubd(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x06, dst, src);
    @("r128", "rm128")
    auto pmaddubsw(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x04, dst, src);
    @("r128", "rm128")
    auto pmulhrsw(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x0b, dst, src);
