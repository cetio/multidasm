/// Stack operations and stack frames.
module tests.amd64.stack;

import multidasm.amd64;

import unit_threaded;

@Name("pushes and pops registers")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            push(rcx);
            pop(rbx);
        }
        return block.finalize();
    }();

    encoded.should == [0x51, 0x5b];
}

// Known defects.

@Name("pushes immediates above 127 without truncation")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            push(200);
        }
        return block.finalize();
    }();

    encoded.should == [0x68, 0xc8, 0x00, 0x00, 0x00];
}

@Name("pushes segment registers")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            push(fs);
        }
        return block.finalize();
    }();

    encoded.should == [0x0f, 0xa0];
}

@Name("enters a stack frame without an operand-size prefix")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            enter(0, 0);
        }
        return block.finalize();
    }();

    encoded.should == [0xc8, 0x00, 0x00, 0x00];
}
