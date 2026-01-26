    auto vpaddb(RM)(YMM dst, YMM src, RM stor) if (valid!(RM, 256)) => emit!(0, VEX, 256, 1, 0x66)(0xfc, dst, src, stor);
    auto vpaddb(RM)(XMM dst, XMM src, RM stor) if (valid!(RM, 128)) => emit!(0, VEX, 128, 1, 0x66)(0xfc, dst, src, stor);
    auto vpaddw(RM)(YMM dst, YMM src, RM stor) if (valid!(RM, 256)) => emit!(0, VEX, 256, 1, 0x66)(0xfd, dst, src, stor);
    auto vpaddw(RM)(XMM dst, XMM src, RM stor) if (valid!(RM, 128)) => emit!(0, VEX, 128, 1, 0x66)(0xfd, dst, src, stor);
    auto vpaddd(RM)(YMM dst, YMM src, RM stor) if (valid!(RM, 256)) => emit!(0, VEX, 256, 1, 0x66)(0xfe, dst, src, stor);
    auto vpaddd(RM)(XMM dst, XMM src, RM stor) if (valid!(RM, 128)) => emit!(0, VEX, 128, 1, 0x66)(0xfe, dst, src, stor);
    auto vpaddq(RM)(YMM dst, YMM src, RM stor) if (valid!(RM, 256)) => emit!(0, VEX, 256, 1, 0x66)(0xd4, dst, src, stor);
    auto vpaddq(RM)(XMM dst, XMM src, RM stor) if (valid!(RM, 128)) => emit!(0, VEX, 128, 1, 0x66)(0xd4, dst, src, stor);
    auto vpsubb(RM)(YMM dst, YMM src, RM stor) if (valid!(RM, 256)) => emit!(0, VEX, 256, 1, 0x66)(0xf8, dst, src, stor);
    auto vpsubb(RM)(XMM dst, XMM src, RM stor) if (valid!(RM, 128)) => emit!(0, VEX, 128, 1, 0x66)(0xf8, dst, src, stor);
    auto vpsubw(RM)(YMM dst, YMM src, RM stor) if (valid!(RM, 256)) => emit!(0, VEX, 256, 1, 0x66)(0xf9, dst, src, stor);
    auto vpsubw(RM)(XMM dst, XMM src, RM stor) if (valid!(RM, 128)) => emit!(0, VEX, 128, 1, 0x66)(0xf9, dst, src, stor);
    auto vpsubd(RM)(YMM dst, YMM src, RM stor) if (valid!(RM, 256)) => emit!(0, VEX, 256, 1, 0x66)(0xfa, dst, src, stor);
    auto vpsubd(RM)(XMM dst, XMM src, RM stor) if (valid!(RM, 128)) => emit!(0, VEX, 128, 1, 0x66)(0xfa, dst, src, stor);
    auto vpsubq(RM)(YMM dst, YMM src, RM stor) if (valid!(RM, 256)) => emit!(0, VEX, 256, 1, 0x66)(0xfb, dst, src, stor);
    auto vpsubq(RM)(XMM dst, XMM src, RM stor) if (valid!(RM, 128)) => emit!(0, VEX, 128, 1, 0x66)(0xfb, dst, src, stor);
    auto vpmulld(RM)(YMM dst, YMM src, RM stor) if (valid!(RM, 256)) => emit!(0, VEX, 256, M38, 0x66)(0x40, dst, src, stor);
    auto vpmulld(RM)(XMM dst, XMM src, RM stor) if (valid!(RM, 128)) => emit!(0, VEX, 128, M38, 0x66)(0x40, dst, src, stor);
    @("r256", "rm128")
    auto vbroadcasti128(RM)(YMM dst, RM src) if (valid!(RM, 128)) => emit!(0, VEX, 256, M38, 0x66)(0x5a, dst, src);
    @("r256", "rm256", "imm8")
    auto vpermq(RM)(YMM dst, RM src, ubyte imm8) if (valid!(RM, 256)) => emit!(0, VEX, 256, M3A, 0x66)(0x00, dst, src, imm8);
    @("r256", "rm256", "imm8")
    auto vpermpd(RM)(YMM dst, RM src, ubyte imm8) if (valid!(RM, 256)) => emit!(0, VEX, 256, M3A, 0x66)(0x01, dst, src, imm8);
