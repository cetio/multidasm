// Originally based on: https://github.com/philpax/djitt
module multidasm.amd64;

public import multidasm.amd64.types;
import multidasm.amd64.encoding;
import std.traits;
import tern.traits : Attributes;
import std.typecons;
import tern.algorithm;
import tern.state;

struct Block(bool X64)
{
package:
final:
    ptrdiff_t[string] labels;
    Tuple!(ptrdiff_t, string, string, bool)[] branches;
    ubyte[] buffer;

public:
    template emit(ubyte OP, ubyte SELECTOR = 0, ubyte SIZE = 128, ubyte MAP = 1, ubyte PREFIX = 0)
    {
        size_t emit(ARGS...)(ARGS args)
        {
            ubyte[] buffer;
            bool prefixed;
            ptrdiff_t ct = 0;

            bool isRM1(size_t INDEX)()
            {
                static if (INDEX >= ARGS.length)
                    return false;
                else static if (INDEX + 1 >= ARGS.length)
                    return isInstanceOf!(Reg, ARGS[INDEX]) || isInstanceOf!(Mem, ARGS[INDEX]);
                else
                {
                    return (isInstanceOf!(Reg, ARGS[INDEX]) || isInstanceOf!(Mem, ARGS[INDEX])) &&
                        !isInstanceOf!(Reg, ARGS[INDEX + 1]) && !isInstanceOf!(Mem, ARGS[INDEX + 1]);
                }
            }
            
            bool isRM2(size_t INDEX)()
            {
                static if (INDEX + 1 >= ARGS.length)
                    return false;
                else
                    return (isInstanceOf!(Reg, ARGS[INDEX]) || isInstanceOf!(Mem, ARGS[INDEX])) && isRM1!(INDEX + 1);
            }
            
            bool isRM3(size_t INDEX)()
            {
                static if (INDEX + 2 >= ARGS.length)
                    return false;
                else
                    return (isInstanceOf!(Reg, ARGS[INDEX]) || isInstanceOf!(Mem, ARGS[INDEX])) &&
                        (isInstanceOf!(Reg, ARGS[INDEX + 1]) || isInstanceOf!(Mem, ARGS[INDEX + 1])) && isRM1!(INDEX + 2);
            }

            static if ((SELECTOR & VEX) == 0)
            void generatePrefix(SRC, DST, STOR = int)(SRC src, DST dst, STOR stor = STOR.init)
            {
                prefixed = true;
                bool hasRex;
                bool w;
                bool r;
                bool x;
                bool b;

                static if (isInstanceOf!(Reg, SRC))
                {
                    hasRex |= is(SRC == Reg!64) || (is(SRC == Reg!8) && src.extended) || src.index >= 8;
                    w = is(SRC == Reg!64);
                    b = src.index >= 8;
                }
                else static if (isInstanceOf!(Mem, SRC))
                {
                    hasRex |= src.register >= 8;
                    w = is(SRC == Mem!64);
                    b = src.register >= 8;
                }
                
                static if (isInstanceOf!(Reg, DST))
                {
                    hasRex |= is(DST == Reg!64) || (is(DST == Reg!8) && dst.extended) || dst.index >= 8;
                    w = is(DST == Reg!64);
                    b = dst.index >= 8;
                }
                else static if (isInstanceOf!(Mem, DST))
                {
                    hasRex |= dst.register >= 8;
                    w = is(DST == Mem!64);
                    x = dst.register >= 8;
                }

                // With NO_REX_W (e.g. push/pop r64), only emit REX when R/X/B are needed, not W.
                static if ((SELECTOR & NO_REX_W) != 0)
                    hasRex = r || x || b;

                static if (isInstanceOf!(Mem, SRC))
                {
                    if (src.segment != ds)
                        buffer = src.segment~buffer;
                }
                else static if (isInstanceOf!(Mem, DST))
                {
                    if (dst.segment != ds)
                        buffer = dst.segment~buffer;
                }

                static if ((SELECTOR & (NO_REX | NO_REX_W)) != 0)
                if (hasRex)
                {
                    ubyte rex = 0b01000000;
                    if ((SELECTOR & NO_REX_W) == 0 && w) rex |= (1 << 3);
                    if (r) rex |= (1 << 2);
                    if (x) rex |= (1 << 1);
                    if (b) rex |= (1 << 0);
                    size_t pos = 0;
                    while (pos < buffer.length && (buffer[pos] == 0x66 || buffer[pos] == 0x67 || buffer[pos] == 0xf0 || buffer[pos] == 0xf2 || buffer[pos] == 0xf3))
                        pos++;
                    buffer = buffer[0..pos]~rex~buffer[pos..$];
                }

                static if (is(SRC == Reg!16) || is(DST == Reg!16))
                    buffer = 0x66~buffer;
                
                // 0x67 = address-size: in 64-bit mode default is 64-bit; do not use operand size.
                static if (isInstanceOf!(Mem, SRC))
                {
                    if (!X64 && src.size != 32)
                        buffer = 0x67~buffer;
                }

                static if (isInstanceOf!(Mem, DST))
                {
                    if (!X64 && dst.size != 32)
                        buffer = 0x67~buffer;
                }
            }

            static if ((SELECTOR & VEX) != 0)
            void generatePrefix(SRC, DST, STOR = int)(SRC src, DST dst, STOR stor = STOR.init)
            {
                prefixed = true;
                bool r;
                bool x;
                bool b;
                immutable ubyte map_select = MAP;
                bool we = (SELECTOR & VEX) != 0;
                ubyte vvvv = 0b1111;
                immutable bool l = SIZE != 128;
                immutable ubyte pp = (PREFIX == 0x66) ? 1 : ((PREFIX == 0xf3) ? 2 : ((PREFIX == 0xf2) ? 3 : 0));

                static if (isInstanceOf!(Reg, STOR))
                {
                    static if (isInstanceOf!(Reg, DST))
                        vvvv = cast(ubyte)~dst.index;
                    else static if (isInstanceOf!(Mem, DST))
                        vvvv = cast(ubyte)~dst.register;

                    dst = DST(stor.index);
                }
                else static if (isInstanceOf!(Mem, STOR))
                {
                    static if (isInstanceOf!(Reg, DST))
                        vvvv = cast(ubyte)~dst.index;
                    else static if (isInstanceOf!(Mem, DST))
                        vvvv = cast(ubyte)~dst.register;
                        
                    dst = DST(stor.register);
                }

                static if (isInstanceOf!(Reg, SRC))
                {
                    static if ((SELECTOR & INT) != 0)
                        we = !is(SRC == Reg!32);

                    b = src.index >= 8;
                }
                else static if (isInstanceOf!(Mem, SRC))
                {
                    static if ((SELECTOR & INT) != 0)
                        we = !is(SRC == Mem!32);

                    b = src.register >= 8;
                }
                
                static if (isInstanceOf!(Reg, DST))
                {
                    static if ((SELECTOR & INT) != 0)
                        we = !is(DST == Reg!32);

                    r = dst.index >= 8;
                }
                else static if (isInstanceOf!(Mem, DST))
                {
                    static if ((SELECTOR & INT) != 0)
                        we = !is(DST == Mem!32);

                    x = dst.register >= 8;
                }

                static if (isInstanceOf!(Mem, SRC))
                {
                    if (src.segment != ds)
                        buffer = src.segment~buffer;
                }
                else static if (isInstanceOf!(Mem, DST))
                {
                    if (dst.segment != ds)
                        buffer = dst.segment~buffer;
                }

                ubyte[] vex;
                // Use 2-byte VEX (0xC5) when: map=1, R=0, X=0, B=0, W=0
                // Otherwise use 3-byte VEX (0xC4) or XOP (0x8F)
                if (map_select != 1 || r || x || b)
                {
                    static if ((SELECTOR & INT) == 0)
                        we = false;

                    vex ~= 0xc4;
                    vex ~= (cast(ubyte)(((r ? 0 : 1) << 5) | ((x ? 0 : 1) << 6) | ((b ? 0 : 1) << 7))) | (map_select & 0b00011111);
                }
                else
                    vex ~= 0xc5;

                vex ~= we << 7 | (vvvv & 0b00001111) << 3 | (l ? 1 : 0) << 2 | (pp & 0b00000011);
                buffer = vex~buffer;
                
                static if (isInstanceOf!(Mem, SRC))
                {
                    if (!X64 && src.size != 32)
                        buffer = 0x67~buffer;
                }

                static if (isInstanceOf!(Mem, DST))
                {
                    if (!X64 && dst.size != 32)
                        buffer = 0x67~buffer;
                }
            }

            foreach (i, arg; args)
            {
                if (ct-- > 0)
                    continue;

                static if (is(typeof(arg) == int))
                    buffer ~= cast(ubyte)arg;
                else static if (isScalarType!(typeof(arg)))
                    buffer ~= (cast(ubyte*)&arg)[0..typeof(arg).sizeof];
                else static if (is(typeof(arg) == ubyte[]))
                    buffer ~= arg;
                else static if ((SELECTOR & ENCODED) != 0 && isInstanceOf!(Reg, typeof(arg)))
                {
                    buffer[$-1] += arg.index % 8;
                    generatePrefix(typeof(arg)(0), arg);
                }
                else static if (isRM1!i)
                {
                    auto dst = arg;
                    auto src = Reg!(TemplateArgsOf!(typeof(arg)))(0);
                    static if ((SELECTOR & FLIP) != 0)
                        buffer ~= generateModRM!OP(dst, src);
                    else
                        buffer ~= generateModRM!OP(src, dst);
                    generatePrefix(src, dst);
                }
                else static if (isRM2!i)
                {
                    auto dst = arg;
                    auto src = args[i + 1];
                    static if ((SELECTOR & FLIP) != 0)
                        buffer ~= generateModRM!OP(dst, src);
                    else
                        buffer ~= generateModRM!OP(src, dst);
                    generatePrefix(src, dst);
                    ct = 1;
                }
                else static if (isRM3!i)
                {
                    auto dst = args[i + 2];
                    auto src = arg;
                    buffer ~= generateModRM!OP(dst, src);
                    generatePrefix(src, args[i + 1], dst);
                    ct = 2;
                }
                else
                    static assert(0, "May not emit a non-scalar, non-ubyte[] value of type '"~typeof(arg).stringof~"'!");
            }

            if (!prefixed)
            {
                static if ((SELECTOR & VEX) != 0)
                    generatePrefix(Reg!(typeof(args[0]).sizeof * 128)(0), Reg!(typeof(args[0]).sizeof * 128)(0));

                static if ((SELECTOR & VEX) == 0)
                foreach (i, arg; args)
                {
                    static if (!is(typeof(arg) == int))
                    {
                        static if (args.length - i - 1 == 0)
                            generatePrefix(Reg!(typeof(arg).sizeof * 8)(0), Reg!(typeof(arg).sizeof * 8)(0));
                        else static if (args.length - i - 1 == 1)
                            generatePrefix(Reg!(typeof(arg).sizeof * 8)(0), Reg!(typeof(args[i + 1]).sizeof * 8)(0));
                        else static if (args.length - i - 1 == 2)
                            generatePrefix(Reg!(typeof(arg).sizeof * 8)(0), Reg!(typeof(args[i + 1]).sizeof * 8)(0), Reg!(typeof(args[i + 2]).sizeof * 8)(0));
                        break;
                    }
                }
            }

            this.buffer ~= buffer;
            return buffer.length;
        }
    }

