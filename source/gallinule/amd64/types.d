// Types, registers, and constraints for gallinule.amd64
module gallinule.amd64.types;

import std.traits;

/// Register or memory operand of the given size(s).
enum valid(T, short SIZE) = is(T == Reg!SIZE) || is(T == Mem!SIZE);
enum valid(T, short RS, short AS) = is(T == Reg!RS) || is(T == Mem!AS);

public struct Reg(short SIZE)
{
public:
final:
    ubyte index;
    bool extended;
}

public struct Mem(short SIZE)
{
public:
final:
    short size;
    ubyte register;
    uint offset;
    ubyte segment = ds;

    this(T)(T register, ubyte segment, uint offset = 0)
        if (isInstanceOf!(Reg, T))
    {
        this.size = TemplateArgsOf!(T)[0];
        this.register = register.index;
        this.offset = offset;
        this.segment = segment;
    }

    this(T)(T register, uint offset = 0)
        if (isInstanceOf!(Reg, T))
    {
        this.size = TemplateArgsOf!(T)[0];
        this.register = register.index;
        this.offset = offset;
    }

    this(uint offset, ubyte segment = ds)
    {
        this.register = 4;
        this.offset = offset;
        this.segment = segment;
    }
}

public enum CRID
{
    VME, PVI, TSD, DE, PSE, PAE, MCE, PGE, PCE,
    OSFXSR, OSXMMEXCPT, UMIP,
    VMXE = 13, SMXE,
    FSGSBASE = 16, PCIDE, OSXSAVE,
    SMEP = 20, SMAP, PKE, CET, PKS, UINTR
}

public enum CPUID7_EBX
{
    FSGSBASE, TSC_ADJUST, SGX, BMI1, HLE, AVX2, FPDP, SMEP, BMI2, ERMS,
    INVPCID, RTM, PQM, FPCSDS, MPX, PQE, AVX512F, AVX512DQ, RDSEED, ADX,
    SMAP, AVX512IFMA, PCOMMIT, CLFLUSHOPT, CLWB, PT, AVX512PF, AVX512ER,
    AVX512CD, SHA, AVX512BW, AVX512VL
}

public enum CPUID7_ECX
{
    PREFETCHWT1, AVX512VBMI, UMIP, PKU, OSPKE, AVX512VBMI2 = 6, CET,
    GFNI, VAES, VPCL, AVX512VNNI, AVX512BITALG, TME, AVX512VP,
    VA57 = 16, RDPID = 22, SGX_LC = 30
}

public enum CPUID7_EDX
{
    AVX512QVNNIW = 2, AVX512QFMA = 3, PCONFIG = 18, IBRS_IBPB = 26, STIBP = 27
}

public enum CPUID1_ECX
{
    SSE3, PCLMUL, DTES64, MON, DSCPL, VMX, SMX, EST, TM2, SSSE3, CID, SDBG,
    FMA, CX16, XTPR, PDCM, PCID, DCA, SSE4_1, SSE4_2, X2APIC, MOVBE, POPCNT,
    TSCD, AES, XSAVE, OSXSAVE, AVX, F16C, RDRAND, HV
}

public enum CPUID1_EDX
{
    FPU, VME, DE, PSE, TSC, MSR, PAE, CX8, APIC, SEP, MTRR, PGE, MCA, CMOV,
    PAT, PSE36, PSN, CLFL, DS, ACPI, MMX, FXSR, NP, SSE2, SS, HTT, TM, IA64, PBE
}

public:
alias CR = Reg!(-1);
alias DR = Reg!(-2);
alias ST = Reg!(-3);
alias R8 = Reg!8;
alias R16 = Reg!16;
alias R32 = Reg!32;
alias R64 = Reg!64;
alias MMX = Reg!64;
alias XMM = Reg!128;
alias YMM = Reg!256;
alias ZMM = Reg!512;

enum cr0 = CR(0);
enum cr2 = CR(2);
enum cr3 = CR(3);
enum cr4 = CR(4);

enum dr0 = DR(0);
enum dr1 = DR(1);
enum dr2 = DR(2);
enum dr3 = DR(3);
enum dr6 = DR(6);
enum dr7 = DR(7);

enum st0 = ST(0);
enum st1 = ST(1);
enum st2 = ST(2);
enum st3 = ST(3);
enum st4 = ST(4);
enum st5 = ST(5);
enum st6 = ST(6);
enum st7 = ST(7);

