    @("r128", "rm128", "imm8")
    auto blendpd(RM)(XMM dst, RM src, ubyte imm8) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x3a, 0x0d, dst, src, imm8);
    @("r128", "rm128", "imm8")
    auto blendps(RM)(XMM dst, RM src, ubyte imm8) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x3a, 0x0c, dst, src, imm8);
    @("r128", "rm128")
    auto blendvpd(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x15, dst, src);
    @("r128", "rm128")
    auto blendvps(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x14, dst, src);
    @("r128", "rm128", "imm8")
    auto pblendw(RM)(XMM dst, RM src, ubyte imm8) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x3a, 0x0e, dst, src, imm8);
    @("r128", "rm128")
    auto pblendvb(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x10, dst, src);
    @("r128", "rm128", "imm8")
    auto roundpd(RM)(XMM dst, RM src, ubyte imm8) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x3a, 0x09, dst, src, imm8);
    @("r128", "rm128", "imm8")
    auto roundps(RM)(XMM dst, RM src, ubyte imm8) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x3a, 0x08, dst, src, imm8);
    @("r128", "rm128", "imm8")
    auto roundss(RM)(XMM dst, RM src, ubyte imm8) if (valid!(RM, 128, 32)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x3a, 0x0a, dst, src, imm8);
    @("r128", "rm128", "imm8")
    auto roundsd(RM)(XMM dst, RM src, ubyte imm8) if (valid!(RM, 128, 64)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x3a, 0x0b, dst, src, imm8);
    @("rm32", "r128")
    auto extractps(RM)(RM dst, XMM src, ubyte imm8) if (valid!(RM, 32)) => emit!(0, NO_REX)(0x66, 0x0f, 0x3a, 0x17, dst, src, imm8);
    @("r128", "rm128", "imm8")
    auto insertps(RM)(XMM dst, RM src, ubyte imm8) if (valid!(RM, 128, 32)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x3a, 0x21, dst, src, imm8);
    @("r128", "rm128")
    auto ptest(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x17, dst, src);
    @("r128", "rm128")
    auto pmuldq(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x28, dst, src);
    @("r128", "rm128")
    auto packusdw(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x2b, dst, src);
    @("r128", "rm128")
    auto phminposuw(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x41, dst, src);
    @("r128", "rm128", "imm8")
    auto mpsadbw(RM)(XMM dst, RM src, ubyte imm8) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x3a, 0x42, dst, src, imm8);
    @("r128", "rm128")
    auto movntdqa(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x2a, dst, src);
    @("r128", "rm128", "imm8")
    auto dppd(RM)(XMM dst, RM src, ubyte imm8) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x3a, 0x41, dst, src, imm8);
    @("r128", "rm128", "imm8")
    auto dpps(RM)(XMM dst, RM src, ubyte imm8) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x3a, 0x40, dst, src, imm8);
    @("r128", "rm128")
    auto pminsb(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x38, dst, src);
    @("r128", "rm128")
    auto pminsd(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x39, dst, src);
    @("r128", "rm128")
    auto pminuw(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x3a, dst, src);
    @("r128", "rm128")
    auto pminud(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x3b, dst, src);
    @("r128", "rm128")
    auto pmaxsb(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x3c, dst, src);
    @("r128", "rm128")
    auto pmaxsd(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x3d, dst, src);
    @("r128", "rm128")
    auto pmaxuw(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x3e, dst, src);
    @("r128", "rm128")
    auto pmaxud(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x3f, dst, src);
    @("r128", "rm128", "imm8")
    auto pinsrb(RM)(XMM dst, RM src, ubyte imm8) if (valid!(RM, 32)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x3a, 0x20, dst, src, imm8);
    @("r128", "rm128", "imm8")
    auto pinsrd(RM)(XMM dst, RM src, ubyte imm8) if (valid!(RM, 32)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x3a, 0x22, dst, src, imm8);
    @("r128", "rm128", "imm8")
    auto pinsrq(RM)(XMM dst, RM src, ubyte imm8) if (valid!(RM, 64)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x3a, 0x22, dst, src, imm8);
    @("rm8", "r128", "imm8")
    auto pextrb(RM)(RM dst, XMM src, ubyte imm8) if (valid!(RM, 8)) => emit!(0, NO_REX)(0x66, 0x0f, 0x3a, 0x14, dst, src, imm8);
    @("rm32", "r128", "imm8")
    auto pextrd(RM)(RM dst, XMM src, ubyte imm8) if (valid!(RM, 32)) => emit!(0, NO_REX)(0x66, 0x0f, 0x3a, 0x16, dst, src, imm8);
    @("rm64", "r128", "imm8")
    auto pextrq(RM)(RM dst, XMM src, ubyte imm8) if (valid!(RM, 64)) => emit!(0, NO_REX)(0x66, 0x0f, 0x3a, 0x16, dst, src, imm8);
    @("r128", "rm64")
    auto pmovsxbw(RM)(XMM dst, RM src) if (valid!(RM, 64)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x20, dst, src);
    @("r128", "rm64")
    auto pmovzxbw(RM)(XMM dst, RM src) if (valid!(RM, 64)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x30, dst, src);
    @("r128", "rm128")
    auto pmovsxbd(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x21, dst, src);
    @("r128", "rm128")
    auto pmovzxbd(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x31, dst, src);
    @("r128", "rm128")
    auto pmovsxbq(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x22, dst, src);
    @("r128", "rm128")
    auto pmovzxbq(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x32, dst, src);
    @("r128", "rm128")
    auto pmovsxwd(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x23, dst, src);
    @("r128", "rm128")
    auto pmovzxwd(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x33, dst, src);
    @("r128", "rm128")
    auto pmovsxwq(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x24, dst, src);
    @("r128", "rm128")
    auto pmovzxwq(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x34, dst, src);
    @("r128", "rm128")
    auto pmovsxdq(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x25, dst, src);
    @("r128", "rm128")
    auto pmovzxdq(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x38, 0x35, dst, src);