    ubyte[] finalize()
    {
        immutable static ubyte[][string] branchMap = [
            "jmp1": [0xeb],
            "jmp2": [0xe9],
            "jmp4": [0xe9],
            "ja1": [0x77],
            "jae1": [0x73],
            "jb1": [0x72],
            "jbe1": [0x76],
            "jc1": [0x72],
            "jecxz1": [0xE3],
            "jrcxz1": [0xE3],
            "je1": [0x74],
            "jg1": [0x7F],
            "jge1": [0x7D],
            "jl1": [0x7C],
            "jle1": [0x7E],
            "jna1": [0x76],
            "jnae1": [0x72],
            "jnb1": [0x73],
            "jnbe1": [0x77],
            "jnc1": [0x73],
            "jne1": [0x75],
            "jng1": [0x7E],
            "jnge1": [0x7C],
            "jnl1": [0x7D],
            "jnle1": [0x7F],
            "jno1": [0x71],
            "jnp1": [0x7B],
            "jns1": [0x79],
            "jnz1": [0x75],
            "jo1": [0x70],
            "jp1": [0x7A],
            "jpe1": [0x7A],
            "jpo1": [0x7B],
            "js1": [0x78],
            "jz1": [0x74],
            "ja2": [0x0F, 0x87],
            "ja4": [0x0F, 0x87],
            "jae2": [0x0F, 0x83],
            "jae4": [0x0F, 0x83],
            "jb2": [0x0F, 0x82],
            "jb4": [0x0F, 0x82],
            "jbe2": [0x0F, 0x86],
            "jbe4": [0x0F, 0x86],
            "jc2": [0x0F, 0x82],
            "jc4": [0x0F, 0x82],
            "je2": [0x0F, 0x84],
            "je4": [0x0F, 0x84],
            "jz2": [0x0F, 0x84],
            "jz4": [0x0F, 0x84],
            "jg2": [0x0F, 0x8F],
            "jg4": [0x0F, 0x8F],
            "jge2": [0x0F, 0x8D],
            "jge4": [0x0F, 0x8D],
            "jl2": [0x0F, 0x8C],
            "jl4": [0x0F, 0x8C],
            "jle2": [0x0F, 0x8E],
            "jle4": [0x0F, 0x8E],
            "jna2": [0x0F, 0x86],
            "jna4": [0x0F, 0x86],
            "jnae2": [0x0F, 0x82],
            "jnae4": [0x0F, 0x82],
            "jnb2": [0x0F, 0x83],
            "jnb4": [0x0F, 0x83],
            "jnbe2": [0x0F, 0x87],
            "jnbe4": [0x0F, 0x87],
            "jnc2": [0x0F, 0x83],
            "jnc4": [0x0F, 0x83],
            "jne2": [0x0F, 0x85],
            "jne4": [0x0F, 0x85],
            "jng2": [0x0F, 0x8E],
            "jng4": [0x0F, 0x8E],
            "jnge2": [0x0F, 0x8C],
            "jnge4": [0x0F, 0x8C],
            "jnl2": [0x0F, 0x8D],
            "jnl4": [0x0F, 0x8D],
            "jnle2": [0x0F, 0x8F],
            "jnle4": [0x0F, 0x8F],
            "jno2": [0x0F, 0x81],
            "jno4": [0x0F, 0x81],
            "jnp2": [0x0F, 0x8B],
            "jnp4": [0x0F, 0x8B],
            "jns2": [0x0F, 0x89],
            "jns4": [0x0F, 0x89],
            "jnz2": [0x0F, 0x85],
            "jnz4": [0x0F, 0x85],
            "jo2": [0x0F, 0x80],
            "jo4": [0x0F, 0x80],
            "jp2": [0x0F, 0x8A],
            "jp4": [0x0F, 0x8A],
            "jpe2": [0x0F, 0x8A],
            "jpe4": [0x0F, 0x8A],
            "jpo2": [0x0F, 0x8B],
            "jpo4": [0x0F, 0x8B],
            "js2": [0x0F, 0x88],
            "js4": [0x0F, 0x88],
            "jz2": [0x0F, 0x84],
            "jz4": [0x0F, 0x84],
            "loop1": [0xe2],
            "loope1": [0xe1],
            "loopne1": [0xe0]
        ];

        size_t abs;
        size_t calculateBranch(T)(T branch)
        {
            size_t size;
            auto rel = labels[branch[1]] - branch[0] + abs;
            bool isRel8 = rel <= 127 && rel >= -128;
            bool isRel16 = rel <= 32_767 && rel >= -32_768;

            if (isRel8)
                size = branchMap[branch[2]~'1'].length + 1;
            else if (isRel16)
                size = branchMap[branch[2]~'2'].length + 2;
            else
                size = branchMap[branch[2]~'4'].length + 4;

            return size;
        }

        foreach (ref i, branch; branches)
        {
            if (i + 1 < branches.length && branches[i + 1][3] && branches[i + 1][0] == branch[0])
                labels[branch[1]] += calculateBranch(branches[i + 1]);

            ubyte[] buffer;

            branch[0] += abs;
            auto rel = labels[branch[1]] - branch[0];
            bool isRel8 = rel <= 127 && rel >= -128;
            bool isRel16 = rel <= 32_767 && rel >= -32_768;

            buffer ~= branchMap[branch[2]~(isRel8 ? '1' : isRel16 ? '2' : '4')];

            if (isRel8)
                buffer ~= cast(ubyte)rel;
            else if (isRel16)
                buffer ~= (cast(ubyte*)&rel)[0..2];
            else
                buffer ~= (cast(ubyte*)&rel)[0..4];

            abs += buffer.length;
            this.buffer = this.buffer[0..branch[0]]~buffer~this.buffer[branch[0]..$];
        }
        branches = null;
        return this.buffer;
    }

