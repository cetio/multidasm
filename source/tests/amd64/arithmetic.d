/// Integer moves, arithmetic, and bit operations.
module tests.amd64.arithmetic;

import multidasm.amd64;

import unit_threaded;

@Name("moves between registers and from immediates")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            mov(eax, ecx);
            mov(ebx, 1);
            movsxd(rcx, eax);
        }
        return block.finalize();
    }();

    encoded.should == [
        0x89, 0xc8,
        0xbb, 0x01, 0x00, 0x00, 0x00,
        0x48, 0x63, 0xc8
    ];
}

@Name("adds, subtracts, increments, and decrements")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            add(eax, ebx);
            sub(rdi, 10);
            inc(eax);
            dec(rax);
        }
        return block.finalize();
    }();

    encoded.should == [
        0x01, 0xd8,
        0x48, 0x83, 0xef, 0x0a,
        0xff, 0xc0,
        0x48, 0xff, 0xc8
    ];
}

@Name("tests bits between byte registers")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            test(al, bl);
        }
        return block.finalize();
    }();

    encoded.should == [0x84, 0xd8];
}

@Name("tests a 64-bit register against a 32-bit immediate")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            test(rax, 0x80000000);
        }
        return block.finalize();
    }();

    encoded.should == [0x48, 0xf7, 0xc0, 0x00, 0x00, 0x00, 0x80];
}

@Name("exchanges with the accumulator")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            xchg(ax);
            xchg(eax);
            xchg(rax);
        }
        return block.finalize();
    }();

    encoded.should == [
        0x66, 0x90,
        0x90,
        0x48, 0x90
    ];
}

@Name("adds with carry in 32-bit mode")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            adcx(eax, ebx);
        }
        return block.finalize();
    }();

    encoded.should == [0x66, 0x0f, 0x38, 0xf6, 0xc3];
}

// Known defects.

@Name("compares operands in the order written")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            cmp(eax, ebx);
        }
        return block.finalize();
    }();

    encoded.should == [0x39, 0xd8];
}

@Name("selects imm32 for compare immediates above 127")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            cmp(rdi, 200);
        }
        return block.finalize();
    }();

    encoded.should == [0x48, 0x81, 0xff, 0xc8, 0x00, 0x00, 0x00];
}

@Name("shifts by CL without corrupting either operand")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            sal(ebx);
        }
        return block.finalize();
    }();

    encoded.should == [0xd3, 0xe3];
}

@Name("rejects high-byte registers combined with REX-only registers")
unittest
{
    __traits(compiles, { Block!true block; block.mov(ah, sil); }).should == false;
}

@Name("exchanges extended registers")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            xchg(rax, r9);
        }
        return block.finalize();
    }();

    encoded.should == [0x49, 0x91];
}

@Name("exchanges extended byte registers")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            xchg(r9b, al);
        }
        return block.finalize();
    }();

    encoded.should == [0x41, 0x86, 0xc1];
}

@Name("implements double-precision left shifts")
unittest
{
    __traits(compiles, { Block!true block; block.shld(eax, ebx, 3); }).should == true;
}

@Name("implements double-precision right shifts")
unittest
{
    __traits(compiles, { Block!true block; block.shrd(eax, ebx, 3); }).should == true;
}

@Name("implements load effective address")
unittest
{
    __traits(compiles, { Block!true block; block.lea(eax, dwordPtr(rbx)); }).should == true;
}