enum al = Reg!8(0);
enum cl = Reg!8(1);
enum dl = Reg!8(2);
enum bl = Reg!8(3);
enum ah = Reg!8(4);
enum ch = Reg!8(5);
enum dh = Reg!8(6);
enum bh = Reg!8(7);
enum spl = Reg!8(4, true);
enum bpl = Reg!8(5, true);
enum sil = Reg!8(6, true);
enum dil = Reg!8(7, true);
enum r8b = Reg!8(8);
enum r9b = Reg!8(9);
enum r10b = Reg!8(10);
enum r11b = Reg!8(11);
enum r12b = Reg!8(12);
enum r13b = Reg!8(13);
enum r14b = Reg!8(14);
enum r15b = Reg!8(15);

enum ax = Reg!16(0);
enum cx = Reg!16(1);
enum dx = Reg!16(2);
enum bx = Reg!16(3);
enum sp = Reg!16(4);
enum bp = Reg!16(5);
enum si = Reg!16(6);
enum di = Reg!16(7);
enum r8w = Reg!16(8);
enum r9w = Reg!16(9);
enum r10w = Reg!16(10);
enum r11w = Reg!16(11);
enum r12w = Reg!16(12);
enum r13w = Reg!16(13);
enum r14w = Reg!16(14);
enum r15w = Reg!16(15);

enum eax = Reg!32(0);
enum ecx = Reg!32(1);
enum edx = Reg!32(2);
enum ebx = Reg!32(3);
enum esp = Reg!32(4);
enum ebp = Reg!32(5);
enum esi = Reg!32(6);
enum edi = Reg!32(7);
enum r8d = Reg!32(8);
enum r9d = Reg!32(9);
enum r10d = Reg!32(10);
enum r11d = Reg!32(11);
enum r12d = Reg!32(12);
enum r13d = Reg!32(13);
enum r14d = Reg!32(14);
enum r15d = Reg!32(15);

enum rax = Reg!64(0);
enum rcx = Reg!64(1);
enum rdx = Reg!64(2);
enum rbx = Reg!64(3);
enum rsp = Reg!64(4);
enum rbp = Reg!64(5);
enum rsi = Reg!64(6);
enum rdi = Reg!64(7);
enum r8 = Reg!64(8);
enum r9 = Reg!64(9);
enum r10 = Reg!64(10);
enum r11 = Reg!64(11);
enum r12 = Reg!64(12);
enum r13 = Reg!64(13);
enum r14 = Reg!64(14);
enum r15 = Reg!64(15);

enum mm0 = Reg!64(0);
enum mm1 = Reg!64(1);
enum mm2 = Reg!64(2);
enum mm3 = Reg!64(3);
enum mm4 = Reg!64(4);
enum mm5 = Reg!64(5);
enum mm6 = Reg!64(6);
enum mm7 = Reg!64(7);

enum xmm0 = Reg!128(0);
enum xmm1 = Reg!128(1);
enum xmm2 = Reg!128(2);
enum xmm3 = Reg!128(3);
enum xmm4 = Reg!128(4);
enum xmm5 = Reg!128(5);
enum xmm6 = Reg!128(6);
enum xmm7 = Reg!128(7);
enum xmm8 = Reg!128(8);
enum xmm9 = Reg!128(9);
enum xmm10 = Reg!128(10);
enum xmm11 = Reg!128(11);
enum xmm12 = Reg!128(12);
enum xmm13 = Reg!128(13);
enum xmm14 = Reg!128(14);
enum xmm15 = Reg!128(15);

enum ymm0 = Reg!256(0);
enum ymm1 = Reg!256(1);
enum ymm2 = Reg!256(2);
enum ymm3 = Reg!256(3);
enum ymm4 = Reg!256(4);
enum ymm5 = Reg!256(5);
enum ymm6 = Reg!256(6);
enum ymm7 = Reg!256(7);
enum ymm8 = Reg!256(8);
enum ymm9 = Reg!256(9);
enum ymm10 = Reg!256(10);
enum ymm11 = Reg!256(11);
enum ymm12 = Reg!256(12);
enum ymm13 = Reg!256(13);
enum ymm14 = Reg!256(14);
enum ymm15 = Reg!256(15);

enum zmm0 = Reg!512(0);
enum zmm1 = Reg!512(1);
enum zmm2 = Reg!512(2);
enum zmm3 = Reg!512(3);
enum zmm4 = Reg!512(4);
enum zmm5 = Reg!512(5);
enum zmm6 = Reg!512(6);
enum zmm7 = Reg!512(7);
enum zmm8 = Reg!512(8);
enum zmm9 = Reg!512(9);
enum zmm10 = Reg!512(10);
enum zmm11 = Reg!512(11);
enum zmm12 = Reg!512(12);
enum zmm13 = Reg!512(13);
enum zmm14 = Reg!512(14);
enum zmm15 = Reg!512(15);

enum ubyte es = 0x26;
enum ubyte cs = 0x2e;
enum ubyte ss = 0x36;
enum ubyte ds = 0x3e;
enum ubyte fs = 0x64;
enum ubyte gs = 0x65;