    auto label(string name) => labels[name] = buffer.length;
    
    // These categories are intended to separate instructions based on their corresponding flag,
    // however, they do not accurately reflect this and are more whimsical than logical.

    mixin(import("instructions/misc.d"));

    // AVX-512 is not implemented: the emitter has no EVEX encoding path (4-byte prefix, masking, broadcast).

    mixin(import("instructions/sse2.d"));

    mixin(import("instructions/sse3.d"));
    mixin(import("instructions/ssse3.d"));

    mixin(import("instructions/avx.d"));
    mixin(import("instructions/sse41.d"));
    mixin(import("instructions/sse42.d"));
    mixin(import("instructions/avx2.d"));
    mixin(import("instructions/fma.d"));

    mixin(import("instructions/main.d"));

    Mem!8 bytePtr(ARGS...)(ARGS args) => Mem!8(args);
    Mem!16 wordPtr(ARGS...)(ARGS args) => Mem!16(args);
    Mem!32 dwordPtr(ARGS...)(ARGS args) => Mem!32(args);
    Mem!64 qwordPtr(ARGS...)(ARGS args) => Mem!64(args);
    Mem!128 xmmwordPtr(ARGS...)(ARGS args) => Mem!128(args);
    Mem!256 ymmwordPtr(ARGS...)(ARGS args) => Mem!256(args);
    Mem!512 zmmwordPtr(ARGS...)(ARGS args) => Mem!512(args);
}

