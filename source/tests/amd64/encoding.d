/// REX, VEX, and segment prefix encoding.
module tests.amd64.encoding;

import multidasm.amd64;

import unit_threaded;

@Name("VEX prefixes address extended memory bases")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            vmovd(xmm0, dwordPtr(r8));
            vmovd(dwordPtr(r8), xmm0);
        }
        return block.finalize();
    }();

    encoded.should == [
        0xc4, 0xc1, 0x79, 0x6e, 0x00,
        0xc4, 0xc1, 0x79, 0x7e, 0x00
    ];
}

@Name("VEX prefixes select extended vector registers")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            vpaddb(xmm8, xmm9, xmm10);
        }
        return block.finalize();
    }();

    encoded.should == [0xc4, 0x41, 0x31, 0xfc, 0xc2];
}

@Name("VEX prefixes select extended general registers")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            andn(r8, r9, r10);
        }
        return block.finalize();
    }();

    encoded.should == [0xc4, 0x42, 0xb0, 0xf2, 0xc2];
}

// Known defects.

@Name("extends registers in the modrm.reg field")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            mov(eax, r8d);
        }
        return block.finalize();
    }();

    encoded.should == [0x44, 0x89, 0xc0];
}

@Name("extends memory destinations through REX.B")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            mov(qwordPtr(r9), rax);
        }
        return block.finalize();
    }();

    encoded.should == [0x49, 0x89, 0x01];
}

@Name("places segment prefixes before REX")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            mov(rax, Mem!64(rbx, fs));
        }
        return block.finalize();
    }();

    encoded.should == [0x64, 0x48, 0x8b, 0x03];
}

@Name("places segment prefixes outside VEX")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            vmovd(xmm0, Mem!32(rbx, fs));
        }
        return block.finalize();
    }();

    encoded.should == [0x64, 0xc5, 0xf9, 0x6e, 0x03];
}

@Name("rejects 64-bit registers in 32-bit mode")
unittest
{
    __traits(compiles, { Block!false block; block.mov(rax, rbx); }).should == false;
}
