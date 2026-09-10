    /// www.felixcloutier.com/x86/vfmadd132ps:vfmadd213ps:vfmadd231ps
    auto vfmadd132ps(RM)(XMM dst, XMM src, RM stor) if (valid!(RM, 128)) => emit!(0, VEX, 128, M38, 0)(0x98, dst, src, stor);
    auto vfmadd132ps(RM)(YMM dst, YMM src, RM stor) if (valid!(RM, 256)) => emit!(0, VEX, 256, M38, 0)(0x98, dst, src, stor);
    /// www.felixcloutier.com/x86/vfmadd132pd:vfmadd213pd:vfmadd231pd
    auto vfmadd132pd(RM)(XMM dst, XMM src, RM stor) if (valid!(RM, 128)) => emit!(0, VEX | INT, 128, M38, 0x66)(0x98, dst, src, stor);
    auto vfmadd132pd(RM)(YMM dst, YMM src, RM stor) if (valid!(RM, 256)) => emit!(0, VEX | INT, 256, M38, 0x66)(0x98, dst, src, stor);
    /// www.felixcloutier.com/x86/vfmadd132ss:vfmadd213ss:vfmadd231ss
    auto vfmadd132ss(RM)(XMM dst, XMM src, RM stor) if (valid!(RM, 128, 32)) => emit!(0, VEX, 128, M38, 0xf3)(0x99, dst, src, stor);
    /// www.felixcloutier.com/x86/vfmadd132sd:vfmadd213sd:vfmadd231sd
    auto vfmadd132sd(RM)(XMM dst, XMM src, RM stor) if (valid!(RM, 128, 64)) => emit!(0, VEX | INT, 128, M38, 0xf2)(0x99, dst, src, stor);
    /// www.felixcloutier.com/x86/vfmadd132ps:vfmadd213ps:vfmadd231ps
    auto vfmadd213ps(RM)(XMM dst, XMM src, RM stor) if (valid!(RM, 128)) => emit!(0, VEX, 128, M38, 0)(0xa8, dst, src, stor);
    auto vfmadd213ps(RM)(YMM dst, YMM src, RM stor) if (valid!(RM, 256)) => emit!(0, VEX, 256, M38, 0)(0xa8, dst, src, stor);
    /// www.felixcloutier.com/x86/vfmadd132pd:vfmadd213pd:vfmadd231pd
    auto vfmadd213pd(RM)(XMM dst, XMM src, RM stor) if (valid!(RM, 128)) => emit!(0, VEX | INT, 128, M38, 0x66)(0xa8, dst, src, stor);
    auto vfmadd213pd(RM)(YMM dst, YMM src, RM stor) if (valid!(RM, 256)) => emit!(0, VEX | INT, 256, M38, 0x66)(0xa8, dst, src, stor);
    /// www.felixcloutier.com/x86/vfmadd132ps:vfmadd213ps:vfmadd231ps
    auto vfmadd231ps(RM)(XMM dst, XMM src, RM stor) if (valid!(RM, 128)) => emit!(0, VEX, 128, M38, 0)(0xb8, dst, src, stor);
    auto vfmadd231ps(RM)(YMM dst, YMM src, RM stor) if (valid!(RM, 256)) => emit!(0, VEX, 256, M38, 0)(0xb8, dst, src, stor);
    /// www.felixcloutier.com/x86/vfmadd132pd:vfmadd213pd:vfmadd231pd
    auto vfmadd231pd(RM)(XMM dst, XMM src, RM stor) if (valid!(RM, 128)) => emit!(0, VEX | INT, 128, M38, 0x66)(0xb8, dst, src, stor);
    auto vfmadd231pd(RM)(YMM dst, YMM src, RM stor) if (valid!(RM, 256)) => emit!(0, VEX | INT, 256, M38, 0x66)(0xb8, dst, src, stor);