// Expected bytes for specific instruction sequences (x86_64).
unittest
{
    import std.string : toLower;
    import tern.digest;

    // push r64 / pop r64 must not emit REX.W (opcode 50+rd / 58+rd are already 64-bit).
    Block!true b1;
    with (b1) { push(rcx); }
    assert(b1.finalize().toHexString.toLower == "51", "push(rcx) expected 51");
    Block!true b2;
    with (b2) { pop(rbx); }
    assert(b2.finalize().toHexString.toLower == "5b", "pop(rbx) expected 5b");
    // push r8 / pop r8 need REX.B only (no REX.W).
    Block!true b3;
    with (b3) { push(r8); }
    assert(b3.finalize().toHexString.toLower == "4150", "push(r8) expected 4150");
    Block!true b4;
    with (b4) { pop(r8); }
    assert(b4.finalize().toHexString.toLower == "4158", "pop(r8) expected 4158");
}

// mov eax, [rbx] in 64-bit must not use 0x67 (address-size; default addressing is 64-bit).
unittest
{
    import tern.digest;
    Block!true block;
    with (block) mov(eax, dwordPtr(rbx));
    auto enc = block.finalize();
    assert(enc.length >= 2 && enc[0] == 0x8b && enc[1] == 0x03,
        "mov(eax, dwordPtr(rbx)) expected 8B 03 (no 0x67), got "~enc.toHexString);
}

