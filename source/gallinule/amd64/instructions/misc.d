    /* ====== PSEUDO/CUSTOM ====== */

    auto cridvme() => mov(rax, cr4) + shr(rax, CRID.VME) + and(rax, 1);
    auto cridpvi() => mov(rax, cr4) + shr(rax, CRID.PVI) + and(rax, 1);
    auto cridtsd() => mov(rax, cr4) + shr(rax, CRID.TSD) + and(rax, 1);
    auto cridde() => mov(rax, cr4) + shr(rax, CRID.DE) + and(rax, 1);
    auto cridpse() => mov(rax, cr4) + shr(rax, CRID.PSE) + and(rax, 1);
    auto cridpae() => mov(rax, cr4) + shr(rax, CRID.PAE) + and(rax, 1);
    auto cridmce() => mov(rax, cr4) + shr(rax, CRID.MCE) + and(rax, 1);
    auto cridpge() => mov(rax, cr4) + shr(rax, CRID.PGE) + and(rax, 1);
    auto cridpce() => mov(rax, cr4) + shr(rax, CRID.PCE) + and(rax, 1);
    auto cridosfxsr() => mov(rax, cr4) + shr(rax, CRID.OSFXSR) + and(rax, 1);
    auto cridosxmmexcpt() => mov(rax, cr4) + shr(rax, CRID.OSXMMEXCPT) + and(rax, 1);
    auto cridumip() => mov(rax, cr4) + shr(rax, CRID.UMIP) + and(rax, 1);
    auto cridvmxe() => mov(rax, cr4) + shr(rax, CRID.VMXE) + and(rax, 1);
    auto cridsmxe() => mov(rax, cr4) + shr(rax, CRID.SMXE) + and(rax, 1);
    auto cridfsgsbase() => mov(rax, cr4) + shr(rax, CRID.FSGSBASE) + and(rax, 1);
    auto cridpcide() => mov(rax, cr4) + shr(rax, CRID.PCIDE) + and(rax, 1);
    auto cridosxsave() => mov(rax, cr4) + shr(rax, CRID.OSXSAVE) + and(rax, 1);
    auto cridsmep() => mov(rax, cr4) + shr(rax, CRID.SMEP) + and(rax, 1);
    auto cridsmap() => mov(rax, cr4) + shr(rax, CRID.SMAP) + and(rax, 1);
    auto cridpke() => mov(rax, cr4) + shr(rax, CRID.PKE) + and(rax, 1);
    auto cridcet() => mov(rax, cr4) + shr(rax, CRID.CET) + and(rax, 1);
    auto cridpks() => mov(rax, cr4) + shr(rax, CRID.PKS) + and(rax, 1);
    auto criduintr() => mov(rax, cr4) + shr(rax, CRID.UINTR) + and(rax, 1);

    auto idavx512vl() => cpuid(7) + shr(ebx, CPUID7_EBX.AVX512VL) + and(ebx, 1);
    auto idavx512bw() => cpuid(7) + shr(ebx, CPUID7_EBX.AVX512BW) + and(ebx, 1);
    auto idsha() => cpuid(7) + shr(ebx, CPUID7_EBX.SHA) + and(ebx, 1);
    auto idavx512cd() => cpuid(7) + shr(ebx, CPUID7_EBX.AVX512CD) + and(ebx, 1);
    auto idavx512er() => cpuid(7) + shr(ebx, CPUID7_EBX.AVX512ER) + and(ebx, 1);
    auto idavx512pf() => cpuid(7) + shr(ebx, CPUID7_EBX.AVX512PF) + and(ebx, 1);
    auto idpt() => cpuid(7) + shr(ebx, CPUID7_EBX.PT) + and(ebx, 1);
    auto idclwb() => cpuid(7) + shr(ebx, CPUID7_EBX.CLWB) + and(ebx, 1);
    auto idclflushopt() => cpuid(7) + shr(ebx, CPUID7_EBX.CLFLUSHOPT) + and(ebx, 1);
    auto idpcommit() => cpuid(7) + shr(ebx, CPUID7_EBX.PCOMMIT) + and(ebx, 1);
    auto idavx512ifma() => cpuid(7) + shr(ebx, CPUID7_EBX.AVX512IFMA) + and(ebx, 1);
    auto idsmap() => cpuid(7) + shr(ebx, CPUID7_EBX.SMAP) + and(ebx, 1);
    auto idadx() => cpuid(7) + shr(ebx, CPUID7_EBX.ADX) + and(ebx, 1);
    auto idrdseed() => cpuid(7) + shr(ebx, CPUID7_EBX.RDSEED) + and(ebx, 1);
    auto idavx512dq() => cpuid(7) + shr(ebx, CPUID7_EBX.AVX512DQ) + and(ebx, 1);
    auto idavx512f() => cpuid(7) + shr(ebx, CPUID7_EBX.AVX512F) + and(ebx, 1);
    auto idpqe() => cpuid(7) + shr(ebx, CPUID7_EBX.PQE) + and(ebx, 1);
    auto idrtm() => cpuid(7) + shr(ebx, CPUID7_EBX.RTM) + and(ebx, 1);
    auto idinvpcid() => cpuid(7) + shr(ebx, CPUID7_EBX.INVPCID) + and(ebx, 1);
    auto iderms() => cpuid(7) + shr(ebx, CPUID7_EBX.ERMS) + and(ebx, 1);
    auto idbmi2() => cpuid(7) + shr(ebx, CPUID7_EBX.BMI2) + and(ebx, 1);
    auto idsmep() => cpuid(7) + shr(ebx, CPUID7_EBX.SMEP) + and(ebx, 1);
    auto idfpdp() => cpuid(7) + shr(ebx, CPUID7_EBX.FPDP) + and(ebx, 1);
    auto idavx2() => cpuid(7) + shr(ebx, CPUID7_EBX.AVX2) + and(ebx, 1);
    auto idhle() => cpuid(7) + shr(ebx, CPUID7_EBX.HLE) + and(ebx, 1);
    auto idbmi1() => cpuid(7) + shr(ebx, CPUID7_EBX.BMI1) + and(ebx, 1);
    auto idsgx() => cpuid(7) + shr(ebx, CPUID7_EBX.SGX) + and(ebx, 1);
    auto idtscadj() => cpuid(7) + shr(ebx, CPUID7_EBX.TSC_ADJUST) + and(ebx, 1);
    auto idfsgsbase() => cpuid(7) + shr(ebx, CPUID7_EBX.FSGSBASE) + and(ebx, 1);

    auto idprefetchwt1() => cpuid(7) + shr(ecx, CPUID7_ECX.PREFETCHWT1) + and(ecx, 1);
    auto idavx512vbmi() => cpuid(7) + shr(ecx, CPUID7_ECX.AVX512VBMI) + and(ecx, 1);
    auto idumip() => cpuid(7) + shr(ecx, CPUID7_ECX.UMIP) + and(ecx, 1);
    auto idpku() => cpuid(7) + shr(ecx, CPUID7_ECX.PKU) + and(ecx, 1);
    auto idospke() => cpuid(7) + shr(ecx, CPUID7_ECX.OSPKE) + and(ecx, 1);
    auto idavx512vbmi2() => cpuid(7) + shr(ecx, CPUID7_ECX.AVX512VBMI2) + and(ecx, 1);
    auto idcet() => cpuid(7) + shr(ecx, CPUID7_ECX.CET) + and(ecx, 1);
    auto idgfni() => cpuid(7) + shr(ecx, CPUID7_ECX.GFNI) + and(ecx, 1);
    auto idvaes() => cpuid(7) + shr(ecx, CPUID7_ECX.VAES) + and(ecx, 1);
    auto idvpcl() => cpuid(7) + shr(ecx, CPUID7_ECX.VPCL) + and(ecx, 1);
    auto idavx512vnni() => cpuid(7) + shr(ecx, CPUID7_ECX.AVX512VNNI) + and(ecx, 1);
    auto idavx512bitalg() => cpuid(7) + shr(ecx, CPUID7_ECX.AVX512BITALG) + and(ecx, 1);
    auto idtme() => cpuid(7) + shr(ecx, CPUID7_ECX.TME) + and(ecx, 1);
    auto idavx512vp() => cpuid(7) + shr(ecx, CPUID7_ECX.AVX512VP) + and(ecx, 1);
    auto idva57() => cpuid(7) + shr(ecx, CPUID7_ECX.VA57) + and(ecx, 1);
    auto idrdpid() => cpuid(7) + shr(ecx, CPUID7_ECX.RDPID) + and(ecx, 1);
    auto idsgxlc() => cpuid(7) + shr(ecx, CPUID7_ECX.SGX_LC) + and(ecx, 1);

    auto idavx512qvnniw() => cpuid(7) + shr(edx, CPUID7_EDX.AVX512QVNNIW) + and(edx, 1);
    auto idavx512qfma() => cpuid(7) + shr(edx, CPUID7_EDX.AVX512QFMA) + and(edx, 1);
    auto idpconfig() => cpuid(7) + shr(edx, CPUID7_EDX.PCONFIG) + and(edx, 1);
    auto idibrsibpb() => cpuid(7) + shr(edx, CPUID7_EDX.IBRS_IBPB) + and(edx, 1);
    auto idstibp() => cpuid(7) + shr(edx, CPUID7_EDX.STIBP) + and(edx, 1);

    auto idsse3() => cpuid(1) + shr(ecx, CPUID1_ECX.SSE3) + and(ecx, 1);
    auto idpclmul() => cpuid(1) + shr(ecx, CPUID1_ECX.PCLMUL) + and(ecx, 1);
    auto iddtes64() => cpuid(1) + shr(ecx, CPUID1_ECX.DTES64) + and(ecx, 1);
    auto idmon() => cpuid(1) + shr(ecx, CPUID1_ECX.MON) + and(ecx, 1);
    auto iddscpl() => cpuid(1) + shr(ecx, CPUID1_ECX.DSCPL) + and(ecx, 1);
    auto idvmx() => cpuid(1) + shr(ecx, CPUID1_ECX.VMX) + and(ecx, 1);
    auto idsmx() => cpuid(1) + shr(ecx, CPUID1_ECX.SMX) + and(ecx, 1);
    auto idest() => cpuid(1) + shr(ecx, CPUID1_ECX.EST) + and(ecx, 1);
    auto idtm2() => cpuid(1) + shr(ecx, CPUID1_ECX.TM2) + and(ecx, 1);
    auto idssse3() => cpuid(1) + shr(ecx, CPUID1_ECX.SSSE3) + and(ecx, 1);
    auto idcid() => cpuid(1) + shr(ecx, CPUID1_ECX.CID) + and(ecx, 1);
    auto idsdbg() => cpuid(1) + shr(ecx, CPUID1_ECX.SDBG) + and(ecx, 1);
    auto idfma() => cpuid(1) + shr(ecx, CPUID1_ECX.FMA) + and(ecx, 1);
    auto idcx16() => cpuid(1) + shr(ecx, CPUID1_ECX.CX16) + and(ecx, 1);
    auto idxtpr() => cpuid(1) + shr(ecx, CPUID1_ECX.XTPR) + and(ecx, 1);
    auto idpdcm() => cpuid(1) + shr(ecx, CPUID1_ECX.PDCM) + and(ecx, 1);
    auto idpcid() => cpuid(1) + shr(ecx, CPUID1_ECX.PCID) + and(ecx, 1);
    auto iddca() => cpuid(1) + shr(ecx, CPUID1_ECX.DCA) + and(ecx, 1);
    auto idsse41() => cpuid(1) + shr(ecx, CPUID1_ECX.SSE4_1) + and(ecx, 1);
    auto idsse42() => cpuid(1) + shr(ecx, CPUID1_ECX.SSE4_2) + and(ecx, 1);
    auto idx2apic() => cpuid(1) + shr(ecx, CPUID1_ECX.X2APIC) + and(ecx, 1);
    auto idmovbe() => cpuid(1) + shr(ecx, CPUID1_ECX.MOVBE) + and(ecx, 1);
    auto idpopcnt() => cpuid(1) + shr(ecx, CPUID1_ECX.POPCNT) + and(ecx, 1);
    auto idtscd() => cpuid(1) + shr(ecx, CPUID1_ECX.TSCD) + and(ecx, 1);
    auto idaes() => cpuid(1) + shr(ecx, CPUID1_ECX.AES) + and(ecx, 1);
    auto idxsave() => cpuid(1) + shr(ecx, CPUID1_ECX.XSAVE) + and(ecx, 1);
    auto idosxsave() => cpuid(1) + shr(ecx, CPUID1_ECX.OSXSAVE) + and(ecx, 1);
    auto idavx() => cpuid(1) + shr(ecx, CPUID1_ECX.AVX) + and(ecx, 1);
    auto idf16c() => cpuid(1) + shr(ecx, CPUID1_ECX.F16C) + and(ecx, 1);
    auto idrdrand() => cpuid(1) + shr(ecx, CPUID1_ECX.RDRAND) + and(ecx, 1);
    auto idhv() => cpuid(1) + shr(ecx, CPUID1_ECX.HV) + and(ecx, 1);

    auto idfpu() => cpuid(1) + shr(edx, CPUID1_EDX.FPU) + and(edx, 1);
    auto idvme() => cpuid(1) + shr(edx, CPUID1_EDX.VME) + and(edx, 1);
    auto idde() => cpuid(1) + shr(edx, CPUID1_EDX.DE) + and(edx, 1);
    auto idpse() => cpuid(1) + shr(edx, CPUID1_EDX.PSE) + and(edx, 1);
    auto idtsc() => cpuid(1) + shr(edx, CPUID1_EDX.TSC) + and(edx, 1);
    auto idmsr() => cpuid(1) + shr(edx, CPUID1_EDX.MSR) + and(edx, 1);
    auto idpae() => cpuid(1) + shr(edx, CPUID1_EDX.PAE) + and(edx, 1);
    auto idcx8() => cpuid(1) + shr(edx, CPUID1_EDX.CX8) + and(edx, 1);
    auto idapic() => cpuid(1) + shr(edx, CPUID1_EDX.APIC) + and(edx, 1);
    auto idsep() => cpuid(1) + shr(edx, CPUID1_EDX.SEP) + and(edx, 1);
    auto idmtrr() => cpuid(1) + shr(edx, CPUID1_EDX.MTRR) + and(edx, 1);
    auto idpge() => cpuid(1) + shr(edx, CPUID1_EDX.PGE) + and(edx, 1);
    auto idmca() => cpuid(1) + shr(edx, CPUID1_EDX.MCA) + and(edx, 1);
    auto idcmov() => cpuid(1) + shr(edx, CPUID1_EDX.CMOV) + and(edx, 1);
    auto idpat() => cpuid(1) + shr(edx, CPUID1_EDX.PAT) + and(edx, 1);
    auto idpse36() => cpuid(1) + shr(edx, CPUID1_EDX.PSE36) + and(edx, 1);
    auto idpsn() => cpuid(1) + shr(edx, CPUID1_EDX.PSN) + and(edx, 1);
    auto idclfl() => cpuid(1) + shr(edx, CPUID1_EDX.CLFL) + and(edx, 1);
    auto idds() => cpuid(1) + shr(edx, CPUID1_EDX.DS) + and(edx, 1);
    auto idacpi() => cpuid(1) + shr(edx, CPUID1_EDX.ACPI) + and(edx, 1);
    auto idmmx() => cpuid(1) + shr(edx, CPUID1_EDX.MMX) + and(edx, 1);
    auto idfxsr() => cpuid(1) + shr(edx, CPUID1_EDX.FXSR) + and(edx, 1);
    auto idsse() => cpuid(1) + shr(edx, CPUID1_EDX.NP) + and(edx, 1);
    auto idsse2() => cpuid(1) + shr(edx, CPUID1_EDX.SSE2) + and(edx, 1);
    auto idss() => cpuid(1) + shr(edx, CPUID1_EDX.SS) + and(edx, 1);
    auto idhtt() => cpuid(1) + shr(edx, CPUID1_EDX.HTT) + and(edx, 1);
    auto idtm() => cpuid(1) + shr(edx, CPUID1_EDX.TM) + and(edx, 1);
    auto idia64() => cpuid(1) + shr(edx, CPUID1_EDX.IA64) + and(edx, 1);
    auto idpbe() => cpuid(1) + shr(edx, CPUID1_EDX.PBE) + and(edx, 1);

    /* ====== 3DNow! ====== */
    // This is an AMD exclusive vector instruction set that uses MM registers.
    // It has been deprecated and sucks, do not use this for any kind of compiler generation.

    @("r64", "rm64")
    auto pfadd(RM)(MMX dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x0f, dst, src, 0x9e);
    @("r64", "rm64")
    auto pfsub(RM)(MMX dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x0f, dst, src, 0x9a);
    @("r64", "rm64")
    auto pfsubr(RM)(MMX dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x0f, dst, src, 0xaa);
    @("r64", "rm64")
    auto pfmul(RM)(MMX dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x0f, dst, src, 0xb4);

    @("r64", "rm64")
    auto pfcmpeq(RM)(MMX dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x0f, dst, src, 0xb0);
    @("r64", "rm64")
    auto pfcmpge(RM)(MMX dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x0f, dst, src, 0x90);
    @("r64", "rm64")
    auto pfcmpgt(RM)(MMX dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x0f, dst, src, 0xa0);

    @("r64", "rm64")
    auto pf2id(RM)(MMX dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x0f, dst, src, 0x1d);
    @("r64", "rm64")
    auto pi2fd(RM)(MMX dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x0f, dst, src, 0x0d);
    @("r64", "rm64")
    auto pf2iw(RM)(MMX dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x0f, dst, src, 0x1c);
    @("r64", "rm64")
    auto pi2fw(RM)(MMX dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x0f, dst, src, 0x0c);

    @("r64", "rm64")
    auto pfmax(RM)(MMX dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x0f, dst, src, 0xa4);
    @("r64", "rm64")
    auto pfmin(RM)(MMX dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x0f, dst, src, 0x94);

    @("r64", "rm64")
    auto pfrcp(RM)(MMX dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x0f, dst, src, 0x96);
    @("r64", "rm64")
    auto pfrsqrt(RM)(MMX dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x0f, dst, src, 0x97);
    @("r64", "rm64")
    auto pfrcpit1(RM)(MMX dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x0f, dst, src, 0xa6);
    @("r64", "rm64")
    auto pfrsqit1(RM)(MMX dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x0f, dst, src, 0xa7);
    @("r64", "rm64")
    auto pfrcpit2(RM)(MMX dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x0f, dst, src, 0xb6);

    @("r64", "rm64")
    auto pfacc(RM)(MMX dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x0f, dst, src, 0xae);
    @("r64", "rm64")
    auto pfnacc(RM)(MMX dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x0f, dst, src, 0x8a);
    @("r64", "rm64")
    auto pfpnacc(RM)(MMX dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x0f, dst, src, 0x8e);
    @("r64", "rm64")
    auto pmulhrw(RM)(MMX dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x0f, dst, src, 0xb7);

    @("r64", "rm64")
    auto pavgusb(RM)(MMX dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x0f, dst, src, 0xbf);
    @("r64", "rm64")
    auto pswapd(RM)(MMX dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x0f, dst, src, 0xbb);

    auto femms() => emit!0(0x0f, 0x0e);
     
    /* ====== ICEBP ====== */
    // Intel exclusive interrupt instruction.

    auto icebp() => emit!0(0xf1);

    /* ====== PT ====== */

    @("rm32")
    auto ptwrite(RM)(RM dst) if (valid!(RM, 32)) => emit!4(0xf3, 0x0f, 0xae, dst);
    @("rm64")
    auto ptwrite(RM)(RM dst) if (valid!(RM, 64)) => emit!4(0xf3, 0x0f, 0xae, dst);

    /* ====== CLWB ====== */
    
    @("rm8")
    auto clwb(RM)(RM dst) if (valid!(RM, 8)) => emit!6(0x66, 0x0f, 0xae, dst);

    /* ====== CLFLUSHOPT ====== */
    
    @("rm8")
    auto clflushopt(RM)(RM dst) if (valid!(RM, 8)) => emit!7(0x66, 0x0f, 0xae, dst);

    /* ====== SMAP ====== */

    auto stac() => emit!0(0x0f, 0x01, 0xcb);
    auto clac() => emit!0(0x0f, 0x01, 0xca);

    /* ====== ADX ====== */

    @("imm8")
    auto adc(ubyte imm8) => emit!0(0x14, imm8);
    @("imm16")
    auto adc(ushort imm16) => emit!0(0x15, imm16);
    @("imm32")
    auto adc(uint imm32) => emit!0(0x15, imm32);

    @("rm8", "imm8")
    auto adc(RM)(RM dst, ubyte imm8) if (valid!(RM, 8)) => emit!2(0x80, dst, imm8);
    @("rm16", "imm16")
    auto adc(RM)(RM dst, ushort imm16) if (valid!(RM, 16)) => emit!2(0x81, dst, imm16);
    @("rm32", "imm32")
    auto adc(RM)(RM dst, uint imm32) if (valid!(RM, 32)) => emit!2(0x81, dst, imm32);
    @("rm64", "imm32")
    auto adc(RM)(RM dst, uint imm32) if (valid!(RM, 64)) => emit!2(0x81, dst, imm32);
    @("rm16", "imm8")
    auto adc(RM)(RM dst, ubyte imm8) if (valid!(RM, 16)) => emit!2(0x83, dst, imm8);
    @("rm32", "imm8")
    auto adc(RM)(RM dst, ubyte imm8) if (valid!(RM, 32)) => emit!2(0x83, dst, imm8);
    @("rm64", "imm8")
    auto adc(RM)(RM dst, ubyte imm8) if (valid!(RM, 64)) => emit!2(0x83, dst, imm8);

    @("rm8", "r8")
    auto adc(RM)(RM dst, R8 src) if (valid!(RM, 8)) => emit!0(0x10, dst, src);
    @("rm16", "r16")
    auto adc(RM)(RM dst, R16 src) if (valid!(RM, 16)) => emit!0(0x11, dst, src);
    @("rm32", "r32")
    auto adc(RM)(RM dst, R32 src) if (valid!(RM, 32)) => emit!0(0x11, dst, src);
    @("rm64", "r64")
    auto adc(RM)(RM dst, R64 src) if (valid!(RM, 64)) => emit!0(0x11, dst, src);

    @("r8", "m8")
    auto adc(R8 dst, Mem!8 src) => emit!0(0x12, dst, src);
    @("r16", "m16")
    auto adc(R16 dst, Mem!16 src) => emit!0(0x13, dst, src);
    @("r32", "m32")
    auto adc(R32 dst, Mem!32 src) => emit!0(0x13, dst, src);
    @("r64", "m64")
    auto adc(R64 dst, Mem!64 src) => emit!0(0x13, dst, src);

    @("r32", "rm32")
    auto adcx(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0F, 0x38, 0xF6, dst, src);
    @("r64", "rm64")
    auto adcx(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0F, 0x38, 0xF6, dst, src);

    @("r32", "rm32")
    auto adox(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0xF3, 0x0F, 0x38, 0xF6, dst, src);
    @("r64", "rm64")
    auto adox(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0xF3, 0x0F, 0x38, 0xF6, dst, src);

    /* ====== RDSEED ====== */
    
    @("r16")
    auto rdseed(R16 dst) => emit!7(0x0f, 0xc7, dst);
    @("r32")
    auto rdseed(R32 dst) => emit!7(0x0f, 0xc7, dst);
    @("r64")
    auto rdseed(R64 dst) => emit!7(0x0f, 0xc7, dst);

    /* ====== MPX ====== */

    @("r32", "rm32")
    auto bndcl(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0xf3, 0x0f, 0x1a, dst, src);
    @("r64", "rm64")
    auto bndcl(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0xf3, 0x0f, 0x1a, dst, src);

    @("r32", "rm32")
    auto bndcu(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0xf2, 0x0f, 0x1a, dst, src);
    @("r64", "rm64")
    auto bndcu(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0xf2, 0x0f, 0x1a, dst, src);

    @("r32", "rm32")
    auto bndcn(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0xf2, 0x0f, 0x1b, dst, src);
    @("r64", "rm64")
    auto bndcn(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0xf2, 0x0f, 0x1b, dst, src);

    @("r64", "rm64")
    auto bndldx(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!(0, NO_REX)(0x0f, 0x1a, dst, src);
    @("rm64", "r64")
    auto bndstx(RM)(RM dst, R64 src) if (valid!(RM, 64)) => emit!(0, NO_REX)(0x0f, 0x1b, dst, src);

    @("r32", "rm32")
    auto bndmk(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0xf3, 0x0f, 0x1b, dst, src);
    @("r64", "rm32")
    auto bndmk(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0xf3, 0x0f, 0x1b, dst, src);

    @("r32", "rm32")
    auto bndmov(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x1a, dst, src);
    @("r64", "rm64")
    auto bndmov(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x1a, dst, src);
    @("m32", "r32")
    auto bndmov(Mem!32 dst, R32 src) => emit!0(0x0f, 0x1b, dst, src);
    @("m64", "r32")
    auto bndmov(Mem!64 dst, R32 src) => emit!0(0x0f, 0x1b, dst, src);

    @("r16", "rm16")
    auto bound(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x62, dst, src);
    @("r32", "rm32")
    auto bound(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x62, dst, src);

    /* ====== RTM ====== */
    
    auto xend() => emit!0(0x0f, 0x01, 0xd5);
    @("imm8")
    auto xabort(ubyte imm8) => emit!0(0xc6, 0xf8, imm8);
    @("imm16")
    auto xbegin(ushort rel16) => emit!0(0xc7, 0xf8, rel16);
    @("imm32")
    auto xbegin(uint rel32) => emit!0(0xc7, 0xf8, rel32);
    auto xtest() => emit!0(0x0f, 0x01, 0xd6);
    
    /* ====== INVPCID ====== */

    @("r32", "m128")
    auto invpcid(R32 dst, Mem!128 src) => emit!0(0x0f, 0x38, 0x82, dst, src);
    @("r64", "m128")
    auto invpcid(R64 dst, Mem!128 src) => emit!0(0x0f, 0x38, 0x82, dst, src);

    /* ====== HLE ====== */

    @("prefix")
    auto xacquire(size_t size)
    {
        buffer = buffer[0..(buffer.length - size)]~0xf2~buffer[(buffer.length - size)..$];
        return size + 1;
    }

    @("prefix")
    auto xacquire_lock(size_t size)
    {
        buffer = buffer[0..(buffer.length - size)]~0xf2~0xf0~buffer[(buffer.length - size)..$];
        return size + 2;
    }

    @("prefix")
    auto xrelease(size_t size)
    {
        buffer = buffer[0..(buffer.length - size)]~0xf3~buffer[(buffer.length - size)..$];
        return size + 1;
    }

    /* ====== BMI1 ====== */

    @("r16", "rm16")
    auto tzcnt(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0xf3, 0x0f, 0xbc, dst, src);
    @("r32", "rm32")
    auto tzcnt(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0xf3, 0x0f, 0xbc, dst, src);
    @("r64", "rm64")
    auto tzcnt(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0xf3, 0x0f, 0xbc, dst, src);

    @("r16", "rm16")
    auto lzcnt(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0xf3, 0x0f, 0xbd, dst, src);
    @("r32", "rm32")
    auto lzcnt(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0xf3, 0x0f, 0xbd, dst, src);
    @("r64", "rm64")
    auto lzcnt(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0xf3, 0x0f, 0xbd, dst, src);

    @("r32", "r32", "rm32")
    auto andn(RM)(R32 dst, R32 src, RM stor) if (valid!(RM, 32)) => emit!(0, VEX | INT, 128, M38, 0)(0xf2, dst, src, stor);
    @("r64", "r64", "rm64")
    auto andn(RM)(R64 dst, R64 src, RM stor) if (valid!(RM, 64)) => emit!(0, VEX | INT, 128, M38, 0)(0xf2, dst, src, stor);

    /* ====== SGX ====== */

    auto encls() => emit!0(0x0f, 0x01, 0xcf);

    auto encls_ecreate() => mov(eax, 0) + encls();
    auto encls_eadd() => mov(eax, 1) + encls();
    auto encls_einit() => mov(eax, 2) + encls();
    auto encls_eremove() => mov(eax, 3) + encls();
    auto encls_edbgrd() => mov(eax, 4) + encls();
    auto encls_edbgwr() => mov(eax, 5) + encls();
    auto encls_eextend() => mov(eax, 6) + encls();
    auto encls_eldb() => mov(eax, 7) + encls();
    auto encls_eldu() => mov(eax, 8) + encls();
    auto encls_eblock() => mov(eax, 9) + encls();
    auto encls_epa() => mov(eax, 0xa) + encls();
    auto encls_ewb() => mov(eax, 0xb) + encls();
    auto encls_etrack() => mov(eax, 0xc) + encls();
    auto encls_eaug() => mov(eax, 0xd) + encls();
    auto encls_emodpr() => mov(eax, 0xe) + encls();
    auto encls_emodt() => mov(eax, 0xf) + encls();
    auto encls_erdinfo() => mov(eax, 0x10) + encls();
    auto encls_etrackc() => mov(eax, 0x11) + encls();
    auto encls_eldbc() => mov(eax, 0x12) + encls();
    auto encls_elduc() => mov(eax, 0x13) + encls();

    auto enclu() => emit!0(0x0f, 0x01, 0xd7);

    auto enclu_ereport() => mov(eax, 0) + enclu();
    auto enclu_egetkey() => mov(eax, 1) + enclu();
    auto enclu_eenter() => mov(eax, 2) + enclu();
    auto enclu_eresume() => mov(eax, 3) + enclu();
    auto enclu_eexit() => mov(eax, 4) + enclu();
    auto enclu_eaccept() => mov(eax, 5) + enclu();
    auto enclu_emodpe() => mov(eax, 6) + enclu();
    auto enclu_eacceptcopy() => mov(eax, 7) + enclu();
    auto enclu_edeccssa() => mov(eax, 9) + enclu();

    auto enclv() => emit!0(0x0f, 0x01, 0xc0);

    auto enclv_edecvirtchild() => mov(eax, 0) + enclv();
    auto enclv_eincvirtchild() => mov(eax, 1) + enclv();
    auto enclv_esetcontext() => mov(eax, 2) + enclv();

    /* ====== MON ====== */
    
    auto monitor() => emit!0(0x0f, 0x01, 0xc8);
    auto mwait() => emit!0(0x0f, 0x01, 0xc9);

    /* ====== VMX ====== */

    @("r32", "m128")
    auto invvpid(R32 dst, Mem!128 src) => emit!0(0x66, 0x0f, 0x38, 0x81, dst, src);
    @("r64", "m128")
    auto invvpid(R64 dst, Mem!128 src) => emit!0(0x66, 0x0f, 0x38, 0x81, dst, src);
    @("r32", "m128")
    auto invept(R32 dst, Mem!128 src) => emit!0(0x66, 0x0f, 0x38, 0x80, dst, src);
    @("r64", "m128")
    auto invept(R64 dst, Mem!128 src) => emit!0(0x66, 0x0f, 0x38, 0x80, dst, src);

    auto vmcall() => emit!0(0x0f, 0x01, 0xc1);
    auto vmfunc() => emit!0(0x0f, 0x01, 0xd4);
    @("rm64")
    auto vmclear(RM)(RM dst) if (valid!(RM, 64)) => emit!6(0x66, 0x0f, 0xc7, dst);
    auto vmlaunch() => emit!0(0x0f, 0x01, 0xc2);
    auto vmresume() => emit!0(0x0f, 0x01, 0xc3);
    auto vmxoff() => emit!0(0x0f, 0x01, 0xc4);
    @("rm64")
    auto vmxon(RM)(RM dst) if (valid!(RM, 64)) => emit!6(0xf3, 0x0f, 0xc7, dst);
    
    @("r32", "rm32")
    auto vmwrite(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!(0, NO_REX)(0x0f, 0x79, dst, src);
    @("r64", "rm64")
    auto vmwrite(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!(0, NO_REX)(0x0f, 0x79, dst, src);
    @("rm32", "r32")
    auto vmread(RM)(RM dst, R32 src) if (valid!(RM, 32)) => emit!(0, NO_REX)(0x0f, 0x78, dst, src);
    @("rm64", "r64")
    auto vmread(RM)(RM dst, R64 src) if (valid!(RM, 64)) => emit!(0, NO_REX)(0x0f, 0x78, dst, src);

    @("rm64")
    auto vmptrst(RM)(RM dst) if (valid!(RM, 64)) => emit!(7, NO_REX)(0x0f, 0xc7, dst);
    @("rm64")
    auto vmptrld(RM)(RM dst) if (valid!(RM, 64)) => emit!(6, NO_REX)(0x0f, 0xc7, dst);

    /* ====== SMX ====== */

    auto getsec() => emit!0(0x0f, 0x37);

    auto getsec_capabilities() => mov(eax, 0) + getsec();
    auto getsec_enteraccs() => mov(eax, 2) + getsec();
    auto getsec_exitac() => mov(eax, 3) + getsec();
    auto getsec_senter() => mov(eax, 4) + getsec();
    auto getsec_sexit() => mov(eax, 5) + getsec();
    auto getsec_parameters() => mov(eax, 6) + getsec();
    auto getsec_smctrl() => mov(eax, 7) + getsec();
    auto getsec_wakeup() => mov(eax, 8) + getsec();

    /* ====== CX16 ====== */

    @("m128")
    auto cmpxchg16b(Mem!128 dst) => emit!1(0x48, 0x0f, 0xc7, dst);

    /* ====== POPCNT ====== */
    
    @("r16", "rm16")
    auto popcnt(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0xf3, 0x0f, 0xb8, dst, src);
    @("r32", "rm32")
    auto popcnt(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0xf3, 0x0f, 0xb8, dst, src);
    @("r64", "rm64")
    auto popcnt(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0xf3, 0x0f, 0xb8, dst, src);
    
    /* ====== XSAVE ====== */
    
    auto xgetbv() => emit!0(0x0f, 0x01, 0xd0);
    auto xsetbv() => emit!0(0x0f, 0x01, 0xd1);

    @("m")
    auto xrstor(RM)(RM dst) if (isInstanceOf!(Mem, RM)) => emit!(5, NO_REX)(0x0f, 0xae, dst);
    @("m")
    auto xsave(RM)(RM dst) if (isInstanceOf!(Mem, RM)) => emit!(4, NO_REX)(0x0f, 0xae, dst);

    @("m")
    auto xrstors(RM)(RM dst) if (isInstanceOf!(Mem, RM)) => emit!(3, NO_REX)(0x0f, 0xc7, dst);
    @("m")
    auto xsaves(RM)(RM dst) if (isInstanceOf!(Mem, RM)) => emit!(5, NO_REX)(0x0f, 0xc7, dst);

    @("m")
    auto xsaveopt(RM)(RM dst) if (isInstanceOf!(Mem, RM)) => emit!(6, NO_REX)(0x0f, 0xae, dst);
    @("m")
    auto xsavec(RM)(RM dst) if (isInstanceOf!(Mem, RM)) => emit!(4, NO_REX)(0x0f, 0xc7, dst);

    /* ====== RDRAND ====== */

    @("r16")
    auto rdrand(R16 dst) => emit!6(0x0f, 0xc7, dst);
    @("r32")
    auto rdrand(R32 dst) => emit!6(0x0f, 0xc7, dst);
    @("r64")
    auto rdrand(R64 dst) => emit!6(0x0f, 0xc7, dst);

    /* ====== FPU ====== */

    auto fabs() => emit!0(0xd9, 0xe1);
    auto fchs() => emit!0(0xd9, 0xe0);

    auto fclex() => emit!0(0x9b, 0xdb, 0xe2);
    auto fnclex() => emit!0(0xdb, 0xe2);

    @("m32")
    auto fadd(Mem!32 dst) => emit!(0, NO_REX)(0xd8, dst);
    @("m64")
    auto fadd(Mem!64 dst) => emit!(0, NO_REX)(0xdc, dst);
    @("st", "st")
    auto fadd(ST dst, ST src)
    {
        if (dst.index == 0)
            emit!(0, ENCODED)(0xd8, 0xc0, src);
        else if (src.index == 0)
            emit!(0, ENCODED)(0xdc, 0xc0, dst);
        else
            assert(0, "Cannot encode 'fadd' with no 'st0' operand!");
    }
    @("st")
    auto faddp(ST dst) => emit!(0, ENCODED)(0xde, 0xc0, dst);
    @("m16")
    auto fiadd(Mem!16 dst) => emit!(0, NO_REX)(0xde, dst);
    @("m32")
    auto fiadd(Mem!32 dst) => emit!(0, NO_REX)(0xda, dst);

    @("m80")
    auto fbld(Mem!80 dst) => emit!(4, NO_REX)(0xdf, dst);
    @("m80")
    auto fbstp(Mem!80 dst) => emit!(6, NO_REX)(0xdf, dst);

    @("m32")
    auto fcom(Mem!32 dst) => emit!(2, NO_REX)(0xd8, dst);
    @("m64")
    auto fcom(Mem!64 dst) => emit!(2, NO_REX)(0xdc, dst);
    @("st")
    auto fcom(ST dst) => emit!(2, ENCODED)(0xd8, 0xd0, dst);

    @("m32")
    auto fcomp(Mem!32 dst) => emit!(3, NO_REX)(0xd8, dst);
    @("m64")
    auto fcomp(Mem!64 dst) => emit!(3, NO_REX)(0xdc, dst);
    @("st")
    auto fcomp(ST dst) => emit!(2, ENCODED)(0xd8, 0xd8, dst);
    auto fcompp() => emit!0(0xde, 0xd9);

    @("st")
    auto fcomi(ST dst) => emit!(0, ENCODED)(0xdb, 0xf0, dst);
    @("st")
    auto fcomip(ST dst) => emit!(0, ENCODED)(0xdf, 0xf0, dst);
    @("st")
    auto fucomi(ST dst) => emit!(0, ENCODED)(0xdb, 0xe8, dst);
    @("st")
    auto fucomip(ST dst) => emit!(0, ENCODED)(0xdf, 0xe8, dst);

    @("m16")
    auto ficom(Mem!16 dst) => emit!(2, NO_REX)(0xde, dst);
    @("m32")
    auto ficom(Mem!32 dst) => emit!(2, NO_REX)(0xda, dst);
    @("m16")
    auto ficomp(Mem!16 dst) => emit!(2, NO_REX)(0xde, dst);
    @("m32")
    auto ficomp(Mem!32 dst) => emit!(2, NO_REX)(0xda, dst);
    
    @("st")
    auto fucom(ST dst) => emit!(2, ENCODED)(0xdd, 0xe0, dst);
    @("st")
    auto fucomp(ST dst) => emit!(2, ENCODED)(0xdd, 0xe8, dst);
    auto fucompp() => emit!0(0xda, 0xe9);

    auto ftst() => emit!0(0xd9, 0xe4);

    auto f2xm1() => emit!0(0xd9, 0xf0);
    auto fyl2x() => emit!0(0xd9, 0xf1);
    auto fyl2xp1() => emit!0(0xd9, 0xf9);

    auto fcos() => emit!0(0xd9, 0xff);
    auto fsin() => emit!0(0xd9, 0xfe);
    auto fsincos() => emit!0(0xd9, 0xfb);
    auto fsqrt() => emit!0(0xd9, 0xfa);
    
    auto fptan() => emit!0(0xd9, 0xf2);
    auto fpatan() => emit!0(0xd9, 0xf3);
    auto fprem() => emit!0(0xd9, 0xf8);
    auto fprem1() => emit!0(0xd9, 0xf5);

    auto fdecstp() => emit!0(0xd9, 0xf6);
    auto fincstp() => emit!0(0xd9, 0xf7);

    @("m16")
    auto fild(Mem!16 dst) => emit!(0, NO_REX)(0xdf, dst);
    @("m32")
    auto fild(Mem!32 dst) => emit!(0, NO_REX)(0xdb, dst);
    @("m64")
    auto fild(Mem!64 dst) => emit!(5, NO_REX)(0xdf, dst);

    @("m16")
    auto fist(Mem!16 dst) => emit!(2, NO_REX)(0xdf, dst);
    @("m32")
    auto fist(Mem!32 dst) => emit!(2, NO_REX)(0xdb, dst);

    @("m16")
    auto fistp(Mem!16 dst) => emit!(3, NO_REX)(0xdf, dst);
    @("m32")
    auto fistp(Mem!32 dst) => emit!(3, NO_REX)(0xdb, dst);
    @("m64")
    auto fistp(Mem!64 dst) => emit!(7, NO_REX)(0xdf, dst);

    @("m16")
    auto fisttp(Mem!16 dst) => emit!(1, NO_REX)(0xdf, dst);
    @("m32")
    auto fisttp(Mem!32 dst) => emit!(1, NO_REX)(0xdb, dst);
    @("m64")
    auto fisttp(Mem!64 dst) => emit!(1, NO_REX)(0xdd, dst);

    @("m16")
    auto fldcw(Mem!16 dst) => emit!(5, NO_REX)(0xd9, dst);
    @("m16")
    auto fstcw(Mem!16 dst) => emit!(7, NO_REX)(0x9b, 0xd9, dst);
    @("m16")
    auto fnstcw(Mem!16 dst) => emit!(7, NO_REX)(0xd9, dst);

    @("m112")
    auto fldenv(Mem!112 dst) => emit!(4, NO_REX)(0xd9, dst);
    @("m224")
    auto fldenv(Mem!224 dst) => emit!(4, NO_REX)(0xd9, dst);

    @("m112")
    auto fstenv(Mem!112 dst) => emit!(6, NO_REX)(0x9b, 0xd9, dst);
    @("m224")
    auto fstenv(Mem!224 dst) => emit!(6, NO_REX)(0x9b, 0xd9, dst);

    @("m112")
    auto fnstenv(Mem!112 dst) => emit!(6, NO_REX)(0xd9, dst);
    @("m224")
    auto fnstenv(Mem!224 dst) => emit!(6, NO_REX)(0xd9, dst);

    @("m16")
    auto fstsw(Mem!16 dst) => emit!(7, NO_REX)(0x9b, 0xdd, dst);
    auto fstsw() => emit!0(0x9b, 0xdf, 0xe0);
    @("m16")
    auto fnstsw(Mem!16 dst) => emit!(7, NO_REX)(0xdd, dst);
    auto fnstsw() => emit!0(0xdf, 0xe0);

    @("m32")
    auto fld(Mem!32 dst) => emit!(0, NO_REX)(0xd9, dst);
    @("m64")
    auto fld(Mem!64 dst) => emit!(0, NO_REX)(0xdd, dst);
    @("m80")
    auto fld(Mem!80 dst) => emit!(5, NO_REX)(0xdb, dst);
    @("st")
    auto fld(ST dst) => emit!(0, ENCODED)(0xd9, 0xc0, dst);

    auto fld1() => emit!0(0xd9, 0xe8);
    auto fldl2t() => emit!0(0xd9, 0xe9);
    auto fldl2e() => emit!0(0xd9, 0xea);
    auto fldpi() => emit!0(0xd9, 0xeb);
    auto fldlg2() => emit!0(0xd9, 0xec);
    auto fldln2() => emit!0(0xd9, 0xed);
    auto fldz() => emit!0(0xd9, 0xee);

    @("m32")
    auto fst(Mem!32 dst) => emit!(2, NO_REX)(0xd9, dst);
    @("m64")
    auto fst(Mem!64 dst) => emit!(2, NO_REX)(0xdd, dst);
    @("st")
    auto fst(ST dst) => emit!(0, ENCODED)(0xdd, 0xd0, dst);
    
    @("m32")
    auto fstp(Mem!32 dst) => emit!(3, NO_REX)(0xd9, dst);
    @("m64")
    auto fstp(Mem!64 dst) => emit!(3, NO_REX)(0xdd, dst);
    @("m80")
    auto fstp(Mem!80 dst) => emit!(7, NO_REX)(0xdb, dst);
    @("st")
    auto fstp(ST dst) => emit!(0, ENCODED)(0xdd, 0xd8, dst);

    @("m32")
    auto fdiv(Mem!32 dst) => emit!(6, NO_REX)(0xd8, dst);
    @("m64")
    auto fdiv(Mem!64 dst) => emit!(6, NO_REX)(0xdc, dst);
    @("st", "st")
    auto fdiv(ST dst, ST src)
    {
        if (dst.index == 0)
            emit!(0, ENCODED)(0xd8, 0xf0, src);
        else if (src.index == 0)
            emit!(0, ENCODED)(0xdc, 0xf8, dst);
        else
            assert(0, "Cannot encode 'fadd' with no 'st0' operand!");
    }
    @("st")
    auto fdivp(ST dst) => emit!(0, ENCODED)(0xde, 0xf8, dst);
    auto fidiv(Mem!16 dst) => emit!(6, NO_REX)(0xde, dst);
    @("m32")
    auto fidiv(Mem!32 dst) => emit!(6, NO_REX)(0xda, dst);

    @("m32")
    auto fdivr(Mem!32 dst) => emit!(7, NO_REX)(0xd8, dst);
    @("m64")
    auto fdivr(Mem!64 dst) => emit!(7, NO_REX)(0xdc, dst);
    @("st", "st")
    auto fdivr(ST dst, ST src)
    {
        if (dst.index == 0)
            emit!(0, ENCODED)(0xd8, 0xf8, src);
        else if (src.index == 0)
            emit!(0, ENCODED)(0xdc, 0xf0, dst);
        else
            assert(0, "Cannot encode 'fadd' with no 'st0' operand!");
    }
    @("st")
    auto fdivrp(ST dst) => emit!(0, ENCODED)(0xde, 0xf0, dst);
    @("m16")
    auto fidivr(Mem!16 dst) => emit!(7, NO_REX)(0xde, dst);
    @("m32")
    auto fidivr(Mem!32 dst) => emit!(7, NO_REX)(0xda, dst);

    auto fscale() => emit!0(0xd9, 0xfd);
    auto frndint() => emit!0(0xd9, 0xfc);
    auto fexam() => emit!0(0xd9, 0xe5);
    @("st")
    auto ffree(ST dst) => emit!(0, ENCODED)(0xdd, 0xc0, dst);
    @("st")
    auto fxch(ST dst) => emit!(0, ENCODED)(0xd9, 0xc8, dst);
    auto fxtract() => emit!0(0xd9, 0xf4);

    auto fnop() => emit!0(0xd9, 0xd0);
    auto fninit() => emit!0(0x9b, 0xdb, 0xe3);
    auto finit() => emit!0(0xdb, 0xe3);

    @("m752")
    auto fsave(Mem!752 dst) => emit!6(0x9b, 0xdd, dst);
    @("m864")
    auto fsave(Mem!864 dst) => emit!6(0x9b, 0xdd, dst);

    @("m752")
    auto fnsave(Mem!752 dst) => emit!6(0xdd, dst);
    @("m864")
    auto fnsave(Mem!864 dst) => emit!6(0xdd, dst);

    @("m752")
    auto frstor(Mem!752 dst) => emit!4(0xdd, dst);
    @("m864")
    auto frstor(Mem!864 dst) => emit!4(0xdd, dst);

    static if (!X64)
    @("m4096")
    auto fxsave(Mem!4096 dst) => emit!(0, NO_REX)(0x0f, 0xae, dst);
    static if (X64)
    @("m4096")
    auto fxsave(Mem!4096 dst) => emit!(0, NO_REX)(0x48, 0x0f, 0xae, dst);
    
    static if (!X64)
    @("m4096")
    auto fxrstor(Mem!4096 dst) => emit!(1, NO_REX)(0x0f, 0xae, dst);
    static if (X64)
    @("m4096")
    auto fxrstor(Mem!4096 dst) => emit!(1, NO_REX)(0x48, 0x0f, 0xae, dst);

    @("m32")
    auto fmul(Mem!32 dst) => emit!(1, NO_REX)(0xd8, dst);
    @("m64")
    auto fmul(Mem!64 dst) => emit!(1, NO_REX)(0xdc, dst);
    @("st", "st")
    auto fmul(ST dst, ST src)
    {
        if (dst.index == 0)
            emit!(0, ENCODED)(0xd8, 0xc8, src);
        else if (src.index == 0)
            emit!(0, ENCODED)(0xdc, 0xc8, dst);
        else
            assert(0, "Cannot encode 'fadd' with no 'st0' operand!");
    }
    @("st")
    auto fmulp(ST dst) => emit!(0, ENCODED)(0xde, 0xc8, dst);
    @("m16")
    auto fimul(Mem!16 dst) => emit!(1, NO_REX)(0xde, dst);
    @("m32")
    auto fimul(Mem!32 dst) => emit!(1, NO_REX)(0xda, dst);

    @("m32")
    auto fsub(Mem!32 dst) => emit!(4, NO_REX)(0xd8, dst);
    @("m64")
    auto fsub(Mem!64 dst) => emit!(4, NO_REX)(0xdc, dst);
    @("st", "st")
    auto fsub(ST dst, ST src)
    {
        if (dst.index == 0)
            emit!(0, ENCODED)(0xd8, 0xe0, src);
        else if (src.index == 0)
            emit!(0, ENCODED)(0xdc, 0xe8, dst);
        else
            assert(0, "Cannot encode 'fadd' with no 'st0' operand!");
    }
    @("st")
    auto fsubp(ST dst) => emit!(0, ENCODED)(0xde, 0xe8, dst);
    @("m16")
    auto fisub(Mem!16 dst) => emit!(4, NO_REX)(0xde, dst);
    @("m32")
    auto fisub(Mem!32 dst) => emit!(4, NO_REX)(0xda, dst);

    @("m32")
    auto fsubr(Mem!32 dst) => emit!(5, NO_REX)(0xd8, dst);
    @("m64")
    auto fsubr(Mem!64 dst) => emit!(5, NO_REX)(0xdc, dst);
    @("st", "st")
    auto fsubr(ST dst, ST src)
    {
        if (dst.index == 0)
            emit!(0, ENCODED)(0xd8, 0xe8, src);
        else if (src.index == 0)
            emit!(0, ENCODED)(0xdc, 0xe0, dst);
        else
            assert(0, "Cannot encode 'fadd' with no 'st0' operand!");
    }
    @("st")
    auto fsubrp(ST dst) => emit!(0, ENCODED)(0xde, 0xe0, dst);
    @("m16")
    auto fisubr(Mem!16 dst) => emit!(5, NO_REX)(0xde, dst);
    @("m32")
    auto fisubr(Mem!32 dst) => emit!(5, NO_REX)(0xda, dst);

    @("st")
    auto fcmovb(ST dst) => emit!(0, ENCODED)(0xda, 0xc0, dst);
    @("st")
    auto fcmove(ST dst) => emit!(0, ENCODED)(0xda, 0xc8, dst);
    @("st")
    auto fcmovbe(ST dst) => emit!(0, ENCODED)(0xda, 0xd0, dst);
    @("st")
    auto fcmovu(ST dst) => emit!(0, ENCODED)(0xda, 0xd8, dst);
    @("st")
    auto fcmovnb(ST dst) => emit!(0, ENCODED)(0xdb, 0xc0, dst);
    @("st")
    auto fcmovne(ST dst) => emit!(0, ENCODED)(0xdb, 0xc8, dst);
    @("st")
    auto fcmovnbe(ST dst) => emit!(0, ENCODED)(0xdb, 0xd0, dst);
    @("st")
    auto fcmovnu(ST dst) => emit!(0, ENCODED)(0xdb, 0xd8, dst);

    /* ====== TSC ====== */

    auto rdtsc() => emit!0(0x0f, 0x31);
    auto rdtscp() => emit!0(0x0f, 0x01, 0xf9);

    /* ====== MSR ====== */

    auto rdmsr() => emit!0(0x0f, 0x32);
    auto wrmsr() => emit!0(0x0f, 0x30);
    
    /* ====== CX8 ====== */

    @("m64")
    auto cmpxchg8b(Mem!64 dst) => emit!(1, NO_REX)(0x0f, 0xc7, dst);

    /* ====== SEP ====== */
    
    auto sysenter() => emit!0(0x0f, 0x34);
    auto sysexitc() => emit!0(0x0f, 0x35);
    auto sysexit() => emit!0(0x0f, 0x35);

    /* ====== CMOV ====== */

    @("r16", "rm16")
    auto cmova(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x47, dst, src);
    @("r32", "rm32")
    auto cmova(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x47, dst, src);
    @("r64", "rm64")
    auto cmova(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x47, dst, src);
    
    @("r16", "rm16")
    auto cmovae(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x43, dst, src);
    @("r32", "rm32")
    auto cmovae(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x43, dst, src);
    @("r64", "rm64")
    auto cmovae(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x43, dst, src);
    
    @("r16", "rm16")
    auto cmovb(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x42, dst, src);
    @("r32", "rm32")
    auto cmovb(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x42, dst, src);
    @("r64", "rm64")
    auto cmovb(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x42, dst, src);
    
    @("r16", "rm16")
    auto cmovbe(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x46, dst, src);
    @("r32", "rm32")
    auto cmovbe(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x46, dst, src);
    @("r64", "rm64")
    auto cmovbe(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x46, dst, src);
    
    @("r16", "rm16")
    auto cmovc(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x42, dst, src);
    @("r32", "rm32")
    auto cmovc(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x42, dst, src);
    @("r64", "rm64")
    auto cmovc(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x42, dst, src);
    
    @("r16", "rm16")
    auto cmove(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x44, dst, src);
    @("r32", "rm32")
    auto cmove(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x44, dst, src);
    @("r64", "rm64")
    auto cmove(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x44, dst, src);
    
    @("r16", "rm16")
    auto cmovg(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x4f, dst, src);
    @("r32", "rm32")
    auto cmovg(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x4f, dst, src);
    @("r64", "rm64")
    auto cmovg(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x4f, dst, src);
    
    @("r16", "rm16")
    auto cmovge(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x4d, dst, src);
    @("r32", "rm32")
    auto cmovge(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x4d, dst, src);
    @("r64", "rm64")
    auto cmovge(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x4d, dst, src);
    
    @("r16", "rm16")
    auto cmovl(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x4c, dst, src);
    @("r32", "rm32")
    auto cmovl(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x4c, dst, src);
    @("r64", "rm64")
    auto cmovl(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x4c, dst, src);
    
    @("r16", "rm16")
    auto cmovle(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x4e, dst, src);
    @("r32", "rm32")
    auto cmovle(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x4e, dst, src);
    @("r64", "rm64")
    auto cmovle(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x4e, dst, src);
    
    @("r16", "rm16")
    auto cmovna(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x46, dst, src);
    @("r32", "rm32")
    auto cmovna(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x46, dst, src);
    @("r64", "rm64")
    auto cmovna(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x46, dst, src);
    
    @("r16", "rm16")
    auto cmovnae(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x42, dst, src);
    @("r32", "rm32")
    auto cmovnae(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x42, dst, src);
    @("r64", "rm64")
    auto cmovnae(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x42, dst, src);
    
    @("r16", "rm16")
    auto cmovnb(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x43, dst, src);
    @("r32", "rm32")
    auto cmovnb(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x43, dst, src);
    @("r64", "rm64")
    auto cmovnb(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x43, dst, src);
    
    @("r16", "rm16")
    auto cmovnbe(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x47, dst, src);
    @("r32", "rm32")
    auto cmovnbe(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x47, dst, src);
    @("r64", "rm64")
    auto cmovnbe(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x47, dst, src);
    
    @("r16", "rm16")
    auto cmovnc(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x43, dst, src);
    @("r32", "rm32")
    auto cmovnc(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x43, dst, src);
    @("r64", "rm64")
    auto cmovnc(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x43, dst, src);
    
    @("r16", "rm16")
    auto cmovne(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x45, dst, src);
    @("r32", "rm32")
    auto cmovne(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x45, dst, src);
    @("r64", "rm64")
    auto cmovne(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x45, dst, src);
    
    @("r16", "rm16")
    auto cmovng(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x4e, dst, src);
    @("r32", "rm32")
    auto cmovng(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x4e, dst, src);
    auto cmovng(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x4e, dst, src);
    
    @("r16", "rm16")
    auto cmovnge(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x4c, dst, src);
    @("r32", "rm32")
    auto cmovnge(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x4c, dst, src);
    @("r64", "rm64")
    auto cmovnge(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x4c, dst, src);
    
    @("r16", "rm16")
    auto cmovnl(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x4d, dst, src);
    @("r32", "rm32")
    auto cmovnl(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x4d, dst, src);
    @("r64", "rm64")
    auto cmovnl(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x4d, dst, src);
    
    @("r16", "rm16")
    auto cmovnle(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x4f, dst, src);
    @("r32", "rm32")
    auto cmovnle(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x4f, dst, src);
    @("r64", "rm64")
    auto cmovnle(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x4f, dst, src);
    
    @("r16", "rm16")
    auto cmovno(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x41, dst, src);
    @("r32", "rm32")
    auto cmovno(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x41, dst, src);
    @("r64", "rm64")
    auto cmovno(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x41, dst, src);
    
    @("r16", "rm16")
    auto cmovnp(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x4b, dst, src);
    @("r32", "rm32")
    auto cmovnp(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x4b, dst, src);
    @("r64", "rm64")
    auto cmovnp(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x4b, dst, src);
    
    @("r16", "rm16")
    auto cmovns(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x49, dst, src);
    @("r32", "rm32")
    auto cmovns(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x49, dst, src);
    @("r64", "rm64")
    auto cmovns(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x49, dst, src);
    
    @("r16", "rm16")
    auto cmovnz(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x45, dst, src);
    @("r32", "rm32")
    auto cmovnz(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x45, dst, src);
    @("r64", "rm64")
    auto cmovnz(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x45, dst, src);
    
    @("r16", "rm16")
    auto cmovo(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x40, dst, src);
    @("r32", "rm32")
    auto cmovo(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x40, dst, src);
    @("r64", "rm64")
    auto cmovo(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x40, dst, src);
    
    @("r16", "rm16")
    auto cmovp(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x4a, dst, src);
    @("r32", "rm32")
    auto cmovp(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x4a, dst, src);
    @("r64", "rm64")
    auto cmovp(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x4a, dst, src);
    
    @("r16", "rm16")
    auto cmovpe(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x4a, dst, src);
    @("r32", "rm32")
    auto cmovpe(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x4a, dst, src);
    @("r64", "rm64")
    auto cmovpe(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x4a, dst, src);
    
    @("r16", "rm16")
    auto cmovpo(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x4b, dst, src);
    @("r32", "rm32")
    auto cmovpo(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x4b, dst, src);
    @("r64", "rm64")
    auto cmovpo(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x4b, dst, src);
    
    @("r16", "rm16")
    auto cmovs(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x48, dst, src);
    @("r32", "rm32")
    auto cmovs(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x48, dst, src);
    @("r64", "rm64")
    auto cmovs(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x48, dst, src);
    
    @("r16", "rm16")
    auto cmovz(RM)(R16 dst, RM src) if (valid!(RM, 16)) => emit!0(0x0f, 0x44, dst, src);
    @("r32", "rm32")
    auto cmovz(RM)(R32 dst, RM src) if (valid!(RM, 32)) => emit!0(0x0f, 0x44, dst, src);
    @("r64", "rm64")
    auto cmovz(RM)(R64 dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x44, dst, src);

    /* ====== CLFL ====== */

    @("rm8")
    auto clflush(RM)(RM dst) if (valid!(RM, 8)) => emit!(7, NO_REX)(0x0f, 0xae, dst);

    /* ====== HRESET ====== */

    @("mimm8")
    auto hreset(ubyte imm8) => emit!0(0xf3, 0x0f, 0x3a, 0xf0, 0xc0, imm8, eax);

    /* ====== CET ====== */
    // Shadow stack instruction set.

    @("r32")
    auto incsspd(R32 dst) => emit!5(0xf3, 0x0f, 0xae, dst);
    @("r64")
    auto incsspq(R64 dst) => emit!5(0xf3, 0x0f, 0xae, dst);

    @("m64")
    auto clrssbsy(Mem!64 dst) => emit!6(0xf3, 0x0f, 0xae, dst);
    auto setssbsy() => emit!0(0xf3, 0x0f, 0x01, 0xe8);

    @("r32")
    auto rdsspd(R32 dst) => emit!1(0xf3, 0x0f, 0x1e, dst);
    @("r64")
    auto rdsspq(R64 dst) => emit!1(0xf3, 0x0f, 0x1e, dst);

    @("m32", "r32")
    auto wrssd(Mem!32 dst, R32 src) => emit!0(0xf3, 0x38, 0xf6, dst, src);
    @("m64", "r64")
    auto wrssq(Mem!64 dst, R64 src) => emit!0(0xf3, 0x38, 0xf6, dst, src);

    @("m32", "r32")
    auto wrussd(Mem!32 dst, R32 src) => emit!1(0x66, 0xf3, 0x38, 0xf5, dst, src);
    @("m64", "r64")
    auto wrussq(Mem!64 dst, R64 src) => emit!1(0x66, 0xf3, 0x38, 0xf5, dst, src);

    @("m64")
    auto rstorssp(Mem!64 dst) => emit!5(0xf3, 0x0f, 0x01, dst);
    auto saveprevssp() => emit!5(0xf3, 0x0f, 0x01, 0xae, edx);

    auto endbr32() => emit!0(0xf3, 0x0f, 0x1e, 0xfb);
    auto endbr64() => emit!0(0xf3, 0x0f, 0x1e, 0xfa);

    /* ====== FSGSBASE ====== */

    @("r32")
    auto rdfsbase(R32 dst) => emit!0(0xf3, 0x0f, 0xae, dst);
    @("r64")
    auto rdfsbase(R64 dst) => emit!0(0xf3, 0x0f, 0xae, dst);

    @("r32")
    auto rdgsbase(R32 dst) => emit!1(0xf3, 0x0f, 0xae, dst);
    @("r64")
    auto rdgsbase(R64 dst) => emit!1(0xf3, 0x0f, 0xae, dst);

    @("r32")
    auto wrfsbase(R32 dst) => emit!2(0xf3, 0x0f, 0xae, dst);
    @("r64")
    auto wrfsbase(R64 dst) => emit!2(0xf3, 0x0f, 0xae, dst);
    
    @("r32")
    auto wrgsbase(R32 dst) => emit!3(0xf3, 0x0f, 0xae, dst);
    @("r64")
    auto wrgsbase(R64 dst) => emit!3(0xf3, 0x0f, 0xae, dst);

    /* ====== RDPID ====== */

    @("r32")
    auto rdpid(R32 dst) => emit!7(0xf3, 0x0f, 0xc7, dst);
    @("r64")
    auto rdpid(R64 dst) => emit!7(0xf3, 0x0f, 0xc7, dst);

    /* ====== OSPKE ====== */

    auto wrpkru() => emit!0(0x0f, 0x01, 0xef);
    auto rdpkru() => emit!0(0x0f, 0x01, 0xee);

    /* ====== UINTR ====== */

    auto testui() => emit!0(0xf3, 0x0f, 0x01, 0xed);
    auto stui() => emit!0(0xf3, 0x0f, 0x01, 0xef);
    auto clui() => emit!0(0xf3, 0x0f, 0x01, 0xee);
    auto uiret() => emit!0(0xf3, 0x0f, 0x01, 0xec);

    @("rm8")
    auto senduipi(RM)(RM dst) if (valid!(RM, 8)) => emit!6(0xf3, 0x0f, 0xc7, dst);
    @("rm16")
    auto senduipi(RM)(RM dst) if (valid!(RM, 16)) => emit!6(0xf3, 0x0f, 0xc7, dst);
    @("rm32")
    auto senduipi(RM)(RM dst) if (valid!(RM, 32)) => emit!6(0xf3, 0x0f, 0xc7, dst);
    @("rm64")
    auto senduipi(RM)(RM dst) if (valid!(RM, 64)) => emit!6(0xf3, 0x0f, 0xc7, dst);

    /* ====== WAITPKG ====== */
    
    @("r32")
    auto umwait(R32 dst) => emit!6(0xf2, 0x0f, 0xae, dst);
    @("r16")
    auto umonitor(R16 dst) => emit!6(0xf3, 0x0f, 0xae, dst);
    @("r32")
    auto umonitor(R32 dst) => emit!6(0xf3, 0x0f, 0xae, dst);
    @("r64")
    auto umonitor(R64 dst) => emit!6(0xf3, 0x0f, 0xae, dst);
    @("r32")
    auto tpause(R32 dst) => emit!6(0x0f, 0xae, dst);

    /* ====== CLDEMOTE ====== */
    
    @("rm8")
    auto cldemote(RM)(RM dst) if (valid!(RM, 8)) => emit!0(0x0f, 0x1c, dst);

    /* ====== TSXLDTRK ====== */

    auto xresldtrk() => emit!0(0xf2, 0x0f, 0x01, 0xe9);
    auto xsusldtrk() => emit!0(0xf2, 0x0f, 0x01, 0xe8);

    /* ====== SERALIZE ====== */
    
    auto serialize() => emit!0(0x0f, 0x01, 0xe8);

    /* ====== PCONFIG ====== */

    auto pconfig() => emit!0(0x0f, 0x01, 0xc5);

    /* ====== PMC ====== */

    auto rdpmc() => emit!0(0x0f, 0x33); 

    /* ====== UMIP ====== */

    auto wbinvd() => emit!0(0x0f, 0x09);
    auto wbnoinvd() => emit!0(0xf3, 0x0f, 0x09);
    
    auto invd() => emit!0(0x0f, 0x08);

    @("rm32")
    auto lgdt(RM)(RM dst) if (valid!(RM, 32)) => emit!2(0x0f, 0x01, dst);
    @("rm64")
    auto lgdt(RM)(RM dst) if (valid!(RM, 64)) => emit!2(0x0f, 0x01, dst);
    @("rm64")
    auto sgdt(RM)(RM dst) if (valid!(RM, 64)) => emit!0(0x0f, 0x01, dst);

    @("rm16")
    auto lldt(RM)(RM dst) if (valid!(RM, 16)) => emit!2(0x0f, 0x00, dst);
    @("rm16")
    auto sldt(RM)(RM dst) if (valid!(RM, 16)) => emit!0(0x0f, 0x00, dst);

    @("rm32")
    auto lidt(RM)(RM dst) if (valid!(RM, 32)) => emit!3(0x0f, 0x01, dst);
    @("rm64")
    auto lidt(RM)(RM dst) if (valid!(RM, 64)) => emit!3(0x0f, 0x01, dst);
    @("rm64")
    auto sidt(RM)(RM dst) if (valid!(RM, 64)) => emit!1(0x0f, 0x01, dst);

    @("rm16")
    auto lmsw(RM)(RM dst) if (valid!(RM, 16)) => emit!6(0x0f, 0x01, dst);

    @("rm16")
    auto smsw(RM)(RM dst) if (valid!(RM, 16)) => emit!4(0x0f, 0x01, dst);
    @("rm32")
    auto smsw(RM)(RM dst) if (valid!(RM, 32)) => emit!4(0x0f, 0x01, dst);
    @("rm64")
    auto smsw(RM)(RM dst) if (valid!(RM, 64)) => emit!4(0x0f, 0x01, dst);

    /* ====== PCID ====== */

    @("rm64")
    auto invlpg(RM)(RM dst) if (valid!(RM, 64)) => emit!7(0x0f, 0x01, dst);

    /* ====== LAHF-SAHF ====== */

    auto sahf() => emit!0(0x9e);
    auto lahf() => emit!0(0x9f);

    /* ====== BMI2 ====== */

    auto sarx(RM)(R32 dst, RM src, R32 cnt) if (valid!(RM, 32)) => emit!(0, VEX | INT, 128, M38, 0xf3)(0xf7, dst, src, cnt);
    auto shlx(RM)(R32 dst, RM src, R32 cnt) if (valid!(RM, 32)) => emit!(0, VEX | INT, 128, M38, 0x66)(0xf7, dst, src, cnt);
    auto shrx(RM)(R32 dst, RM src, R32 cnt) if (valid!(RM, 32)) => emit!(0, VEX | INT, 128, M38, 0xf2)(0xf7, dst, src, cnt);

    auto sarx(RM)(R64 dst, RM src, R64 cnt) if (valid!(RM, 64)) => emit!(0, VEX | INT, 128, M38, 0xf3)(0xf7, dst, src, cnt);
    auto shlx(RM)(R64 dst, RM src, R64 cnt) if (valid!(RM, 64)) => emit!(0, VEX | INT, 128, M38, 0x66)(0xf7, dst, src, cnt);
    auto shrx(RM)(R64 dst, RM src, R64 cnt) if (valid!(RM, 64)) => emit!(0, VEX | INT, 128, M38, 0xf2)(0xf7, dst, src, cnt);

    /* ====== MMX ====== */

    auto movq(RM)(MMX dst, RM src) if (valid!(RM, 64)) => emit!(0, NO_REX | FLIP)(0x0f, 0x6f, dst, src);
    auto movq(Mem!64 dst, MMX src) => emit!(0, NO_REX | FLIP)(0x0f, 0x7f, dst, src);

    auto movd(RM)(MMX dst, RM src) if (valid!(RM, 32)) => emit!(0, NO_REX | FLIP)(0x0f, 0x6e, dst, src);
    auto movd(RM)(RM dst, MMX src) if (valid!(RM, 32)) => emit!(0, NO_REX | FLIP)(0x0f, 0x7e, dst, src);

    auto movq(RM)(MMX dst, RM src) if (valid!(RM, 64)) => emit!0(0x0f, 0x6e, dst, src);
    auto movq(RM)(RM dst, MMX src) if (valid!(RM, 64)) => emit!0(0x0f, 0x7e, dst, src);

    /* ====== NO_REX | FLIP ====== */

    auto addpd(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x66, 0x0f, 0x58, dst, src);
    auto addps(RM)(XMM dst, RM src) if (valid!(RM, 128)) => emit!(0, NO_REX | FLIP)(0x0f, 0x58, dst, src);
    auto addss(RM)(XMM dst, RM src) if (valid!(RM, 128, 32)) => emit!(0, NO_REX | FLIP)(0xf3, 0x0f, 0x58, dst, src);
    auto addsd(RM)(XMM dst, RM src) if (valid!(RM, 128, 32)) => emit!(0, NO_REX | FLIP)(0xf2, 0x0f, 0x58, dst, src);
