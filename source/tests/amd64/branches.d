/// Conditional branches, loops, and label resolution.
module tests.amd64.branches;

import multidasm.amd64;

import unit_threaded;

@Name("resolves forward and backward branches")
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
        }
        return block.finalize();
    }();

    encoded.should == [
        0xff, 0xc0,
        0x75, 0x02,
        0xff, 0xc8,
        0xe2, 0xf8
    ];
}

@Name("jumps to a label")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            jmp("done");
            label("done");
            ret();
        }
        return block.finalize();
    }();

    encoded.should == [0xeb, 0x00, 0xc3];
}

@Name("resolves jcxz labels")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            jcxz("target");
            nop();
            label("target");
        }
        return block.finalize();
    }();

    encoded.should == [0xe3, 0x01, 0x90];
}

@Name("resolves jcxz labels in 32-bit mode")
unittest
{
    enum encoded = {
        Block!false block;
        with (block)
        {
            jcxz("target");
            nop();
            label("target");
            ret();
        }
        return block.finalize();
    }();

    encoded.should == [0xe3, 0x01, 0x90, 0xc3];
}

// Known defects.

@Name("widens branches with a four-byte displacement")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            jne("far");
            foreach (_; 0..130)
                nop();
            label("far");
        }
        return block.finalize();
    }();

    ubyte[] expected = [0x0f, 0x85, 0x82, 0x00, 0x00, 0x00];
    foreach (_; 0..130)
        expected ~= 0x90;

    encoded.should == expected;
}

@Name("calls through memory with the near-call extension")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            call(qwordPtr(rbx));
        }
        return block.finalize();
    }();

    encoded.should == [0xff, 0x13];
}

@Name("calls through extended registers and memory without REX.W")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            call(rax);
            call(r9);
            call(qwordPtr(r9));
            call(qwordPtr(r9, 8));
        }
        return block.finalize();
    }();

    encoded.should == [
        0xff, 0xd0,
        0x41, 0xff, 0xd1,
        0x41, 0xff, 0x11,
        0x41, 0xff, 0x51, 0x08
    ];
}

@Name("calls through word and doubleword operands in 32-bit mode")
unittest
{
    enum encoded = {
        Block!false block;
        with (block)
        {
            call(ax);
            call(eax);
            call(wordPtr(ebx));
            call(dwordPtr(ebx));
        }
        return block.finalize();
    }();

    encoded.should == [
        0x66, 0xff, 0xd0,
        0xff, 0xd0,
        0x66, 0xff, 0x13,
        0xff, 0x13
    ];
}

@Name("rejects indirect calls with target widths invalid for the mode")
unittest
{
    __traits(compiles, { Block!true block; block.call(ax); }).should == false;
    __traits(compiles, { Block!true block; block.call(eax); }).should == false;
    __traits(compiles, { Block!true block; block.call(wordPtr(rbx)); }).should == false;
    __traits(compiles, { Block!true block; block.call(dwordPtr(rbx)); }).should == false;
    __traits(compiles, { Block!false block; block.call(rax); }).should == false;
    __traits(compiles, { Block!false block; block.call(qwordPtr(ebx)); }).should == false;
}

@Name("returns with a 16-bit immediate without an operand-size prefix")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            ret(16);
        }
        return block.finalize();
    }();

    encoded.should == [0xc2, 0x10, 0x00];
}

@Name("preserves return stack adjustments without changing operand size")
unittest
{
    static foreach (X64; [false, true])
    {
        {
            enum encoded = {
                Block!X64 block;
                with (block)
                {
                    ret();
                    ret(0);
                    ret(0x1234);
                    retf();
                    retf(0);
                    retf(0xffff);
                }
                return block.finalize();
            }();

            encoded.should == [
                0xc3,
                0xc2, 0x00, 0x00,
                0xc2, 0x34, 0x12,
                0xcb,
                0xca, 0x00, 0x00,
                0xca, 0xff, 0xff
            ];
        }
    }
}
