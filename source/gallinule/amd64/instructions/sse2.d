    auto lfence() => emit!0(0x0f, 0xae, 0xe8);
    auto sfence() => emit!0(0x0f, 0xae, 0xf8);
    auto mfence() => emit!0(0x0f, 0xae, 0xf0);

    auto movq(RM)(XMM dst, RM src) if (valid!(RM, 128, 64)) => emit!(0, NO_REX | FLIP)(0xf3, 0x0f, 0x7e, dst, src);
    auto movq(Mem!64 dst, XMM src) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0xd6, dst, src);

    auto movd(RM)(XMM dst, RM src) if (valid!(RM, 32)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x6e, dst, src);
    auto movd(RM)(RM dst, XMM src) if (valid!(RM, 32)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x7e, dst, src);
    @("r128", "r64")
    auto movq(XMM dst, R64 src) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x6e, dst, src);
    @("r64", "r128")
    auto movq(R64 dst, XMM src) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x7e, dst, src);

    @("r128", "rm128")
    auto movdqa(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x6f, dst, src);
    @("m128", "r128")
    auto movdqa(Mem!128 dst, XMM src) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x7f, dst, src);
    @("r128", "rm128")
    auto movdqu(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0xf3, 0x0f, 0x6f, dst, src);
    @("m128", "r128")
    auto movdqu(Mem!128 dst, XMM src) => emit!(0, NO_REX | FLIP)(0xf3, 0x0f, 0x7f, dst, src);

    @("r128", "rm128")
    auto pxor(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0xef, dst, src);
    @("r128", "rm128")
    auto pxor(RM)(MMX dst, RM src) if (valid!(RM, 64)) => emit!(0, NO_REX | FLIP)(0x0f, 0xef, dst, src);
    @("r128", "rm128")
    auto paddb(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0xfc, dst, src);
    @("r128", "rm128")
    auto paddw(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0xfd, dst, src);
    @("r128", "rm128")
    auto paddd(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0xfe, dst, src);
    @("r128", "rm128")
    auto paddq(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0xd4, dst, src);
    @("r128", "rm128")
    auto psubb(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0xf8, dst, src);
    @("r128", "rm128")
    auto psubw(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0xf9, dst, src);
    @("r128", "rm128")
    auto psubd(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0xfa, dst, src);
    @("r128", "rm128")
    auto psubq(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0xfb, dst, src);
    @("r128", "rm128")
    auto pmullw(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0xd5, dst, src);
    @("r128", "rm128")
    auto pmuludq(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0xf4, dst, src);
    @("r128", "rm128", "imm8")
    auto pshufd(RM)(XMM dst, RM src, ubyte imm8) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x70, dst, src, imm8);
    @("r128", "rm128", "imm8")
    auto pshuflw(RM)(XMM dst, RM src, ubyte imm8) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0xf2, 0x0f, 0x70, dst, src, imm8);
    @("r128", "rm128", "imm8")
    auto pshufhw(RM)(XMM dst, RM src, ubyte imm8) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0xf3, 0x0f, 0x70, dst, src, imm8);

    // Additional SSE2 (compare, pack, shift, movmsk, float cmp/convert, mov load/store, shuffle)
    @("r128", "rm128")
    auto pcmpeqb(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x74, dst, src);
    @("r128", "rm128")
    auto pcmpeqw(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x75, dst, src);
    @("r128", "rm128")
    auto pcmpeqd(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x76, dst, src);
    @("r128", "rm128")
    auto pcmpgtb(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x64, dst, src);
    @("r128", "rm128")
    auto pcmpgtw(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x65, dst, src);
    @("r128", "rm128")
    auto pcmpgtd(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x66, dst, src);
    @("r128", "rm128")
    auto packsswb(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x63, dst, src);
    @("r128", "rm128")
    auto packssdw(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x6b, dst, src);
    @("r128", "rm128")
    auto packuswb(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x67, dst, src);
    @("r128", "rm128")
    auto pmulhw(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0xe5, dst, src);
    @("r128", "rm128")
    auto pmulhuw(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0xe4, dst, src);
    @("r128", "rm128")
    auto pand(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0xdb, dst, src);
    @("r128", "rm128")
    auto pandn(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0xdf, dst, src);
    @("r128", "rm128")
    auto por(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0xeb, dst, src);
    auto movmskps(R32 dst, XMM src) => emit!(0, NO_REX | FLIP)(0x0f, 0x50, dst, src);
    auto movmskps(R64 dst, XMM src) => emit!(0, NO_REX | FLIP)(0x0f, 0x50, dst, src);
    auto movmskpd(R32 dst, XMM src) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x50, dst, src);
    auto movmskpd(R64 dst, XMM src) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x50, dst, src);
    auto pmovmskb(R32 dst, XMM src) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0xd7, dst, src);
    auto pmovmskb(R64 dst, XMM src) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0xd7, dst, src);
    @("r128", "rm128")
    auto andnpd(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x55, dst, src);
    @("r128", "rm128")
    auto andnps(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x0f, 0x55, dst, src);
    @("r128", "rm128")
    auto orpd(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x56, dst, src);
    @("r128", "rm128")
    auto orps(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x0f, 0x56, dst, src);
    @("r128", "rm128")
    auto xorpd(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x57, dst, src);
    @("r128", "rm128")
    auto xorps(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x0f, 0x57, dst, src);
    @("r128", "rm128")
    auto sqrtpd(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x51, dst, src);
    @("r128", "rm128")
    auto sqrtps(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x0f, 0x51, dst, src);
    @("r128", "rm128")
    auto divpd(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x5e, dst, src);
    @("r128", "rm128")
    auto divps(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x0f, 0x5e, dst, src);
    @("r128", "rm128")
    auto subpd(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x5c, dst, src);
    @("r128", "rm128")
    auto subps(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x0f, 0x5c, dst, src);
    @("r128", "rm128")
    auto mulpd(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x59, dst, src);
    @("r128", "rm128")
    auto mulps(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x0f, 0x59, dst, src);
    @("r128", "rm128")
    auto minpd(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x5d, dst, src);
    @("r128", "rm128")
    auto minps(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x0f, 0x5d, dst, src);
    @("r128", "rm128")
    auto maxpd(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x5f, dst, src);
    @("r128", "rm128")
    auto maxps(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x0f, 0x5f, dst, src);
    @("r128", "rm128", "imm8")
    auto cmppd(RM)(XMM dst, RM src, ubyte imm8) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0xc2, dst, src, imm8);
    @("r128", "rm128", "imm8")
    auto cmpps(RM)(XMM dst, RM src, ubyte imm8) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x0f, 0xc2, dst, src, imm8);
    @("r128", "rm128")
    auto comisd(RM)(XMM dst, RM src) if (valid!(RM, 128, 64)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x2f, dst, src);
    @("r128", "rm128")
    auto ucomisd(RM)(XMM dst, RM src) if (valid!(RM, 128, 64)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x2e, dst, src);
    @("r128", "rm128")
    auto comiss(RM)(XMM dst, RM src) if (valid!(RM, 128, 32)) => emit!(0, NO_REX | FLIP)(0x0f, 0x2f, dst, src);
    @("r128", "rm128")
    auto ucomiss(RM)(XMM dst, RM src) if (valid!(RM, 128, 32)) => emit!(0, NO_REX | FLIP)(0x0f, 0x2e, dst, src);
    @("r128", "rm128")
    auto movapd(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x28, dst, src);
    auto movapd(Mem!128 dst, XMM src) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x29, dst, src);
    @("r128", "rm128")
    auto movupd(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x10, dst, src);
    auto movupd(Mem!128 dst, XMM src) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x11, dst, src);
    @("r128", "rm128", "imm8")
    auto shufpd(RM)(XMM dst, RM src, ubyte imm8) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0xc6, dst, src, imm8);
    @("r128", "rm128", "imm8")
    auto shufps(RM)(XMM dst, RM src, ubyte imm8) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x0f, 0xc6, dst, src, imm8);
    @("r128", "rm128", "imm8")
    auto pinsrw(RM)(XMM dst, RM src, ubyte imm8) if (valid!(RM, 128, 16)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0xc4, dst, src, imm8);
    @("r128", "rm128", "imm8")
    auto pextrw(RM)(R32 dst, RM src, ubyte imm8) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0xc5, dst, src, imm8);