// Memory displacement: small offset uses 8-bit displacement.
unittest
{
    import tern.digest;
    Block!true block;
    with (block) mov(eax, dwordPtr(rax, 4));
    auto enc = block.finalize();
    // [rax+4]: ModRM mod=01, disp8=4. 8B 40 04.
    assert(enc.length == 3 && enc[0] == 0x8b && enc[1] == 0x40 && enc[2] == 4,
        "mov(eax, dwordPtr(rax,4)) expected 8B 40 04, got "~enc.toHexString);
}

// SSE2/SSSE3 vector instructions assemble (movdqa, movdqu, pxor, pshufb).
unittest
{
    Block!true block;
    with (block)
    {
        movdqa(xmm0, xmm1);
        movdqu(xmm2, xmmwordPtr(rax));
        pxor(xmm0, xmm1);
        pshufb(xmm0, xmm1);
        pshufd(xmm0, xmm1, 0);
        paddq(xmm0, xmm1);
    }
    auto enc = block.finalize();
    assert(enc.length > 0);
}

// Smoke: SSE4.1 (pblendw, roundpd, ptest).
unittest
{
    Block!true block;
    with (block)
    {
        pblendw(xmm0, xmm1, 0);
        roundpd(xmm2, xmm3, 0);
        ptest(xmm0, xmm1);
    }
    auto enc = block.finalize();
    assert(enc.length > 0);
}

