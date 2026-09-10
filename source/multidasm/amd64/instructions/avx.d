    /// www.felixcloutier.com/x86/addpd
    auto vaddpd(RM)(XMM dst, XMM src, RM stor) if (valid!(RM, 128)) => emit!(0, VEX, 128, 1, 0x66)(0x58, dst, src, stor);
    auto vaddpd(RM)(YMM dst, YMM src, RM stor) if (valid!(RM, 256)) => emit!(0, VEX, 256, 1, 0x66)(0x58, dst, src, stor);

    /// www.felixcloutier.com/x86/addps
    auto vaddps(RM)(XMM dst, XMM src, RM stor) if (valid!(RM, 128)) => emit!(0, VEX, 128, 1, 0)(0x58, dst, src, stor);
    auto vaddps(RM)(YMM dst, YMM src, RM stor) if (valid!(RM, 256)) => emit!(0, VEX, 256, 1, 0)(0x58, dst, src, stor);

    /// www.felixcloutier.com/x86/addsd
    auto vaddsd(RM)(XMM dst, XMM src, RM stor) if (valid!(RM, 128, 64)) => emit!(0, VEX, 128, 1, 0xf2)(0x58, dst, src, stor);
    /// www.felixcloutier.com/x86/addss
    auto vaddss(RM)(XMM dst, XMM src, RM stor) if (valid!(RM, 128, 32)) => emit!(0, VEX, 128, 1, 0xf3)(0x58, dst, src, stor);

    /// www.felixcloutier.com/x86/addsubpd
    auto vaddsubpd(RM)(XMM dst, XMM src, RM stor) if (valid!(RM, 128)) => emit!(0, VEX, 128, 1, 0x66)(0xd0, dst, src, stor);
    auto vaddsubpd(RM)(YMM dst, YMM src, RM stor) if (valid!(RM, 256)) => emit!(0, VEX, 256, 1, 0x66)(0xd0, dst, src, stor);

    /// www.felixcloutier.com/x86/addsubps
    auto vaddsubps(RM)(XMM dst, XMM src, RM stor) if (valid!(RM, 128)) => emit!(0, VEX, 128, 1, 0xf2)(0xd0, dst, src, stor);
    auto vaddsubps(RM)(YMM dst, YMM src, RM stor) if (valid!(RM, 256)) => emit!(0, VEX, 256, 1, 0xf2)(0xd0, dst, src, stor);

    /// www.felixcloutier.com/x86/movd:movq
    auto vmovq(RM)(XMM dst, RM src) if (valid!(RM, 128, 64)) => emit!(0, VEX, 128, 1, 0xf3)(0x7e, dst, src);
    auto vmovq(Mem!64 dst, XMM src) => emit!(0, VEX, 128, 1, 0x66)(0x7e, dst, src);

    @("r128", "rm32")
    /// www.felixcloutier.com/x86/movd:movq
    auto vmovd(RM)(XMM dst, RM src) if (valid!(RM, 32)) => emit!(0, VEX, 128, 1, 0x66)(0x6e, dst, src);
    auto vmovd(RM)(RM dst, XMM src) if (valid!(RM, 32)) => emit!(0, VEX, 128, 1, 0x66)(0x7e, dst, src);

    @("r128", "rm64")
    auto vmovq(RM)(XMM dst, RM src) if (valid!(RM, 64)) => emit!(0, VEX, 128, 1, 0x66)(0x6e, dst, src);
    auto vmovq(RM)(RM dst, XMM src) if (valid!(RM, 64)) => emit!(0, VEX, 128, 1, 0x66)(0x7e, dst, src);

    // Zero upper 128 bits of all YMM registers (AVX state cleanup)
    // VEX.256.0F.WIG 77 /r where /r = C0 (mod=11, reg=000, r/m=000)
    /// www.felixcloutier.com/x86/vzeroall
    auto vzeroall() => emit!0(0xc5, 0xfc, 0x77, 0xc0);
    // Zero upper 128 bits of YMM0-YMM15
    // VEX.128.0F.WIG 77 /r where /r = C0 (mod=11, reg=000, r/m=000)
    /// www.felixcloutier.com/x86/vzeroupper
    auto vzeroupper() => emit!0(0xc5, 0xf8, 0x77, 0xc0);
