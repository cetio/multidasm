/// Method calls and returns.
module tests.cil.calls;

import multidasm.cil;

import unit_threaded;

@Name("calls a method and returns")
unittest
{
    enum encoded = {
        Block block;
        with (block)
        {
            call(0x0a000001);
            ret();
        }
        return block.finalize();
    }();

    encoded.should == [
        0x28, 0x01, 0x00, 0x00, 0x0a,
        0x2a
    ];
}

@Name("tail-calls a method")
unittest
{
    enum encoded = {
        Block block;
        with (block)
        {
            tail_();
            call(0x0a000001);
            ret();
        }
        return block.finalize();
    }();

    encoded.should == [
        0xfe, 0x14,
        0x28, 0x01, 0x00, 0x00, 0x0a,
        0x2a
    ];
}
