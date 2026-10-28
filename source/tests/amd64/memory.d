/// Memory operand forms and addressing modes.
module tests.amd64.memory;

import multidasm.amd64;

import unit_threaded;

@Name("reads from a register base")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            mov(eax, dwordPtr(rbx));
            mov(rdx, qwordPtr(rbp, 32));
        }
        return block.finalize();
    }();

    encoded.should == [
        0x8b, 0x03,
        0x48, 0x8b, 0x55, 0x20
    ];
}

@Name("writes to a register base with displacement")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            mov(dwordPtr(rax, 4), ecx);
            mov(wordPtr(rdi, 16), dx);
        }
        return block.finalize();
    }();

    encoded.should == [
        0x89, 0x48, 0x04,
        0x66, 0x89, 0x57, 0x10
    ];
}

@Name("stores a byte register")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            mov(bytePtr(rsi), al);
        }
        return block.finalize();
    }();

    encoded.should == [0x88, 0x06];
}

@Name("moves bounds through bndmov")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            bndmov(dwordPtr(rbx), eax);
        }
        return block.finalize();
    }();

    encoded.should == [0x66, 0x0f, 0x1b, 0x03];
}

// Known defects.

@Name("emits a SIB byte for stack-pointer bases")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            mov(eax, dwordPtr(rsp));
        }
        return block.finalize();
    }();

    encoded.should == [0x8b, 0x04, 0x24];
}

@Name("emits a zero displacement for base-pointer operands")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            mov(eax, dwordPtr(rbp));
        }
        return block.finalize();
    }();

    encoded.should == [0x8b, 0x45, 0x00];
}

@Name("encodes 16-bit addressing in 32-bit mode")
unittest
{
    enum encoded = {
        Block!false block;
        with (block)
        {
            mov(ax, wordPtr(bx));
        }
        return block.finalize();
    }();

    encoded.should == [0x67, 0x66, 0x8b, 0x07];
}

@Name("implements movbe")
unittest
{
    __traits(compiles, { Block!true block; block.movbe(eax, dwordPtr(rbx)); }).should == true;
}

@Name("implements movnti")
unittest
{
    __traits(compiles, { Block!true block; block.movnti(dwordPtr(rbx), eax); }).should == true;
}
