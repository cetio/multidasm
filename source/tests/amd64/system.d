/// Flags, fences, privileged instructions, string operations, and I/O.
module tests.amd64.system;

import multidasm.amd64;

import unit_threaded;

@Name("sets and clears status flags")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            stc();
            std();
            clc();
        }
        return block.finalize();
    }();

    encoded.should == [0xf9, 0xfd, 0xf8];
}

@Name("waits and fences")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            wait();
            fwait();
            lfence();
            sfence();
            pause();
        }
        return block.finalize();
    }();

    encoded.should == [
        0x9b,
        0x9b,
        0x0f, 0xae, 0xe8,
        0x0f, 0xae, 0xf8,
        0xf3, 0x90
    ];
}

@Name("halts, swaps GS, and monitors")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            hlt();
            swapgs();
            monitor();
        }
        return block.finalize();
    }();

    encoded.should == [
        0xf4,
        0x0f, 0x01, 0xf8,
        0x0f, 0x01, 0xc8
    ];
}

@Name("moves strings")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            movsb();
            cmpsb();
            scasb();
            insb();
        }
        return block.finalize();
    }();

    encoded.should == [0xa4, 0xa6, 0xae, 0x6c];
}

@Name("writes to a port")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            outal(128);
            outal();
        }
        return block.finalize();
    }();

    encoded.should == [0xe6, 0x80, 0xee];
}

@Name("returns from privileged modes")
unittest
{
    enum encoded64 = {
        Block!true block;
        with (block)
        {
            sysret();
            sysexit();
        }
        return block.finalize();
    }();

    enum encoded32 = {
        Block!false block;
        with (block)
        {
            sysret();
            sysexit();
        }
        return block.finalize();
    }();

    encoded64.should == [
        0x48, 0x0f, 0x07,
        0x48, 0x0f, 0x35
    ];

    encoded32.should == [
        0x0f, 0x07,
        0x0f, 0x35
    ];
}

@Name("pauses the thread and invalidates TLB entries")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            tpause(eax);
            invpcid(rax, xmmwordPtr(rbx));
        }
        return block.finalize();
    }();

    encoded.should == [
        0x66, 0x0f, 0xae, 0xf0,
        0x66, 0x48, 0x0f, 0x38, 0x82, 0x03
    ];
}

// Known defects.

@Name("rejects register operands on lgdt")
unittest
{
    __traits(compiles, { Block!true block; block.lgdt(eax); }).should == false;
}

@Name("rejects register operands on clflush")
unittest
{
    __traits(compiles, { Block!true block; block.clflush(al); }).should == false;
}

@Name("rejects register operands on cldemote")
unittest
{
    __traits(compiles, { Block!true block; block.cldemote(al); }).should == false;
}

@Name("rejects memory operands on senduipi")
unittest
{
    __traits(compiles, { Block!true block; block.senduipi(Mem!8(rbx)); }).should == false;
}

@Name("rejects arpl in 64-bit mode")
unittest
{
    __traits(compiles, { Block!true block; block.arpl(ax, bx); }).should == false;
}

@Name("rejects pusha in 64-bit mode")
unittest
{
    __traits(compiles, { Block!true block; block.pusha(); }).should == false;
}

@Name("implements the 64-bit form of lar")
unittest
{
    __traits(compiles, { Block!true block; block.lar(rax, ax); }).should == true;
}

@Name("assigns CPUID feature bits without skipping reserved bits")
unittest
{
    (cast(int) CPUID1_ECX.PCID).should == 17;
    (cast(int) CPUID1_ECX.AVX).should == 28;
    (cast(int) CPUID1_EDX.CX8).should == 8;
    (cast(int) CPUID1_EDX.SEP).should == 11;
    (cast(int) CPUID1_EDX.PBE).should == 31;
}

@Name("declares the MCE CPUID bit")
unittest
{
    static if (__traits(hasMember, CPUID1_EDX, "MCE"))
        true.should == true;
    else
        false.should == true;
}
