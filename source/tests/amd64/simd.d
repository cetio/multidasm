/// MMX, SSE, AVX, and FMA instructions.
module tests.amd64.simd;

import multidasm.amd64;

import unit_threaded;

@Name("moves aligned and unaligned vector operands")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            movdqa(xmm0, xmm1);
            movdqu(xmm2, xmmwordPtr(rax));
        }
        return block.finalize();
    }();

    encoded.should == [
        0x66, 0x0f, 0x6f, 0xc1,
        0xf3, 0x0f, 0x6f, 0x10
    ];
}

@Name("applies SSE2 packed integer operations")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            pxor(xmm0, xmm1);
            paddq(xmm0, xmm1);
        }
        return block.finalize();
    }();

    encoded.should == [
        0x66, 0x0f, 0xef, 0xc1,
        0x66, 0x0f, 0xd4, 0xc1
    ];
}

@Name("shuffles bytes with SSSE3")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            pshufb(xmm0, xmm1);
        }
        return block.finalize();
    }();

    encoded.should == [0x66, 0x0f, 0x38, 0x00, 0xc1];
}

@Name("shuffles doublewords with SSE2")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            pshufd(xmm0, xmm1, 0);
        }
        return block.finalize();
    }();

    encoded.should == [0x66, 0x0f, 0x70, 0xc1, 0x00];
}

@Name("blends words, tests bits, and rounds with SSE4.1")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            pblendw(xmm0, xmm1, 0);
            ptest(xmm0, xmm1);
            roundpd(xmm2, xmm3, 0);
        }
        return block.finalize();
    }();

    encoded.should == [
        0x66, 0x0f, 0x3a, 0x0e, 0xc1, 0x00,
        0x66, 0x0f, 0x38, 0x17, 0xc1,
        0x66, 0x0f, 0x3a, 0x09, 0xd3, 0x00
    ];
}

@Name("compares quadwords with SSE4.2")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            pcmpgtq(xmm0, xmm1);
        }
        return block.finalize();
    }();

    encoded.should == [0x66, 0x0f, 0x38, 0x37, 0xc1];
}

@Name("adds packed bytes with AVX at 128 and 256 bits")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            vpaddb(xmm0, xmm1, xmm2);
            vpaddb(ymm0, ymm1, ymm2);
        }
        return block.finalize();
    }();

    encoded.should == [
        0xc5, 0xf1, 0xfc, 0xc2,
        0xc5, 0xf5, 0xfc, 0xc2
    ];
}

@Name("fuses multiply-add with FMA")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            vfmadd132pd(xmm3, xmm4, xmm5);
        }
        return block.finalize();
    }();

    encoded.should == [0xc4, 0xe2, 0xd9, 0x98, 0xdd];
}

@Name("zeroes the upper vector state")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            vzeroall();
            vzeroupper();
        }
        return block.finalize();
    }();

    encoded.should == [
        0xc5, 0xfc, 0x77,
        0xc5, 0xf8, 0x77
    ];
}

// Known defects.

@Name("moves extended vector registers")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            movdqa(xmm8, xmm9);
        }
        return block.finalize();
    }();

    encoded.should == [0x66, 0x45, 0x0f, 0x6f, 0xc1];
}

@Name("adds packed bytes in the order written")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            paddb(xmm0, xmm1);
        }
        return block.finalize();
    }();

    encoded.should == [0x66, 0x0f, 0xfc, 0xc1];
}

@Name("extracts vector sign masks in the order written")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            movmskps(eax, xmm1);
        }
        return block.finalize();
    }();

    encoded.should == [0x0f, 0x50, 0xc1];
}

@Name("orders sarx source and count operands")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            sarx(eax, ecx, edx);
        }
        return block.finalize();
    }();

    encoded.should == [0xc4, 0xe2, 0x6a, 0xf7, 0xc1];
}

@Name("selects the packed-single FMA prefix")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            vfmadd132ps(xmm0, xmm1, xmm2);
        }
        return block.finalize();
    }();

    encoded.should == [0xc4, 0xe2, 0x71, 0x98, 0xc2];
}

@Name("extracts quadwords from memory with REX.W")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            pextrq(qwordPtr(rbx), xmm0, 0);
        }
        return block.finalize();
    }();

    encoded.should == [0x66, 0x48, 0x0f, 0x3a, 0x16, 0x03, 0x00];
}

@Name("inserts quadwords with REX.W")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            pinsrq(xmm0, rax, 0);
        }
        return block.finalize();
    }();

    encoded.should == [0x66, 0x48, 0x0f, 0x3a, 0x22, 0xc0, 0x00];
}

@Name("moves general registers with movq")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            movq(rdi, qwordPtr(rbx));
        }
        return block.finalize();
    }();

    encoded.should == [0x48, 0x8b, 0x3b];
}

@Name("moves a general register into an MMX register")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            movq(mm0, rax);
        }
        return block.finalize();
    }();

    encoded.should == [0x48, 0x0f, 0x6e, 0xc0];
}

@Name("disambiguates vmovq from memory")
unittest
{
    __traits(compiles, { Block!true block; block.vmovq(xmm0, qwordPtr(rbx)); }).should == true;
}

@Name("extracts bytes into 32-bit registers")
unittest
{
    __traits(compiles, { Block!true block; block.pextrb(eax, xmm0, 0); }).should == true;
}

@Name("inserts words from 32-bit registers")
unittest
{
    __traits(compiles, { Block!true block; block.pinsrw(xmm0, eax, 0); }).should == true;
}

@Name("implements scalar conversions")
unittest
{
    __traits(compiles, { Block!true block; block.cvtsi2sd(xmm0, eax); }).should == true;
    __traits(compiles, { Block!true block; block.cvtss2si(eax, xmm0); }).should == true;
}

@Name("implements the MXCSR load and store")
unittest
{
    __traits(compiles, { Block!true block; block.ldmxcsr(dwordPtr(rbx)); }).should == true;
    __traits(compiles, { Block!true block; block.stmxcsr(dwordPtr(rbx)); }).should == true;
}
