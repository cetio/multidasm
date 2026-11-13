/// x87 floating-point instructions.
module tests.amd64.fpu;

import multidasm.amd64;

import unit_threaded;

@Name("distinguishes ficomp from ficom")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            ficomp(dwordPtr(rbx));
            ficom(dwordPtr(rbx));
        }
        return block.finalize();
    }();

    encoded.should == [
        0xda, 0x1b,
        0xda, 0x13
    ];
}

@Name("emits the WAIT prefix for finit but not fninit")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            finit();
            fninit();
        }
        return block.finalize();
    }();

    encoded.should == [
        0x9b, 0xdb, 0xe3,
        0xdb, 0xe3
    ];
}

@Name("adds, multiplies, and compares against the stack")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            fadd(dwordPtr(rbx));
            fmulp(st1);
            fcomi(st2);
        }
        return block.finalize();
    }();

    encoded.should == [
        0xd8, 0x03,
        0xde, 0xc9,
        0xdb, 0xf2
    ];
}

// Known gaps.

@Name("implements the AX form of fstsw")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            fstsw(ax);
            fstsw();
        }
        return block.finalize();
    }();

    encoded.should == [
        0x9b, 0xdf, 0xe0,
        0x9b, 0xdf, 0xe0
    ];

    __traits(compiles, {
        enum invalid = {
            Block!true block;
            block.fstsw(cx);
            return block.finalize();
        }();
    }).should == false;
}

@Name("implements the implied-operand form of faddp")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            faddp();
            faddp(st1);
            faddp(st0);
        }
        return block.finalize();
    }();

    encoded.should == [
        0xde, 0xc1,
        0xde, 0xc1,
        0xde, 0xc0
    ];
}
