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
    __traits(compiles, { Block!true block; block.fstsw(ax); }).should == true;
}

@Name("implements the implied-operand form of faddp")
unittest
{
    __traits(compiles, { Block!true block; block.faddp(); }).should == true;
}
