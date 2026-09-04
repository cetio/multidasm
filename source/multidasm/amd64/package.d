// Originally based on: https://github.com/philpax/djitt
module multidasm.amd64;

public import multidasm.amd64.types;
import multidasm.amd64.encoding;
import std.bitmanip : nativeToLittleEndian;
import std.traits;
import std.typecons;

struct Block(bool X64)
{
package:
final:
    Tuple!(ptrdiff_t, size_t)[string] labels;
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

            static if ((SELECTOR & VEX_MASK) == 0)
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

                static if ((SELECTOR & NO_REX) == 0)
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

            static if ((SELECTOR & VEX_MASK) != 0)
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
                    buffer ~= nativeToLittleEndian(arg);
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
                    buffer ~= generateModRM!OP(dst, src);
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
                static if ((SELECTOR & VEX_MASK) != 0)
                    generatePrefix(Reg!(typeof(args[0]).sizeof * 128)(0), Reg!(typeof(args[0]).sizeof * 128)(0));

                static if ((SELECTOR & VEX_MASK) == 0)
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

        ubyte[] branchWidths = new ubyte[branches.length];
        branchWidths[] = 1;

        size_t branchSize(size_t index)
        {
            immutable string key = branches[index][2]~cast(char)('0' + branchWidths[index]);
            return branchMap[key].length + branchWidths[index];
        }

        ptrdiff_t branchPosition(size_t index)
        {
            ptrdiff_t ret = branches[index][0];
            foreach (i; 0..index)
                ret += branchSize(i);

            return ret;
        }

        ptrdiff_t labelPosition(string name)
        {
            ptrdiff_t ret = labels[name][0];
            foreach (i; 0..labels[name][1])
                ret += branchSize(i);

            return ret;
        }

        bool changed;
        do
        {
            changed = false;
            foreach (index, branch; branches)
            {
                assert(branch[1] in labels, "Branch label not defined: "~branch[1]);
                immutable ptrdiff_t relative = labelPosition(branch[1]) - branchPosition(index) - branchSize(index);

                if (branchWidths[index] == 1 && (relative < byte.min || relative > byte.max))
                {
                    immutable string key = branch[2]~'2';
                    assert(key in branchMap, "Branch offset out of range: "~branch[2]);
                    branchWidths[index] = 2;
                    changed = true;
                }
                else if (branchWidths[index] == 2 && (relative < short.min || relative > short.max))
                {
                    immutable string key = branch[2]~'4';
                    assert(key in branchMap, "Branch offset out of range: "~branch[2]);
                    branchWidths[index] = 4;
                    changed = true;
                }
            }
        }
        while (changed);

        size_t inserted;
        foreach (index, branch; branches)
        {
            immutable size_t position = cast(size_t)branch[0] + inserted;
            immutable ptrdiff_t relative = labelPosition(branch[1]) - cast(ptrdiff_t)position - branchSize(index);
            immutable string key = branch[2]~cast(char)('0' + branchWidths[index]);
            ubyte[] encoded = branchMap[key].dup;
            encoded ~= nativeToLittleEndian(relative)[0..branchWidths[index]];
            this.buffer = this.buffer[0..position]~encoded~this.buffer[position..$];
            inserted += encoded.length;
        }
        branches = null;
        return this.buffer;
    }

    void label(string name)
    {
        labels[name] = tuple(cast(ptrdiff_t)buffer.length, branches.length);
    }
    
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

unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            push(rcx);
            pop(rbx);
            mov(eax, ecx);
            movsxd(rcx, eax);
            mov(ebx, 1);
            add(eax, ebx);
            sub(rdi, 10);
            test(al, bl);
            inc(eax);
            dec(rax);
        }
        return block.finalize();
    }();

    enum ubyte[] EXPECTED = [
        0x51,
        0x5b,
        0x89, 0xc8,
        0x48, 0x63, 0xc8,
        0xbb, 0x01, 0x00, 0x00, 0x00,
        0x01, 0xd8,
        0x48, 0x83, 0xef, 0x0a,
        0x84, 0xd8,
        0xff, 0xc0,
        0x48, 0xff, 0xc8
    ];
    
    static assert(encoded == EXPECTED);
}

unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            mov(eax, dwordPtr(rbx));
            mov(dwordPtr(rax, 4), ecx);
            mov(rdx, qwordPtr(rbp, 32));
            mov(bytePtr(rsi), al);
            mov(wordPtr(rdi, 16), dx);
        }
        return block.finalize();
    }();

    enum ubyte[] EXPECTED = [
        0x8b, 0x03,
        0x89, 0x48, 0x04,
        0x48, 0x8b, 0x55, 0x20,
        0x88, 0x06,
        0x66, 0x89, 0x57, 0x10
    ];

    static assert(encoded == EXPECTED);
}

unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            lock(add(dwordPtr(rax), ebx));
            xacquire_lock(sub(dwordPtr(rdi), esi));
            xrelease(mov(dwordPtr(rdx), ecx));
            stc();
            std();
            clc();
            wait();
            fwait();
            hlt();
            swapgs();
            monitor();
            lfence();
            sfence();
            pause();
            movsb();
            cmpsb();
            scasb();
            insb();
            outal(128);
            outal();
        }
        return block.finalize();
    }();

    enum ubyte[] EXPECTED = [
        0xf0, 0x01, 0x18,
        0xf2, 0xf0, 0x29, 0x37,
        0xf3, 0x89, 0x0a,
        0xf9,
        0xfd,
        0xf8,
        0x9b,
        0x9b,
        0xf4,
        0x0f, 0x01, 0xf8,
        0x0f, 0x01, 0xc8,
        0x0f, 0xae, 0xe8,
        0x0f, 0xae, 0xf8,
        0xf3, 0x90,
        0xa4,
        0xa6,
        0xae,
        0x6c,
        0xe6, 0x80,
        0xee
    ];

    static assert(encoded == EXPECTED);
}

unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            label("start");
            inc(eax);
            jne("forward");
            dec(eax);
            label("forward");
            loop("start");
            jmp("done");
            label("done");
            ret();
        }
        return block.finalize();
    }();

    enum ubyte[] EXPECTED = [
        0xff, 0xc0,
        0x75, 0x02,
        0xff, 0xc8,
        0xe2, 0xf8,
        0xeb, 0x00,
        0xc3
    ];

    static assert(encoded == EXPECTED);
}

unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            movdqa(xmm0, xmm1);
            movdqu(xmm2, xmmwordPtr(rax));
            pxor(xmm0, xmm1);
            pshufb(xmm0, xmm1);
            pshufd(xmm0, xmm1, 0);
            paddq(xmm0, xmm1);
            pblendw(xmm0, xmm1, 0);
            roundpd(xmm2, xmm3, 0);
            ptest(xmm0, xmm1);
            pcmpgtq(xmm0, xmm1);
        }
        return block.finalize();
    }();

    enum ubyte[] EXPECTED = [
        0x66, 0x0f, 0x6f, 0xc1,
        0xf3, 0x0f, 0x6f, 0x10,
        0x66, 0x0f, 0xef, 0xc1,
        0x66, 0x0f, 0x38, 0x00, 0xc1,
        0x66, 0x0f, 0x70, 0xc1, 0x00,
        0x66, 0x0f, 0xd4, 0xc1,
        0x66, 0x0f, 0x3a, 0x0e, 0xc1, 0x00,
        0x66, 0x0f, 0x3a, 0x09, 0xd3, 0x00,
        0x66, 0x0f, 0x38, 0x17, 0xc1,
        0x66, 0x0f, 0x38, 0x37, 0xc1
    ];

    static assert(encoded == EXPECTED);
}

unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            vpaddb(xmm0, xmm1, xmm2);
            vfmadd132pd(xmm3, xmm4, xmm5);
        }
        return block.finalize();
    }();

    enum ubyte[] EXPECTED = [
        0xc5, 0xf1, 0xfc, 0xc2,
        0xc4, 0xe2, 0xd9, 0x98, 0xdd
    ];

    static assert(encoded == EXPECTED);
}