// Smoke: SSE4.2 (pcmpgtq).
unittest
{
    Block!true block;
    with (block) pcmpgtq(xmm0, xmm1);
    auto enc = block.finalize();
    assert(enc.length > 0);
}

// Smoke: AVX2 (vpaddb).
unittest
{
    Block!true block;
    with (block) vpaddb(xmm0, xmm1, xmm2);
    auto enc = block.finalize();
    assert(enc.length > 0);
}

// Smoke: FMA (vfmadd132pd).
unittest
{
    Block!true block;
    with (block) vfmadd132pd(xmm0, xmm1, xmm2);
    auto enc = block.finalize();
    assert(enc.length > 0);
}

// movq xmm, r64 / movq r64, xmm: legacy (REX.W+66 0F 6E) or VEX (C5 F8 66 0F 6E) are both valid.
unittest
{
    import tern.digest;
    Block!true block;
    with (block) movq(xmm0, rax);
    auto enc = block.finalize();
    assert(enc.length >= 4);
    bool legacy = enc.length == 5 && enc[0] == 0x48 && enc[1] == 0x66 && enc[2] == 0x0f && enc[3] == 0x6e;
    bool vex = enc.length >= 5 && enc[0] == 0xc5 && enc[1] == 0xf8 && enc[2] == 0x66 && enc[3] == 0x0f && enc[4] == 0x6e;
    assert(legacy || vex, "movq(xmm0, rax) expected legacy or VEX encoding, got "~enc.toHexString);
}

unittest
{
    import tern.digest;
    Block!true block;
    with (block)
    {
        mov(eax, ecx);
        movsxd(rcx, eax);
        mov(ebx, 1);
        pop(rbx);
        push(rcx);
        jl("a");
    label("a");
        popf();
        ret();
        retf(3);
        jmp("a");
        jb("a");
        setz(al);
        insb();
        outal();
        call(2);
        lock(add(eax, ebx));
        xacquire_lock(sub(si, di));
        movsb();
        mov(eax, dwordPtr(ebx));
        mov(eax, dwordPtr(rbx));
        stc();
        std();
        clc();
        wait();
        fwait();
        monitor();
        lfence();
        sfence();
        retf();
        test(al, bl);
        hlt();
        swapgs();
        inc(eax);
        dec(rax);
        dec(rdi);
        sub(rdi, 10);
        mul(esi);
        scasb();
        cmpsb();
        pause();
        iret();
        mov(esp, dwordPtr(rdx));
        pop(rsp);
        mov(rbp, rsp);
    }
    auto enc = block.finalize();
    assert(enc.length > 0);
    // Ensure no erroneous 0x67 before mov-like opcodes that use GPRs.
    bool seen67Bad = false;
    foreach (i; 0..enc.length - 1)
        if (enc[i] == 0x67 && enc[i+1] == 0x8b) seen67Bad = true;
    assert(!seen67Bad, "erroneous 0x67 address-size prefix before 8B (mov)");
    debug import std.stdio; writeln(enc.toHexString);
}