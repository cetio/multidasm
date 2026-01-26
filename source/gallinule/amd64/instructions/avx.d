    auto vaddpd(RM)(XMM dst, XMM src, RM stor) if (valid!(RM, 128)) => emit!(0, VEX, 128, 1, 0x66)(0x58, dst, src, stor);
    auto vaddpd(RM)(YMM dst, YMM src, RM stor) if (valid!(RM, 256)) => emit!(0, VEX, 256, 1, 0x66)(0x58, dst, src, stor);

    auto vaddps(RM)(XMM dst, XMM src, RM stor) if (valid!(RM, 128)) => emit!(0, VEX, 128, 1, 0)(0x58, dst, src, stor);
    auto vaddps(RM)(YMM dst, YMM src, RM stor) if (valid!(RM, 256)) => emit!(0, VEX, 256, 1, 0)(0x58, dst, src, stor);

    auto vaddsd(RM)(XMM dst, XMM src, RM stor) if (valid!(RM, 128, 64)) => emit!(0, VEX, 128, 1, 0xf2)(0x58, dst, src, stor);
    auto vaddss(RM)(XMM dst, XMM src, RM stor) if (valid!(RM, 128, 32)) => emit!(0, VEX, 128, 1, 0xf3)(0x58, dst, src, stor);

    auto vaddsubpd(RM)(XMM dst, XMM src, RM stor) if (valid!(RM, 128)) => emit!(0, VEX, 128, 1, 0x66)(0xd0, dst, src, stor);
    auto vaddsubpd(RM)(YMM dst, YMM src, RM stor) if (valid!(RM, 256)) => emit!(0, VEX, 256, 1, 0x66)(0xd0, dst, src, stor);

    auto vaddsubps(RM)(XMM dst, XMM src, RM stor) if (valid!(RM, 128)) => emit!(0, VEX, 128, 1, 0xf2)(0xd0, dst, src, stor);
    auto vaddsubps(RM)(YMM dst, YMM src, RM stor) if (valid!(RM, 256)) => emit!(0, VEX, 256, 1, 0xf2)(0xd0, dst, src, stor);

    auto vmovq(RM)(XMM dst, RM src) if (valid!(RM, 128, 64)) => emit!(0, VEX, 128, 1, 0xf3)(0x7e, dst, src);
    auto vmovq(Mem!64 dst, XMM src) => emit!(0, VEX, 128, 1, 0x66)(0xd6, dst, src);

    @("r128", "rm32")
    auto vmovd(RM)(XMM dst, RM src) if (valid!(RM, 32)) => emit!(0, VEX, 128, 1, 0x66)(0x6e, dst, src);
    auto vmovd(RM)(RM dst, XMM src) if (valid!(RM, 32)) => emit!(0, VEX, 128, 1, 0x66)(0x7e, dst, src);

    @("r128", "rm64")
    auto vmovq(RM)(XMM dst, RM src) if (valid!(RM, 64)) => emit!(0, VEX, 128, 1, 0x66)(0x6e, dst, src);
    auto vmovq(RM)(RM dst, XMM src) if (valid!(RM, 64)) => emit!(0, VEX, 128, 1, 0x66)(0x7e, dst, src);
