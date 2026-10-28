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
            call(dwordPtr(rbx));
        }
        return block.finalize();
    }();

    encoded.should == [0xff, 0x13];
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
