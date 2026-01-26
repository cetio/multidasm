    auto addsubps(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0xf2, 0x0f, 0xd0, dst, src);
    auto addsubpd(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0xd0, dst, src);
